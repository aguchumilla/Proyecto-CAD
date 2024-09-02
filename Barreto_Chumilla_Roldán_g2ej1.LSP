(defun c:ej1()
  (setearEstado)
  (setq lados(getint "\nIngrese la cantidad de lados: "))
  (setq radio(getreal "\nIngrese tamaño de la base: "))
  (setq altura(getreal "\nIngrese altura de la piramide: "))
  (setq p1(getpoint "\nIngrese el centro de la base: "))
 
  (setq p1x(nth 0 p1))
  (setq p1y(nth 1 p1))
  (setq p1z(nth 2 p1))
  
  (setq giro (/ (* 2 pi) lados))
  
  (setq puntaPiramide(list p1x p1y (+ p1z altura)))
  
 
  (setq p1aux (polar p1 0 radio))
  (setq i 1)
  (while (<= i lados)
    (if (= i 1)
      (progn
       (setq p2aux(polar p1 (* giro i) radio))
       (command "3dface" p1aux p2aux puntaPiramide puntaPiramide "") 
      )
      (progn
	(setq p2aux(polar p1 (* giro i) radio))
	(setq iaux i)
	(setq p3aux(polar p1 (* giro (- iaux 1)) radio))
	(command "3dface" p3aux p2aux puntaPiramide puntaPiramide "")
      )
      )
    (setq i(+ i 1))
  )
  (resetearEstado)
  )


(defun setearEstado()
  (setq snap(getvar "osmode"))
  (setvar "osmode" 0)
)

(defun resetearEstado()
  (setvar "osmode" snap)
)