#lang typed/racket

(require typed/test-engine/racket-tests)

(require "../includecopy/cs151-core.rkt")
(require "../includecopy/cs151-image.rkt")
(require "../includecopy/cs151-universe.rkt")
(require "../osc/osc/main.rkt")


;====================================================================== Structs

(define-struct Style
  ([pattern : (U 'pattern1 'pattern2 'pattern3)]
   [size : Real]))

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
       [(Style 'pattern1 x)
        (overlay/align "middle" "middle"
                       (pattern1 x)
                       (pattern4 x)
                       (square 1000 'solid 'black))]
       [(Style 'pattern2 x)
        (overlay/align "middle" "middle"
                       (pattern2 x)
                       (square 1000 'solid 'black))]
       [(Style 'pattern3 x)
        (overlay/align "middle" "middle"
                       (pattern3 x)
                       (square 1000 'solid 'black))])]))

(: animation : PixelWorld -> PixelWorld)
;; animation will allow box movement.
(define (animation PixWorld)
  (match PixWorld
    [(PixelWorld style)
     (match style
       [(Style pat x)
        (PixelWorld (Style pat (if (>= x 100)
                                   (- x 60)
                                   (+ x 15))))])]))
                                       

;============================================================ Patterns

;========================= Pattern1

(: pattern1 : Real -> Image)
(define (pattern1 x)
  (overlay/align "middle" "middle"
                 (above
                  (duplicate-beside 4 (square (/ x 10) 'solid 'red))
                  (square 10 'solid 'black)
                  (duplicate-beside 8 (square (/ x 10) 'solid 'red))
                  (square 10 'solid 'black)
                  (duplicate-beside 12 (square (/ x 10) 'solid 'red))
                  (square 10 'solid 'black)
                  (duplicate-beside 16 (square (/ x 10) 'solid 'red))
                  (square 10 'solid 'black)
                  (duplicate-beside 12 (square (/ x 10) 'solid 'red))
                  (square 10 'solid 'black)
                  (duplicate-beside 8 (square (/ x 10) 'solid 'red))
                  (square 10 'solid 'black)
                  (duplicate-beside 4 (square (/ x 10) 'solid 'red)))
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
                  (duplicate-beside 4 (square (/ x 5) 'solid 'orange)))))
  


;========================= Pattern2

(: pattern2 : Real -> Image)
(define (pattern2 x)
  (overlay/align "middle" "middle"
                 (above
                  (duplicate-beside 4 (square (/ x 10) 'solid 'white))
                  (square 10  'solid 'black)
                  (duplicate-beside 8 (square (/ x 10) 'solid 'white))
                  (square 10 'solid 'black)
                  (duplicate-beside 12 (square (/ x 10) 'solid 'white))
                  (square 10 'solid 'black)
                  (duplicate-beside 16 (square (/ x 10) 'solid 'white))
                  (square 10 'solid 'black)
                  (duplicate-beside 12 (square (/ x 10) 'solid 'white))
                  (square 10 'solid 'black)
                  (duplicate-beside 8 (square (/ x 10) 'solid 'white))
                  (square 10 'solid 'black)
                  (duplicate-beside 4 (square (/ x 10) 'solid 'white)))
                 (rotate 90
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
                          (duplicate-beside 4 (square (/ x 5) 'solid 'orange))))))


;========================= Pattern 3

(: pattern3 : Real -> Image)
(define (pattern3 x)
  (overlay/align "middle" "middle"
                 (above
                  (duplicate-beside 4 (circle (/ x 10) 'solid 'lemonchiffon))
                  (square 10 'solid 'black)
                  (duplicate-beside 8 (circle (/ x 10) 'solid 'lemonchiffon))
                  (square 10 'solid 'black)
                  (duplicate-beside 12 (circle (/ x 10) 'solid 'lemonchiffon))
                  (square 10 'solid 'black)
                  (duplicate-beside 16 (circle (/ x 10) 'solid 'lemonchiffon))
                  (square 10 'solid 'black)
                  (duplicate-beside 12 (circle (/ x 10) 'solid 'lemonchiffon))
                  (square 10 'solid 'black)
                  (duplicate-beside 8 (circle (/ x 10) 'solid 'lemonchiffon))
                  (square 10 'solid 'black)
                  (duplicate-beside 4 (circle (/ x 10) 'solid 'lemonchiffon)))
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
                  (duplicate-beside 4 (circle (/ x 5) 'solid 'orange)))))

;======================== Pattern 4

(: pattern4 : Real -> Image)
(define (pattern4 x)
  (beside
   (above
    (pattern1 (/ x 3))
    (rectangle 0 400 'solid 'black)
    (pattern1 (/ x 3)))
   (rectangle 400 0 'solid 'black)
   (above
    (pattern1 (/ x 3))
    (rectangle 0 400 'solid 'black)
    (pattern1 (/ x 3)))))
   

;================ OSC, Audio Visual Function

(: AV : Real -> Style)
;; AV will take an a volume level (an integer), and convert it
;; into a pattern.
(define (AV x)
  (cond
    [(and
      (>= x 0) (< x 30)) (Style 'pattern1 x)]
    [(and
      (>= x 30) (< x 60)) (Style 'pattern2 x)]
    [(and
      (>= x 60) (<= x 100)) (Style 'pattern3 x)]
    [else (error "no")]))

(: run : Real -> PixelWorld)
;; make quiz go man
(define (run x)
  (big-bang (PixelWorld (AV x)) : PixelWorld
    [to-draw draw]
    [on-tick animation 1/30]
    ;;  [port 55557]
    ;;  [register "192.168.1.3"]
    [name "PixelMusic 2020"]))
     




(test)