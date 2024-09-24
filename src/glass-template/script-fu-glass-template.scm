(define (script-fu-glass-template
    image
    enable-shadow enable-pixelize
    from-x-in-percent from-y-in-percent
    to-x-in-percent to-y-in-percent
    glass-pixel-size
    glass-blur-radius shadow-blur-radius
    shadow-color
    layout-type split-location-in-percent split-size-in-percent)
    
    (require.config.set.print-error-to-stdout FALSE)
    (require.config.set.print-error-to-console TRUE)
    
	(define original-from-x-in-percent from-x-in-percent)
	(define original-from-y-in-percent from-y-in-percent)
	(define original-to-x-in-percent to-x-in-percent)
	(define original-to-y-in-percent to-y-in-percent)

	(define from-x-in-percent (/ from-x-in-percent 100))
	(define from-y-in-percent (/ from-y-in-percent 100))
	(define to-x-in-percent (/ to-x-in-percent 100))
	(define to-y-in-percent (/ to-y-in-percent 100))
	(define split-location-in-percent (/ split-location-in-percent 100))
	(define split-size-in-percent (/ split-size-in-percent 100))
    
    (define single-layout 0)
    (define horizontal-split-layout 1)
    (define vertical-split-layout 2)
    
    (cond
    	((= layout-type single-layout)
			(script-fu-glass
				image
				enable-shadow enable-pixelize
				original-from-x-in-percent original-from-y-in-percent
				original-to-x-in-percent original-to-y-in-percent
				glass-pixel-size
				glass-blur-radius shadow-blur-radius
				shadow-color))
		
		((= layout-type horizontal-split-layout)            
			(define image-width (car (gimp-image-width image)))
			(define image-height (car (gimp-image-height image)))

			(define from-x (* image-width from-x-in-percent))
			(define from-y (* image-height from-y-in-percent))
			(define to-x (* image-width to-x-in-percent))
			(define to-y (* image-height to-y-in-percent))

			(define width (- to-x from-x))
			(define height (- to-y from-y))
		
			(define split-y (+ from-y (* height split-location-in-percent)))
			(define split-shift (/ (* height split-size-in-percent) 2))
            
            (define split-location-minimum-in-percent (* (/ split-shift height) 100))
            (define split-location-maximum-in-percent (* (/ (- height split-shift) height) 100))
            
            (cond
            	((not (require-number-in (* split-location-in-percent 100) "A split location in percent" split-location-minimum-in-percent split-location-maximum-in-percent)) #f)
				(else
					(define top-area-bottom-side-y (- split-y split-shift))
            		(define bottom-area-top-side-y (+ split-y split-shift))

					(define top-area-bottom-side-y-in-percent (* (/ top-area-bottom-side-y image-height) 100))
					(define bottom-area-top-side-y-in-percent (* (/ bottom-area-top-side-y image-height) 100))
					
				    (gimp-image-undo-group-start image)
				    (gimp-context-push)
					
					(if (> top-area-bottom-side-y from-y)
						(script-fu-glass
							image
							enable-shadow enable-pixelize
							original-from-x-in-percent original-from-y-in-percent
							original-to-x-in-percent top-area-bottom-side-y-in-percent
							glass-pixel-size
							glass-blur-radius shadow-blur-radius
							shadow-color))
					
					(if (< bottom-area-top-side-y to-y)
						(script-fu-glass
							image
							enable-shadow enable-pixelize
							original-from-x-in-percent bottom-area-top-side-y-in-percent
							original-to-x-in-percent original-to-y-in-percent
							glass-pixel-size
							glass-blur-radius shadow-blur-radius
							shadow-color)
						)

                    (gimp-image-undo-group-end image)
                    (gimp-context-pop)
                    (require.config.reset)
                    #t
				)
			)
		)
		
		((= layout-type vertical-split-layout)            
			(define image-width (car (gimp-image-width image)))
			(define image-height (car (gimp-image-height image)))

			(define from-x (* image-width from-x-in-percent))
			(define from-y (* image-height from-y-in-percent))
			(define to-x (* image-width to-x-in-percent))
			(define to-y (* image-height to-y-in-percent))

			(define width (- to-x from-x))
			(define height (- to-y from-y))
		
			(define split-x (+ from-x (* width split-location-in-percent)))
			(define split-shift (/ (* width split-size-in-percent) 2))
            
            (define split-location-minimum-in-percent (* (/ split-shift width) 100))
            (define split-location-maximum-in-percent (* (/ (- width split-shift) width) 100))
            
            (cond
            	((not (require-number-in (* split-location-in-percent 100) "A split location in percent" split-location-minimum-in-percent split-location-maximum-in-percent)) #f)
				(else
					(define left-area-right-side-x (- split-x split-shift))
            		(define right-area-left-side-x (+ split-x split-shift))

					(define left-area-right-side-x-in-percent (* (/ left-area-right-side-x image-height) 100))
					(define right-area-left-side-x-in-percent (* (/ right-area-left-side-x image-height) 100))
					
				    (gimp-image-undo-group-start image)
				    (gimp-context-push)
					
					(if (> left-area-right-side-x from-x)
						(script-fu-glass
							image
							enable-shadow enable-pixelize
							original-from-x-in-percent original-from-y-in-percent
							left-area-right-side-x-in-percent original-to-y-in-percent
							glass-pixel-size
							glass-blur-radius shadow-blur-radius
							shadow-color))
					
					(if (< right-area-left-side-x to-x)
						(script-fu-glass
							image
							enable-shadow enable-pixelize
							right-area-left-side-x-in-percent original-from-x-in-percent
							original-to-x-in-percent original-to-y-in-percent
							glass-pixel-size
							glass-blur-radius shadow-blur-radius
							shadow-color)
						)

                    (gimp-image-undo-group-end image)
                    (gimp-context-pop)
                    (require.config.reset)
                    #t
				)
			)
		)
	)
)

(script-fu-register
    "script-fu-glass-template"
    "Glass effect with multiple blurred areas"
    "Create glass effects with shadows."
    "Maisa Unbelievable"
    "copyright 2024, Maisa Unbelievable"
    "September 25, 2024"
    ""
    SF-IMAGE "" 1
    SF-TOGGLE "Whether to add a shadow" TRUE
    SF-TOGGLE "Whether to pixelize blurred areas at first" TRUE 
    SF-ADJUSTMENT "An initial X coordinate in percent of the bounding box" '(10 0 100 1 10 0 SF-SPINNER)
    SF-ADJUSTMENT "An initial Y coordinate in percent of the bounding box" '(10 0 100 1 10 0 SF-SPINNER)
    SF-ADJUSTMENT "A final X coordinate in percent of the bounding box" '(90 0 100 1 10 0 SF-SPINNER)
    SF-ADJUSTMENT "A final Y coordinate in percent of the bounding box" '(90 0 100 1 10 0 SF-SPINNER)
    SF-ADJUSTMENT "A glass pixel size" '(20 0 200 5 10 0 SF-SPINNER)
    SF-ADJUSTMENT "A glass blur radius" '(25 0 200 5 10 0 SF-SPINNER)
    SF-ADJUSTMENT "A glass shadow blur radius" '(40 0 200 5 10 0 SF-SPINNER)
    SF-COLOR "Shadow color" '(0 0 0)
    SF-OPTION "A layout type" '("Single" "Horizontal split" "Vertical split")
    SF-ADJUSTMENT "A split location in percent of the bounding box" '(50 0 100 1 10 0 SF-SPINNER)
    SF-ADJUSTMENT "A split size in percent of the bounding box" '(5 5 100 1 10 0 SF-SPINNER)
)

(script-fu-menu-register "script-fu-glass-template" "<Image>/Filters")

