(define (utils-first-image)
	(define images (gimp-image-list))
	
	(cond
		((<> 1 (car images))
			(gimp-message "An amount of opened images is not equal to one.")
			#f)
		(else
			(vector-ref (cadr (gimp-image-list)) 0))
	)
)

(define (utils-background-layer image)
	(define layer (car (gimp-image-get-layer-by-name image "Background")))
	
	(cond
		((= layer -1)
			(gimp-message "Layer Background doesn't exist.")
			#f)
		(else
			layer)
	)
)

(define (utils-set-guides image percent)
	(define require-print-error-to-stdout TRUE)
	(define require-print-error-to-console FALSE)
	
	(cond
		((not (require-number-in percent "The guideline padding in percent" 0 0.5)) #f)
		(else
			(define image-width (car (gimp-image-width image)))
			(define image-height (car (gimp-image-height image)))
			
			(gimp-image-add-hguide image (* image-height percent))
			(gimp-image-add-hguide image (* image-height (- 1 percent)))
			(gimp-image-add-vguide image (* image-width percent))
			(gimp-image-add-vguide image (* image-width (- 1 percent)))
			#t
		)
	)
)

