#lang typed/racket

(require typed/test-engine/racket-tests)

(require "../includecopy/cs151-core.rkt")
(require "../includecopy/cs151-image.rkt")
(require "../includecopy/cs151-universe.rkt")


;====================== Structs

(define-struct Loc
  ([x : Int]
   [y : Int]))

(define-struct PixelWorld
  ([style : Style]))

(define-struct Style
  ([color : Image-Color]
   [placement : Loc]
   [scene-width : Int]
   [scene-height : Int]))


;===================== Functions

(: draw : PixelWorld -> Image)
;; will compile images
(define (draw PixWorld)
  (match PixWorld
    [(PixelWorld style)
     (match style
       [(Style img-clr p w _)
        (draw-pix p (square w 'solid 'red))])]))

(: draw-pix : Loc Image -> Image)
;; draw-box will draw the pixels. It's inputs are a given location
;; and whatever image. 

(define (draw-pix loc Img)
  (match loc
    [(Loc x y)
     (place-image Img x y (square 400 'solid 'black))]))

(: animation : PixelWorld -> PixelWorld)
;; animation will allow box movement.
(define (animation PixWorld)
  (match PixWorld
    [(PixelWorld style)
     (match style
       [(Style img-clr p w h)
        (PixelWorld (Style img-clr p (cond
                                       [(= w 300) (- w 270)]
                                       [else (+ 5 w)]) h))])]))

(: run : Style -> PixelWorld)
;; make quiz go man
(define (run style)
(big-bang (PixelWorld style) : PixelWorld
      [to-draw draw]
      [on-tick animation 1/20]))
     




(test)

