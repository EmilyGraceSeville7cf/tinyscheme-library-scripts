# 📖 Description

Provide utils for interactive scripting in Script-Fu Console.

## 📷 Screenshots

Screenshots are unavailable for this type of script. Consult it's [source code](./utils.scm)
for the provided functionality.

## 📦 API

- `utils-first-image`  
  **description**: get image ID if there is one image opened  
  **inputs**: none  
  **outputs**: `#f` | image ID
- `utils-background-layer`  
  **description**: get image *Background* layer if there is one  
  **inputs**:`image` (image ID)  
  **outputs**: `#f` | layer ID
- `utils-set-guides`  
  **description**: set image guides around its center  
  **inputs**:`image` (image ID), `percent` (padding in percent)  
  **outputs**: `#f` | `#t`

## 🛠️ Configuration

Configuration is unavailable for this type of script. Consult it's
[source code](./script-fu-card.scm) for the provided functionality.
