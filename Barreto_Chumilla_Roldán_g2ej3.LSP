(defun c:ej3()
  (setearEstado)
  (setvar "isolines" 20)
  (setvar "surftab1" 20)
  (setvar "surftab2" 20)

  (setq p1 (getpoint "\nIngrese punto base de la lapicera")) ;Boton trasero
  (setq altura(getint "\nIngrese altura de la lapicera: "))
  
  (command "-layer" "n" "agarradera" "c" 3 "agarradera" "")

  (command "sphere" p1 (* 0.02 altura))
  (setq esfera1(entlast))

  (setq p2 (list (nth 0 p1) (nth 1 p1) (+(nth 2 p1)(* 0.07 altura))))
  (command "cylinder" p1 (* 0.02 altura) (* 0.07 altura))
  (setq cilindro1(entlast))

  (command "subtract" esfera1 "" cilindro1 "" "")
  (setq taponcito(entlast))
  
  (command "cylinder" p1 (* 0.02 altura) (* 0.07 altura))
  (setq cilindro2(entlast))

  (command "union" taponcito cilindro2 "")
  (setq tapon(entlast))

  (command "cylinder" p2 (* 0.035 altura) (* 0.48 altura))
  (setq mango(entlast))

  (setq p3 (list (nth 0 p1) (nth 1 p1) (+(nth 2 p2)(* 0.48 altura))))

  (command "cylinder" p3 (* 0.035 altura) (* 0.3 altura))
  (setq agarradera1(entlast))

  (setq pCilindro (list (+(nth 0 p1)(* 0.035 altura)) (nth 1 p1) (nth 2 p3)))

  (command "-layer" "s" "agarradera" "")
  (command "cylinder" pCilindro (* 0.005 altura) (* 0.3 altura))
  (setq cilindroAgarradera(entlast))

  (command "array" cilindroAgarradera "" "p" p2 10 "" "")
  (setq cilindroArray (ssget "X" '((8 . "agarradera"))))

  (command "subtract" cilindroArray "" agarradera1 "" "")
  (setq cilindros(entlast))


  (command "-layer" "s" "0" "")
  (command "cylinder" p3 (* 0.035 altura) (* 0.3 altura))
  (setq agarradera2(entlast))

  (command "union" cilindros agarradera2 "")
  (setq agarradera(entlast))

  (setq p4 (list (nth 0 p1) (nth 1 p1) (+(nth 2 p3)(* 0.3 altura))))
  (command "cone" p4 (* 0.035 altura) (* 0.13 altura))
  (setq punta(entlast))


  (setq puntoClip1 (list (-(nth 0 p1)(* 0.005 altura)) (+(nth 1 p1)(* 0.035 altura)) (nth 2 p2)))
  (setq puntoClip2 (list (+(nth 0 p1)(* 0.005 altura)) (+(nth 1 puntoClip1)(* 0.01 altura)) (+(nth 2 p2)(* 0.01 altura))))
  (command "box" puntoClip1 puntoClip2)
  (setq clip1 (entlast))

  (setq puntoClip3 (list (nth 0 puntoClip1) (-(nth 1 puntoClip2)(* 0.005 altura)) (+(nth 2 puntoClip1)(* 0.2 altura))))
  (command "box" puntoClip2 puntoClip3)
  (setq clip2 (entlast))

  (command "union" clip1 clip2 "")
  (setq clip(entlast))
  
  (command "union" tapon mango punta clip "")


  (resetearEstado)
  )



(defun setearEstado()
  (setq snap(getvar "osmode"))
  (setvar "osmode" 0)
)

(defun resetearEstado()
  (setvar "osmode" snap)
)