#lang typed/racket

(require typed/test-engine/racket-tests)

(require "../includecopy/cs151-core.rkt")
(require "../includecopy/cs151-image.rkt")
(require "../includecopy/cs151-universe.rkt")
(require "../osc/osc/main.rkt")


;====================================================================== Structs

(define-struct Loc
  ([x : Int]
   [y : Int]))

(define-struct Pat
  ([shapes : Image]
   [color : Image-Color]
   [loc : Loc]))

(define-struct Style
  ([pattern : Pat]
   [color : Image-Color]
   [size : Integer]))

(define-struct PixelWorld
  ([visuals : Style]))

;==================================================================== Functions


;==================== Duplicate-Beside


(: duplicate-beside : Integer Image -> Image)

;; The duplicate-beside function will duplicate any image however many
;; times it is asked to be duplicated. The duplicates will appear beside the
;; original.

(define (duplicate-beside num-dup Img)
  (cond
    [(<= num-dup 0) empty-image]
    [else (beside
           Img
           (duplicate-beside (- num-dup 1) Img))]))

;================== Vanishing


(: vanishing : Exact-Rational Image -> Image)

;; The vanishing function will scale the given image by a fraction of its
;; original size. This scaled image will then be placed beside the original.
;; This process will repeat, and occur recursively, until the images width
;; is below a certain threshold, in which the function stops. 

(define (vanishing Frac Img)
  (cond
    [(and
      (<= Frac 0)
      (> Frac 1)) error]
    [(< (image-width Img) .1) empty-image]
    [else
     (beside
      Img
      (vanishing Frac (scale Frac Img)))]))

;=================== Draw
(: draw : PixelWorld -> Image)
;; will compile images
(define (draw PixWorld)
  (match PixWorld
    [(PixelWorld style)
     (match style
       [(Style img-clr p w _)
        (draw-pix p (square w 'solid img-clr))])]))

(: draw-pix : Loc Image -> Image)
;; draw-box will draw the pixels. It's inputs are a given location
;; and whatever image. 

(define (draw-pix loc Img)
  (match loc
    [(Loc x y)
     (place-image Img x y (square 1000 'solid 'black))]))

(: animation : PixelWorld -> PixelWorld)
;; animation will allow box movement.
(define (animation PixWorld)
  (match PixWorld
    [(PixelWorld style)
     (match style
       [(Style img-clr p w h)
        (PixelWorld (Style img-clr p (cond
                                       [(= w 300) (- w 65)]
                                       [else (+ 5 w)]) h))])]))

;============================================================ Patterns

;========================= Pattern1

(define pattern1
  (Pat (circle 20 'solid 'firebrick)))

;========================= Pattern2

(define pattern2
  (Pat (square 20 'solid 'purple)))

;======================== Pattern 3

(define pattern3
  (Pat (triangle 20 'solid 'lightblue)))

;================ OSC, Audio Visual Function

(: AV : Int -> Style)
;; AV will take an integer, a volume level, and convert it
;; into a pattern.
(define (AV x)
  (cond
    [(and
      (>= x 0) (< x 30)) (Style pattern1 (Pat-color pattern1) x)]
    [(and
      (>= x 30) (< x 60)) (Style pattern2 (Pat-color pattern2) x)]
    [(and
      (>= x 60) (<= x 100)) (Style pattern3 (Pat-color pattern3) x)]
    [else (error "no")]))

(: run : Int -> PixelWorld)
;; make quiz go man
(define (run x)
(big-bang (PixelWorld (AV x)) : PixelWorld
  [to-draw draw]
  [on-tick animation 1/10]
;;  [port 55557]
;;  [register "192.168.1.3"]
  [name "PixelMusic 2020"]))
     




(test)