def ListaDesordenada(desorden, cantidad):
    """Esta función devuelve una lista
    desorden = es un porcentaje de desordenamiento
    cantidad = cantidad de elementos de la lista

    Args:
        desorden (int): cantidad de elementos de la lista.
        cantidad (int): porcentaje de desorden de la lista.

    Returns:
        list: lista de n elementos desordenada.
    """

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