# 📖 Description

Provide utils for drawing.

## 📷 Screenshots

Screenshots are unavailable for this type of script. Consult it's [source code](./draw.scm)
for the provided functionality.

## 📦 API

- `draw-rectangle`  
  **description**: draw a rectangle on the specified layer  
  **inputs**:`image` (image ID), `layer` (layer ID), `from-x` (X coordinate of
  the top-left corner), `from-y` (Y coordinate of the top-left corner), `to-x`
  (X coordinate of the bottom-right corner), `to-y` (Y coordinate of the
  bottom-right corner), `fill-color` (fill color)  
  **outputs**: `#f` | `#t`
- `draw-ellipse`  
  **description**: draw an ellipse on the specified layer  
  **inputs**:`image` (image ID), `layer` (layer ID), `from-x` (X coordinate of
  the top-left corner), `from-y` (Y coordinate of the top-left corner), `to-x`
  (X coordinate of the bottom-right corner), `to-y` (Y coordinate of the
  bottom-right corner), `fill-color` (fill color)  
  **outputs**: `#f` | `#t`
