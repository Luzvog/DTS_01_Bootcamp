
lista = [0, 13, 2, 10, 4, 5, 8, 7, 6, 18, 3, 11, 12, 1, 14, 15, 16, 17, 9, 19]

# Recorro la lista:
tope = len(lista)
for i in range(tope -1 ):
    # Comparo con el siguiente elementos:
    switch = False # Variable de control que activará el break 
    # para salir de ciclo cuando ocurra un intercambio en los valores 
    for j in range(tope - 1 - i):
        #condición para hacer el cambio:
        if ((lista[j]) > (lista[j + 1])):
            aux = lista[j]
            lista[j] = lista[j + 1]
            lista[j + 1] = aux
            switch = True
    if (not switch):
        break
print(lista)

