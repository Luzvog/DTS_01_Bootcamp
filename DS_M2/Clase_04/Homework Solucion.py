#1. Crear una función que pueda calcular permita calcular a probabilidad de los siguientes eventos en un baraja de 52 cartas.
# - Obtener una carta roja.
# - Obtener una carta roja.
# - Obtener una pica.
# - Obtener un trébol.
# - Obtener un corazón.
# - Obtener un diamante.

def probabilidadNaipes1(categoria):
    cartas = 52
    cartasColor=26
    cartasCategoria=13
    if(categoria=='roja' or categoria=='negra'):
        return cartasColor/cartas
    elif(categoria in ('pica','trebol','corazon','diamante') ):
        return cartasCategoria/cartas

print(probabilidadNaipes1('diamante'))

#2. Crear una función que cálcule la probabilidad de que salga un 7 o un 8 y además el usuario pueda establecer el color.

def probabilidadNaipes2(numero,categoria):
    cartas = 52
    cartasColor=26
    if(numero=='' and (categoria=='negra' or categoria=='roja')):
        return cartasColor/cartas
    elif(numero!='' and (categoria=='negra' or categoria=='roja') ):
        return cartasColor/cartas*2/cartas
    elif(numero!='' and categoria==''):
        return 1/cartas


print(probabilidadNaipes2(1,'roja'))

#3. La probabilidad de tu país gane el mundial de fútbol.

# Se trata de un abordaje subjetivo, ya que se podría abordar desde diferentes perspectivas. 
#https://bit.ly/mundialfutboll

#4. Si la probabilidad de que un cliente pague en efectivo (E) es 6/15, con tarjeta de crédito (TD) es 7/15 y con tarjeta de crédito (TC) es 2/15.
#Hallar la probabilidad de que dos clientes sucesivos que pagan sus cuentas lo hagan:
# a) el primero en efectivo y el segundo con tarjeta de crédito.
# b) Los dos clientes en efectivo

# a) P(E y TC) = P(E) *P(TC) = (6/15) * (7/15) 
# b) P(E y TC) = P(E) *P(TC) = (6/15) * (6/15)

#5. Un experimento que tiene tres resultados es repetido 50 veces y se ve que E1 aparece 20 veces, E2 13 veces y E3 17 veces. Asigne probabilidades a los resultados.

# E1 = 20/50
# E2 = 13/50
# E3 = 17/50

#6.  La probabilidad de que un Henry repruebe el M1 de 0.8, de que apruebe M2 es 0.5 y de que repruebe el M3 es de 0.4. 
# (Los eventos no interfieren entre si)
# Determinar la probabilidad de que:
# a) Apruebe un módulo.
# b) No apruebe ningun módulo.

# a) Aprobar uno y desaprobar los otros dos: 
# [Aprobar M1  = (0.2 * 0.5 * 0.4) + Aprobar M2 = (0.5 * 0.8 * 0.4) + Aprobar M3 = (0.6 * 0.5 * 0.8)] = 0.44

# b) [Desaprobar M1 = 0.8 * Desaprobar M2 = 0.5 * Desaprobar M3 = 0.4] = 0.16