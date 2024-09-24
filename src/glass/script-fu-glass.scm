(define (script-fu-glass
    image
    enable-shadow enable-pixelize
    from-x-in-percent from-y-in-percent
    to-x-in-percent to-y-in-percent
    glass-pixel-size
    glass-blur-radius shadow-blur-radius
    shadow-color)
    
    (require.config.set.print-error-to-stdout FALSE)
    (require.config.set.print-error-to-console TRUE)

    (cond
    	((not (require-number-in from-x-in-percent "An initial X position" 0 to-x-in-percent)) #f)
    	((not (require-number-in from-y-in-percent "An initial Y position" 0 to-y-in-percent)) #f)
        (else
            (define from-x-in-percent (/ from-x-in-percent 100))
            (define from-y-in-percent (/ from-y-in-percent 100))
            (define to-x-in-percent (/ to-x-in-percent 100))
            (define to-y-in-percent (/ to-y-in-percent 100))

            ; Blur area
            (define layer (car (gimp-image-get-layer-by-name image "Background")))

            (cond
                ((= layer -1)
                    (gimp-message (string-append "Backgroun' layer doesn't exist, please create such a layer or rename an existing one to Background"))
                    #f)
                (else
                    (define image-width (car (gimp-image-width image)))
                    (define image-height (car (gimp-image-height image)))

                    (define from-x (* image-width from-x-in-percent))
                    (define from-y (* image-height from-y-in-percent))
                    (define to-x (* image-width to-x-in-percent))
                    (define to-y (* image-height to-y-in-percent))

                    (define width (- to-x from-x))
                    (define height (- to-y from-y))

                    (gimp-image-undo-group-start image)
                    (gimp-context-push)
                    (gimp-image-select-rectangle image CHANNEL-OP-REPLACE from-x from-y width height)
                    
                    (if (= enable-pixelize TRUE)
                    	(plug-in-pixelize RUN-NONINTERACTIVE image layer glass-pixel-size)
                    )
                    
                    (plug-in-gauss RUN-NONINTERACTIVE image layer glass-blur-radius glass-blur-radius 1)

                    ; Add shadow
                    (if (= enable-shadow TRUE)
                    	(begin
						    (define shadow-layer (car (gimp-layer-new image image-width image-height RGBA-IMAGE "Shadow" 100 NORMAL-MODE)))
						    
						    (gimp-image-insert-layer image shadow-layer 0 0)
						    (gimp-context-set-background shadow-color)
						    (gimp-edit-fill shadow-layer FILL-BACKGROUND)
						    (gimp-selection-none image)
						    (plug-in-gauss RUN-NONINTERACTIVE image shadow-layer shadow-blur-radius shadow-blur-radius 0)
						    (gimp-image-select-rectangle image CHANNEL-OP-REPLACE from-x from-y width height)
						    (gimp-edit-clear shadow-layer)
						    (gimp-image-merge-visible-layers image CLIP-TO-BOTTOM-LAYER)
						)
                    )

                    (gimp-image-undo-group-end image)
                    (gimp-context-pop)
                    (require.config.reset)
                    (gimp-displays-flush)
                    #t
                )
            )
        )
    )
)

(script-fu-register
    "script-fu-glass"
    "Glass effect"
    "Create a glass effect with a shadow."
    "Maisa Unbelievable"
    "copyright 2024, Maisa Unbelievable"
    "September 15, 2024"
    ""
    SF-IMAGE "" 1
    SF-TOGGLE "Whether to add a shadow" TRUE
    SF-TOGGLE "Whether to pixelize a blurred area at first" TRUE 
    SF-ADJUSTMENT "An initial X coordinate in percent" '(10 0 100 1 10 0 SF-SPINNER)
    SF-ADJUSTMENT "An initial Y coordinate in percent" '(10 0 100 1 10 0 SF-SPINNER)
    SF-ADJUSTMENT "A final X coordinate in percent" '(90 0 100 1 10 0 SF-SPINNER)
    SF-ADJUSTMENT "A final Y coordinate in percent" '(90 0 100 1 10 0 SF-SPINNER)
    SF-ADJUSTMENT "A glass pixel size" '(20 0 200 5 10 0 SF-SPINNER)
    SF-ADJUSTMENT "A glass blur radius" '(25 0 200 5 10 0 SF-SPINNER)
    SF-ADJUSTMENT "A glass shadow blur radius" '(40 0 200 5 10 0 SF-SPINNER)
    SF-COLOR "Shadow color" '(0 0 0)
)

(script-fu-menu-register "script-fu-glass" "<Image>/Filters")

