(define (--draw-not-in-range? value description from to)
    (cond
        ((or (< value from) (> value to))
            (gimp-message (string-append description " is not in range " (number->string from) ".." (number->string to)))
            #t)
        (else #f)
    )
)

(define (draw-rectangle
	image
	layer
	from-x from-y
	to-x to-y
	fill-color)
	
	(cond
		((--draw-not-in-range? from-x "The initial X coordinate" 0 to-x) #f)
		((--draw-not-in-range? from-y "The initial Y coordinate" 0 to-y) #f)
		(else
			(gimp-context-push)
			(gimp-image-select-rectangle
				image
				CHANNEL-OP-REPLACE
				from-x from-y
				(- to-x from-x) (- to-y from-y))
			(gimp-context-set-background fill-color)
			(gimp-drawable-edit-fill layer FILL-BACKGROUND)
			(gimp-context-pop)
			#t
		)
	)
)

(define (draw-ellipse
	image
	layer
	from-x from-y
	to-x to-y
	fill-color)
	
	(cond
		((--draw-not-in-range? from-x "The initial X coordinate" 0 to-x) #f)
		((--draw-not-in-range? from-y "The initial Y coordinate" 0 to-y) #f)
		(else
			(gimp-context-push)
			(gimp-image-select-ellipse
				image
				CHANNEL-OP-REPLACE
				from-x from-y
				(- to-x from-x) (- to-y from-y))
			(gimp-context-set-background fill-color)
			(gimp-drawable-edit-fill layer FILL-BACKGROUND)
			(gimp-context-pop)
			#t
		)
	)
)

