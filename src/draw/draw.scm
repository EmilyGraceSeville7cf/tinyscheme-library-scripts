(define (draw-rectangle
	image
	layer
	from-x from-y
	to-x to-y
	fill-color)
	
	(require.config.set.print-error-to-stdout TRUE)
    (require.config.set.print-error-to-stdout FALSE)
	
	(cond
		((not (require-number-in from-x "The initial X coordinate" 0 to-x)) #f)
		((not (require-number-in from-y "The initial Y coordinate" 0 to-y)) #f)
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
			(require.config.reset)
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
	
	(require.config.set.print-error-to-stdout TRUE)
    (require.config.set.print-error-to-stdout FALSE)
	
	(cond
		((not (require-number-in from-x "The initial X coordinate" 0 to-x)) #f)
		((not (require-number-in from-y "The initial Y coordinate" 0 to-y)) #f)
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
			(require.config.reset)
			#t
		)
	)
)

