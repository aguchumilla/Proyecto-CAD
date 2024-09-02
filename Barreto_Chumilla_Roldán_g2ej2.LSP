(defun c:ej3()
  (setearEstado)
  (setvar "isolines" 20)
  (setvar "surftab1" 20)
  (setvar "surftab2" 20)

  (setq punto1 (getpoint "\nIngrese punto base de la lapicera")) ;Boton trasero
  (setq h(getint "\nIngrese altura de la lapicera: "))
  
  (command "-layer" "n" "agarradera" "c" 1 "agarradera" "")

  (command "sphere" punto1 (* 0.02 h))
  (setq esfera1(entlast))

  (setq punto2 (list (nth 0 punto1) (nth 1 punto1) (+(nth 2 punto1)(* 0.07 h))))
  (command "cylinder" punto1 (* 0.02 h) (* 0.07 h))
  (setq cilindro1(entlast))

  (command "subtract" esfera1 "" cilindro1 "" "")
  (setq taponcito(entlast))
  
  (command "cylinder" punto1 (* 0.02 h) (* 0.07 h))
  (setq cilindro2(entlast))

  (command "union" taponcito cilindro2 "")
  (setq pulsador(entlast))

  (command "cylinder" punto2 (* 0.035 h) (* 0.48 h))
  (setq mango(entlast))

  (setq punto3 (list (nth 0 punto1) (nth 1 punto1) (+(nth 2 punto2)(* 0.48 h))))

  (command "cylinder" punto3 (* 0.035 h) (* 0.3 h))
  (setq agarradera1(entlast))

  (setq pCilindro (list (+(nth 0 punto1)(* 0.035 h)) (nth 1 punto1) (nth 2 punto3)))

  (command "-layer" "s" "agarradera" "")
  (command "cylinder" pCilindro (* 0.005 h) (* 0.3 h))
  (setq cilindroAgarradera(entlast))

  (command "array" cilindroAgarradera "" "p" punto2 10 "" "")
  (setq cilindroArray (ssget "X" '((8 . "agarradera"))))

  (command "subtract" cilindroArray "" agarradera1 "" "")
  (setq cilindros(entlast))


  (command "-layer" "s" "0" "")
  (command "cylinder" punto3 (* 0.035 h) (* 0.3 h))
  (setq agarradera2(entlast))

  (command "union" cilindros agarradera2 "")
  (setq agarradera(entlast))

  (setq punto4 (list (nth 0 punto1) (nth 1 punto1) (+(nth 2 punto3)(* 0.3 h))))
  (command "cone" punto4 (* 0.035 h) (* 0.13 h))
  (setq punta(entlast))


  (setq puntoClip1 (list (-(nth 0 punto1)(* 0.005 h)) (+(nth 1 punto1)(* 0.035 h)) (nth 2 punto2)))
  (setq puntoClip2 (list (+(nth 0 punto1)(* 0.005 h)) (+(nth 1 puntoClip1)(* 0.01 h)) (+(nth 2 punto2)(* 0.01 h))))
  (command "box" puntoClip1 puntoClip2)
  (setq clip1 (entlast))

  (setq puntoClip3 (list (nth 0 puntoClip1) (-(nth 1 puntoClip2)(* 0.005 h)) (+(nth 2 puntoClip1)(* 0.2 h))))
  (command "box" puntoClip2 puntoClip3)
  (setq clip2 (entlast))

  (command "union" clip1 clip2 "")
  (setq clip(entlast))
  
  (command "union" pulsador mango punta clip "")


  (resetearEstado)
  )



(defun setearEstado()
  (setq snap(getvar "osmode"))
  (setvar "osmode" 0)
)

(defun resetearEstado()
  (setvar "osmode" snap)
)