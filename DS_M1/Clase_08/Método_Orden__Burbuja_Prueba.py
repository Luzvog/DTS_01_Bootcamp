def serialize(arr):
    """Serialize an array into a format the visualizer can understand."""
    formatted = {
        "kind": {"grid": True},
        "rows": [
            {
                "columns": [
                    {"content": str(value), "tag": str(value)} for value in arr
                ],
            }
        ],
    }
    return formatted

lista = [0, 13, 2, 10, 4, 5, 8, 7, 6, 18, 3, 11, 12, 1, 14, 15, 16, 17, 9, 19]

serialized = serialize(lista)

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
            serialized = serialize(lista)
            switch = True
    if (not switch):
        break
print(lista)

