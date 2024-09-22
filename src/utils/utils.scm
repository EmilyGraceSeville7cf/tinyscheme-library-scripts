(define (--utils-not-in-range? value description from to)
    (cond
        ((or (< value from) (> value to))
            (gimp-message (string-append description " is not in range " (number->string from) ".." (number->string to)))
            #t)
        (else #f)
    )
)

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

(define (utils-set-guides image percent)
	(cond
		((--utils-not-in-range? percent "The guideline padding in percent" 0 1) #f)
		(else
			(define image-width (car (gimp-image-width image)))
			(define image-height (car (gimp-image-height image)))

			(gimp-image-add-hguide image (* image-width percent))
			(gimp-image-add-hguide image (* image-width (- 1 percent)))
			(gimp-image-add-vguide image (* image-height percent))
			(gimp-image-add-vguide image (* image-height (- 1 percent)))
		)
	)
)

