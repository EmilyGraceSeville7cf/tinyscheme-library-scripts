# 📖 Description

Provide utils for type checking in scripts.

## 📷 Screenshots

Screenshots are unavailable for this type of script. Consult it's [source code](./require.scm)
for the provided functionality.

## 📦 API

Functions:

- `require-boolean`  
  **description**: print error message if the input is not a boolean value  
  **inputs**: `value` (value), `name` (name)  
  **outputs**: `#f` | `#t`
- `require-number`  
  **description**: print error message if the input is not a number value  
  **inputs**: `value` (value), `name` (name)  
  **outputs**: `#f` | `#t`
- `require-char`  
  **description**: print error message if the input is not a character value  
  **inputs**: `value` (value), `name` (name)  
  **outputs**: `#f` | `#t`
- `require-string`  
  **description**: print error message if the input is not a string value  
  **inputs**: `value` (value), `name` (name)  
  **outputs**: `#f` | `#t`
- `require-list`  
  **description**: print error message if the input is not a list value  
  **inputs**: `value` (value), `name` (name)  
  **outputs**: `#f` | `#t`
- `require-number-in`  
  **description**: print error message if the input is not a number value with a
  value inside from..to range  
  **inputs**: `value` (value), `name` (name), `from` (minimum value), `to`
  (maximum value)  
  **outputs**: `#f` | `#t`
- `require-string-in`  
  **description**: print error message if the input is not a string value with a
  length inside from..to range  
  **inputs**: `value` (value), `name` (name), `from` (minimum length), `to`
  (maximum length)  
  **outputs**: `#f` | `#t`

Variables:

- `require-print-error-to-stdout`  
  **description**: if it's `TRUE` error messages are printed with `print`  
  **default**: `TRUE`
- `require-print-error-to-console`  
  **description**: if it's `TRUE` error messages are printed with
  `gimp-message`  
  **default**: `FALSE`
