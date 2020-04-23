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

;;(define-struct Pat
;;  ([shapes : Image]
;;   [color : Image-Color]
;;   [loc : Loc]))

(define-struct Style
  ([pattern : (U 'pattern1 'pattern2 'pattern3)]
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
           (rectangle 3 0 'solid 'black) 
           (duplicate-beside (- num-dup 1) Img))]))


(: duplicate-above : Integer Image -> Image)

;; The duplicate-beside function will duplicate any image however many
;; times it is asked to be duplicated. The duplicates will appear beside the
;; original.

(define (duplicate-above num-dup Img)
  (cond
    [(<= num-dup 0) empty-image]
    [else (above
           Img
           (rectangle 3 0 'solid 'black) 
           (duplicate-above (- num-dup 1) Img))]))

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
      (rectangle 3 0 'solid 'black) 
      (vanishing Frac (scale Frac Img)))]))

;=================== Draw
(: draw : PixelWorld -> Image)
;; will compile images
(define (draw PixWorld)
  (match PixWorld
    [(PixelWorld style)
     (match style
       [(Style pattern1 img-clr x)
        (overlay/align "middle" "middle"
                       (above
                        (duplicate-beside 4 (square (/ x 10) 'solid img-clr))
                        (square 10 'solid 'black)
                        (duplicate-beside 8 (square (/ x 10) 'solid img-clr))
                        (square 10 'solid 'black)
                        (duplicate-beside 12 (square (/ x 10) 'solid img-clr))
                        (square 10 'solid 'black)
                        (duplicate-beside 16 (square (/ x 10) 'solid img-clr))
                        (square 10 'solid 'black)
                        (duplicate-beside 12 (square (/ x 10) 'solid img-clr))
                        (square 10 'solid 'black)
                        (duplicate-beside 8 (square (/ x 10) 'solid img-clr))
                        (square 10 'solid 'black)
                        (duplicate-beside 4 (square (/ x 10) 'solid img-clr)))
                       (above
                        (duplicate-beside 4 (square (/ x 5) 'solid 'pink))
                        (square 10 'solid 'black)
                        (duplicate-beside 8 (square (/ x 5) 'solid 'orange))
                        (square 10 'solid 'black)
                        (duplicate-beside 12 (square (/ x 5) 'solid 'yellow))
                        (square 10 'solid 'black)
                        (duplicate-beside 16 (square (/ x 5) 'solid 'green))
                        (square 10 'solid 'black)
                        (duplicate-beside 12 (square (/ x 5) 'solid 'purple))
                        (square 10 'solid 'black)
                        (duplicate-beside 8 (square (/ x 5) 'solid 'teal))
                        (square 10 'solid 'black)
                        (duplicate-beside 4 (square (/ x 5) 'solid 'orange)))
                       (square 1000 'solid 'black))]
       [(Style pattern2 img-clr x)
        (overlay/align "middle" "middle"
                       (above
                        (vanishing (/ 1 8) (triangle (/ x 10) 'solid img-clr))
                        (square 10 'solid 'black)
                        (vanishing (/ 1 8) (triangle (/ x 10) 'solid img-clr))
                        (square 10 'solid 'black)
                        (vanishing (/ 1 8) (triangle (/ x 10) 'solid img-clr))
                        (square 10 'solid 'black)
                        (vanishing (/ 1 8) (triangle (/ x 10) 'solid img-clr))
                        (square 10 'solid 'black)
                        (vanishing (/ 1 8) (triangle (/ x 10) 'solid img-clr))
                        (square 10 'solid 'black)
                        (vanishing (/ 1 8) (triangle (/ x 10) 'solid img-clr))
                        (square 10 'solid 'black)
                        (vanishing (/ 1 8) (triangle (/ x 10) 'solid img-clr)))
                       (above
                        (vanishing (/ 1 3) (triangle (/ x 5) 'solid 'pink))
                        (square 10 'solid 'black)
                        (vanishing (/ 1 3) (triangle (/ x 5) 'solid 'orange))
                        (square 10 'solid 'black)
                        (vanishing (/ 1 3) (triangle (/ x 5) 'solid 'yellow))
                        (square 10 'solid 'black)
                        (vanishing (/ 1 3) (triangle (/ x 5) 'solid 'green))
                        (square 10 'solid 'black)
                        (vanishing (/ 1 3) (triangle (/ x 5) 'solid 'purple))
                        (square 10 'solid 'black)
                        (vanishing (/ 1 3) (triangle (/ x 5) 'solid 'teal))
                        (square 10 'solid 'black)
                        (vanishing (/ 1 3) (triangle (/ x 5) 'solid 'orange)))
                       (square 1000 'solid 'pink))]
       [(Style pattern3 img-clr x)
        (overlay/align "middle" "middle"
                       (above
                        (duplicate-beside 4 (circle (/ x 10) 'solid img-clr))
                        (square 10 'solid 'black)
                        (duplicate-beside 8 (circle (/ x 10) 'solid img-clr))
                        (square 10 'solid 'black)
                        (duplicate-beside 12 (circle (/ x 10) 'solid img-clr))
                        (square 10 'solid 'black)
                        (duplicate-beside 16 (circle (/ x 10) 'solid img-clr))
                        (square 10 'solid 'black)
                        (duplicate-beside 12 (circle (/ x 10) 'solid img-clr))
                        (square 10 'solid 'black)
                        (duplicate-beside 8 (circle (/ x 10) 'solid img-clr))
                        (square 10 'solid 'black)
                        (duplicate-beside 4 (circle (/ x 10) 'solid img-clr)))
                       (above
                        (duplicate-beside 4 (circle (/ x 5) 'solid 'pink))
                        (square 10 'solid 'black)
                        (duplicate-beside 8 (circle (/ x 5) 'solid 'orange))
                        (square 10 'solid 'black)
                        (duplicate-beside 12 (circle (/ x 5) 'solid 'yellow))
                        (square 10 'solid 'black)
                        (duplicate-beside 16 (circle (/ x 5) 'solid 'green))
                        (square 10 'solid 'black)
                        (duplicate-beside 12 (circle (/ x 5) 'solid 'purple))
                        (square 10 'solid 'black)
                        (duplicate-beside 8 (circle (/ x 5) 'solid 'teal))
                        (square 10 'solid 'black)
                        (duplicate-beside 4 (circle (/ x 5) 'solid 'orange)))
                       (square 1000 'solid 'red))])]))

(: animation : PixelWorld -> PixelWorld)
;; animation will allow box movement.
(define (animation PixWorld)
  (match PixWorld
    [(PixelWorld style)
     (match style
       [(Style pat img-clr x)
        (PixelWorld (Style pat img-clr (if (>= x 100)
                                           (- x 60)
                                           (+ x 15))))])]))
                                       

;============================================================ Patterns

;========================= Pattern1


;========================= Pattern2


;========================= Pattern 3


;================ OSC, Audio Visual Function

(: AV : Int -> Style)
;; AV will take an a volume level (an integer), and convert it
;; into a pattern.
(define (AV x)
  (cond
    [(and
      (>= x 0) (< x 30)) (Style 'pattern1 'firebrick x)]
    [(and
      (>= x 30) (< x 60)) (Style 'pattern2 'purple x)]
    [(and
      (>= x 60) (<= x 100)) (Style 'pattern3 'lightblue x)]
    [else (error "no")]))

(: run : Int -> PixelWorld)
;; make quiz go man
(define (run x)
  (big-bang (PixelWorld (AV x)) : PixelWorld
    [to-draw draw]
    [on-tick animation 1/20]
    ;;  [port 55557]
    ;;  [register "192.168.1.3"]
    [name "PixelMusic 2020"]))
     




(test)