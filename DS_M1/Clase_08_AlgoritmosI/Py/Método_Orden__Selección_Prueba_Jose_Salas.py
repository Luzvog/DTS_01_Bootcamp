def ListaDesordenada(desorden, cantidad):
    '''
    Esta función devuelve una lista
    desorden = es un porcentaje de desordenamiento
    cantidad = cantidad de elementos de la lista
    '''
    import random as r
    import numpy as np

    lista = list(range(0, cantidad))

    desorden = int(cantidad * desorden / 100)

    while (desorden > 0):
        i = r.randint(0,cantidad-1)
        j = r.randint(0,cantidad-1)
        aux = lista[i]
        lista[i] = lista[j]
        lista[j] = aux
        desorden-=1

    return lista

def ord_por_seleccion(lista):
    # Tu código acá:
    for i in range(len(lista)):
        MinInd = i
        for j in range((i + 1), len(lista)):
            if ((lista[j]) < (lista[MinInd])):
                MinInd = j
        (lista[i], lista[MinInd]) = (lista[MinInd], lista[i])
    return lista

# Inicio sección de debuggeo            
def PruebaOrdenSeleccion():
    list1 = []
    list1Ord = []
    list1 = ListaDesordenada(90, 20)
    list1Ord = ord_por_seleccion(list1.copy())
    print(list1)
    print(list1Ord)
    
if __name__=='__main__':
    PruebaOrdenSeleccion()