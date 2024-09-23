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

