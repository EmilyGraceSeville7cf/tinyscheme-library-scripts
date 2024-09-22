(define (script-fu-card
    image
    card-description
    text-box-height
    card-background-color
    text-box-font text-box-font-size text-box-font-color
    card-enable-image-blur card-enable-image-round card-enable-text-box-blur
    card-image-effect)
    
    (define image-width (car (gimp-image-width image)))
    (define image-height (car (gimp-image-height image)))
    (define layer-count (car (gimp-image-get-layers image)))
    (define layer (car (gimp-image-get-layer-by-name image "Picture")))
    
    (define image-minimal-size 100)
    
    (cond
    	((<> image-width image-height)
    		(gimp-message "The image should have equal width and height")
    		#f)
    	((or (< image-width image-minimal-size) (< image-height image-minimal-size))
    		(gimp-message "The image should have at least " (number->string image-minimal-size) " pixels for width and height")
    		#f)
    	((<> layer-count 1)
    		(gimp-message "The image should have one layer")
    		#f)
    	((= layer -1)
    		(gimp-message "The image should have Picture layer")
    		#f)
    	((equal? card-background-color text-box-font-color)
    		(gimp-message "The card background should be different from the text color")
    		#f)
    	(else
    		; Resize image
    		(gimp-context-push)
    		(gimp-image-undo-group-start image)
    		
    		(define image-size image-width)
    		
    		(define text-box-height-as-float (/ text-box-height 100))
    	
    		(define card-width image-size)
    		(define card-height (* image-size (+ 1 text-box-height-as-float)))
    		
    		(gimp-image-resize image card-width card-height 0 0)
    		
    		; Add background
			(define background (car (gimp-layer-new image card-width card-height RGBA-IMAGE "Background" 100 NORMAL-MODE)))
			
			(gimp-image-insert-layer image background 0 0)
		    (gimp-context-set-background card-background-color)
		    (gimp-edit-fill background FILL-BACKGROUND)
		    (gimp-image-lower-item-to-bottom image background)
			
			; Add text
			(gimp-context-set-foreground text-box-font-color)
			(define text (car (gimp-text-fontname image -1 0 image-width card-description 10 TRUE text-box-font-size PIXELS text-box-font)))
			
			(gimp-text-layer-resize text card-width (- card-height image-height))
			(gimp-text-layer-set-justification text TEXT-JUSTIFY-CENTER)
			
			; Try blur image
        	(if (= card-enable-image-blur TRUE)
            	(begin
            		(define blur-factor 50)
            		(gimp-image-select-rectangle image CHANNEL-OP-REPLACE 0 0 image-width image-height)
            		(plug-in-gauss RUN-NONINTERACTIVE image layer blur-factor blur-factor 0))
            )
			
			; Try additional image effect
			(define cartoon 1)
			(define softglow 2)
			
			(cond
				((= card-image-effect cartoon)
					(plug-in-cartoon RUN-INTERACTIVE image layer 50 0.3))
				((= card-image-effect softglow)
					(plug-in-softglow RUN-INTERACTIVE image layer 10 0.2 1))
			)
			
			; Try round image
        	(if (= card-enable-image-round TRUE)
            	(begin
            		(define round-radius 20)
            		(gimp-image-select-rectangle image CHANNEL-OP-REPLACE 0 0 image-width image-height)
            		(gimp-image-select-round-rectangle image CHANNEL-OP-REPLACE 0 0 image-width image-height round-radius round-radius)
            		(gimp-selection-invert image)
            		(gimp-edit-clear layer))
            )
			
			; Try blur text
        	(if (= card-enable-text-box-blur TRUE)
            	(begin
            		(define blur-factor 20)
            		(gimp-selection-none image)
            		(plug-in-gauss RUN-NONINTERACTIVE image text blur-factor blur-factor 0))
            )
            
            (gimp-image-merge-visible-layers image CLIP-TO-IMAGE)
            
    		(gimp-image-undo-group-end image)
    		(gimp-context-pop)
    		#t
    	)
    )
)

(script-fu-register
    "script-fu-card"
    "Card effect"
    "Create a card effect with a text."
    "Maisa Unbelievable"
    "copyright 2024, Maisa Unbelievable"
    "September 22, 2024"
    ""
    SF-IMAGE "" 1
    SF-STRING "A card description" "Description"
    SF-ADJUSTMENT "A text box height in percent" '(25 25 100 1 10 0 SF-SPINNER)
    SF-COLOR "A card background color" '(255 255 255)
    SF-FONT "A text box font" "Courier 10 Pitch Bold"
    SF-ADJUSTMENT "A text box font size" '(35 10 200 1 10 0 SF-SPINNER)
    SF-COLOR "A text box font color" '(0 0 0)
    SF-TOGGLE "Whether to blur a card image" FALSE
    SF-TOGGLE "Whether to round a card image" FALSE
    SF-TOGGLE "Whether to blur a card description" FALSE
    SF-OPTION "An additional effect applied to an image" '("None" "Cartoon" "Softglow")
)

(script-fu-menu-register "script-fu-card" "<Image>/Filters")

