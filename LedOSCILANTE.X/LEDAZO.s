; Alan Yeray Cárdenas Galeana 7° "B"
PROCESSOR 16F887
#include <xc.inc>
; === BITS DE CONFIGURACIÓN ===
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

;fin de configuración
    
PSECT resetVec,class=CODE,delta=2
resetVec:
PAGESEL puerto
goto puerto
    
    ;Inicio de programa
    
PSECT code

;esta sección configura el puerto A como una salida
puerto:
    banksel ANSEL
    clrf ANSEL
    banksel PORTA
    clrf PORTA
    banksel TRISA
    clrf TRISA
    banksel PORTA
    
   ;esta sección inicia la secuencia oscilante con el 1 empezando a mover hacia la derecha
derecha: 
    rrf PORTA,1  ;Realiza la operación de recorrer el bit, por lo que el 1 va hacia la derecha
    btfss PORTA,0 ; La condición es que si el bit 0 de PortA es 1 (ha terminado el recorrido) pasa ala siguiente sección
    goto derecha ; cuando esa condición no se ha cumplido, repite el rrf para mover el 1 otra vez
  
    ;esta sección inicia cuando el 1 está totalmente a la derecha para moverlo a la izquierda
izquierda:
    rlf PORTA,1  ;Realiza la operación de recorrer el bit, sin embargo esta vez es a la izquierda
    btfss PORTA,7 ;La condición en esta situación es que el bit 7 del puerto A se encuentre en 1, para saltarse al bucle derecha
    goto izquierda ;Si la condición no se ha cumplido continua recorriendo el bit
    goto derecha ;Una vez se ha saltado la línea anterior, procede a continuar el ciclo sin fín
    END


