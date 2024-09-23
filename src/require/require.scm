(define require-print-error-to-stdout TRUE)
(define require-print-error-to-console FALSE)

(define (--require-error message)
	(if (equal? require-print-error-to-stdout TRUE)
		(print message))
	(if (equal? require-print-error-to-console TRUE)
		(gimp-message message))
	#f)

(define (--require-type value name type procedure)
	(cond
		((not (string? name))
			(--require-error "name should be a string"))
		((not (string? type))
			(--require-error "type should be a string"))
		((not (procedure? procedure))
			(--require-error "procedure should be a procedure"))
		((zero? (string-length name))
			(--require-error "name length should be greater than 0"))
		((zero? (string-length type))
			(--require-error "type length should be greater than 0"))
		(else
			(if (not (procedure value))
				(--require-error (string-append name " should be " type))
				#t))))

(define (--require-type-with-range
	value name
	type procedure
	range-procedure from to)
	
	(cond
		((not (procedure? range-procedure))
			(--require-error "range-procedure should be a procedure"))
		((not (number? from))
			(--require-error "from should be a number"))
		((not (number? to))
			(--require-error "to should be a number"))
		((> from to)
			(--require-error "to should be less than to"))
		((not (--require-type value name type procedure)) #f)
		(else
			(if (not (range-procedure value from to))
				(--require-error (string-append name " should be in " (number->string from) ".." (number->string to) " range"))
				#t))))

(define (require-boolean value name)
	(--require-type value name "boolean" boolean?))

(define (require-number value name)
	(--require-type value name "number" number?))

(define (require-char value name)
	(--require-type value name "char" char?))

(define (require-string value name)
	(--require-type value name "string" string?))

(define (require-list value name)
	(--require-type value name "list" list?))

(define (require-number-in value name from to)
	(--require-type-with-range value name "number" number? (lambda (value) (and (>= value from) (<= value to))) from to))

(define (require-string-in value name from to)
	(--require-type-with-range value name "string" string? (lambda (value) (and (>= (string-length value) from) (<= (string-length value) to))) from to))

