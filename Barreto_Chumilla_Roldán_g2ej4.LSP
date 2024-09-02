(defun c:ej4()

  (setearEstado)

  (setq p1(getpoint "\nIngrese pto. inf. izq."))
  (setq diametro(getreal "\nIngrese diametro de la roldana: "))

  (setq p2(list (nth 0 p1) (+(nth 1 p1)(* 1 diametro)) (nth 2 p1)))
  (setq p3(list (+(nth 0 p1)(* 1.5 diametro)) (nth 1 p2) (nth 2 p1)))
  (setq p4(list (nth 0 p3) (nth 1 p1) (nth 2 p1)))

  (command "rectangle" p1 p3)
  (setq rectanguloAux(entlast))

  (command "fillet" "R" (* 0.2 diametro))
  (command "fillet" "P" rectanguloAux)
  (setq rectangulo(entlast))

  (command "extrude" rectangulo "" (* 0.1 diametro) 0)
  (setq rectangulo1(entlast))

  (command "-layer" "N" "aux" "S" "aux" "")
  
  (setq centroAgujero1(list (+(nth 0 p1)(* 0.2 diametro)) (+(nth 1 p1)(* 0.2 diametro)) (nth 2 p1)))
  (command "cylinder" centroAgujero1 (* 0.04 diametro) (* 0.06 diametro))
  (setq cilindro1(entlast))

  (setq centroAgujero2(list (nth 0 centroAgujero1) (nth 1 centroAgujero1) (+(nth 2 p1)(* 0.1 diametro))))
  (command "cone" centroAgujero2 (* 0.08 diametro) (* -0.08 diametro))
  (setq cono1(entlast))

  (command "subtract" cono1 "" cilindro1 "" "")
  (setq agujero1(entlast))

  (command "cylinder" centroAgujero1 (* 0.04 diametro) (* 0.06 diametro))
  (setq cilindro2(entlast))

  (command "union" agujero1 cilindro2 "")
  (setq cilindroYCono(entlast))

  (setq mitadx1(list (+(nth 0 p1)(/(* 1.5 diametro)2)) (nth 1 p1) (nth 2 p1)))
  (setq mitadx2(list (nth 0 mitadx1) (nth 1 p2) (nth 2 p1)))
  (setq mitady1(list (nth 0 p1) (+(nth 1 p1)(/(* 1 diametro)2)) (nth 2 p1)))
  (setq mitady2(list (nth 0 p4) (nth 1 mitady1) (nth 2 p1)))

  (command "mirror" cilindroYCono "" mitadx1 mitadx2 "")

  (setq agujeros (ssget "X" '((8 . "aux"))))

  (command "mirror" agujeros "" mitady1 mitady2 "")

  (setq agujerosTot(ssget "X" '((8 . "aux"))))

  (command "-layer" "S" "0" "")

  (command "subtract" rectangulo1 "" agujerosTot "" "")

  (setq p1Pared(list (+(nth 0 p1)(* 0.5 diametro)) (nth 1 p1) (+(nth 2 p1)(* 0.1 diametro))))
  (setq p2Pared(list (nth 0 p1Pared) (nth 1 p2) (nth 2 p1Pared)))
  (setq p3Pared(list (nth 0 p1Pared) (nth 1 p2) (+(nth 2 p1Pared)(* 1 diametro))))
  (setq p4Pared(list (nth 0 p1Pared) (nth 1 p1) (nth 2 p3Pared)))

  (command "line" p1Pared p2Pared "")
  (setq linea1(entlast))
  (command "line" p2Pared p3Pared "")
  (setq linea2(entlast))
  (command "line" p3Pared p4Pared "")
  (setq linea3(entlast))
  (command "line" p4Pared p1Pared "")
  (setq linea4(entlast))

  (command "fillet" linea2 linea3)
  (setq curva1(entlast))
  
  (command "fillet" linea3 linea4)
  (setq curva2(entlast))
  
  (command "ucs" "n" "y" "")
  (command "pedit" linea1 "" "J" linea1 linea2 linea3 linea4 curva1 curva2 "" "")
  (setq recPared(entlast))

  (command "extrude" recPared "" (* 0.1 diametro) 0)
  (setq pared(entlast))

  (command "ucs" "")
  (command "mirror" pared "" mitadx1 mitadx2 "")

  (setq pCilindro(list (+(nth 0 p1Pared)(* 0.1 diametro)) (nth 1 mitady1) (+(nth 2 p1Pared)(* 0.75 diametro))))

  (command "-layer" "N" "roldana" "S" "roldana" "C" "1" "" "")
  (command "ucs" "n" "y" "")
  (setq ptCilindro(trans pCilindro 0 1))

  (command "cylinder" ptCilindro (* 0.2 diametro) (* 0.03 diametro))
  (setq cilind1(entlast))

  (command "ucs" "")
  (command "mirror" cilind1 "" mitadx1 mitadx2 "")
  
  (command "-layer" "N" "agujero" "S" "agujero" "C" "2" "" "")
  (setq pCilindro2(list (nth 0 p1Pared) (nth 1 mitady1) (+(nth 2 p1Pared)(* 0.75 diametro))))

  (command "ucs" "n" "y" "")
  (setq ptCilindro2(trans pCilindro2 0 1))

  (command "cylinder" ptCilindro2 (* 0.1 diametro) (* 0.5 diametro))
  (setq agujero2(entlast))
  
  
  (command "-layer" "S" "roldana" "")
  (setq ptRoldana(trans pCilindro 0 1))

  (setq pRoldana (list (nth 0 ptRoldana) (nth 1 ptRoldana) (+(nth 2 ptRoldana)(* 0.03 diametro))))

  (command "cylinder" pRoldana (* 0.5 diametro) (* 0.24 diametro))
  (setq roldana1(entlast))

  (setq pToroide (list (nth 0 pRoldana) (nth 1 pRoldana) (+(nth 2 pRoldana)(* 0.12 diametro))))
  (command "torus" pToroide (* 0.5 diametro) (* 0.08 diametro))
  (setq toroide1(entlast))

  (command "subtract" roldana1 "" toroide1 "" "")


  (resetearEstado)

  )

(defun setearEstado()
  (setq snap(getvar "osmode"))
  (setvar "osmode" 0)
)

(defun resetearEstado()
  (setvar "osmode" snap)
)