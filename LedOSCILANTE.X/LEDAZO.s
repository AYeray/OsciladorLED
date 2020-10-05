; Alan Yeray C�rdenas Galeana 7� "B"
PROCESSOR 16F887
#include <xc.inc>
; === BITS DE CONFIGURACI�N ===
CONFIG FOSC=INTRC_NOCLKOUT
CONFIG WDTE=OFF
CONFIG PWRTE=ON
CONFIG MCLRE=OFF
CONFIG CP=OFF
CONFIG CPD=OFF
CONFIG BOREN=OFF
CONFIG IESO=OFF
CONFIG FCMEN=ON
CONFIG DEBUG=ON

CONFIG BOR4V=BOR40V
CONFIG WRT=OFF

;fin de configuraci�n
    
PSECT resetVec,class=CODE,delta=2
resetVec:
PAGESEL puerto
goto puerto
    
    ;Inicio de programa
    
PSECT code

;esta secci�n configura el puerto A como una salida
puerto:
    banksel ANSEL
    clrf ANSEL
    banksel PORTA
    clrf PORTA
    banksel TRISA
    clrf TRISA
    banksel PORTA
    
   ;esta secci�n inicia la secuencia oscilante con el 1 empezando a mover hacia la derecha
derecha: 
    rrf PORTA,1  ;Realiza la operaci�n de recorrer el bit, por lo que el 1 va hacia la derecha
    btfss PORTA,0 ; La condici�n es que si el bit 0 de PortA es 1 (ha terminado el recorrido) pasa ala siguiente secci�n
    goto derecha ; cuando esa condici�n no se ha cumplido, repite el rrf para mover el 1 otra vez
  
    ;esta secci�n inicia cuando el 1 est� totalmente a la derecha para moverlo a la izquierda
izquierda:
    rlf PORTA,1  ;Realiza la operaci�n de recorrer el bit, sin embargo esta vez es a la izquierda
    btfss PORTA,7 ;La condici�n en esta situaci�n es que el bit 7 del puerto A se encuentre en 1, para saltarse al bucle derecha
    goto izquierda ;Si la condici�n no se ha cumplido continua recorriendo el bit
    goto derecha ;Una vez se ha saltado la l�nea anterior, procede a continuar el ciclo sin f�n
    END


