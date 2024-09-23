# 📖 Description

> ❗ This script is required by another scripts, make sure it's installed to
> make sure that other scripts function correctly.

Provide utils for type checking in scripts.

## 📷 Screenshots

Screenshots are unavailable for this type of script. Consult it's [source code](./require.scm)
for the provided functionality.

## 📦 API

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

## 🛠️ Configuration

- `require.config.set.print-error-to-stdout`  
  **description**: if this setting is set to `TRUE` error messages are printed
  with `print`  
  **inputs**: `value` (value)  
  **default**: `TRUE`
- `require.config.set.print-error-to-console`  
  **description**: if this setting is set to `TRUE` error messages are printed
  with `gimp-message`  
  **inputs**: `value` (value)  
  **default**: `FALSE`
- `require.config.get.print-error-to-stdout`  
  **description**: get whether error messages are printed with `print`  
  **outputs**: setting value  
- `require.config.get.print-error-to-console`  
  **description**: get whether error messages are printed with `gimp-message`  
  **outputs**: setting value  
- `require.config.reset`  
  **description**: reset config to defaults where just `print` is used  
