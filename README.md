# plane.lisp
A simple lisp script to generate G-code files for planing a surface

## Usage:

./plane.lisp x y offset

### I.e:

./plane.lisp 10 10 2 

### Generates the following code:

G01 X10 Y0
G01 X10 Y10
G01 X0 Y10
G01 X0 Y2
G01 X8 Y2
G01 X8 Y8
G01 X2 Y8
G01 X2 Y4
G01 X6 Y4
G01 X6 Y6
G01 X4 Y6
G01 X4 Y6


Along with an SVG file to visualize the output

