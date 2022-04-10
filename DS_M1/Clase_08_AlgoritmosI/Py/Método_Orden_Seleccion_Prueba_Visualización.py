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

lista =[1, 12, 7, 0, 16, 8, 6, 2, 5, 14, 10, 11, 4, 13, 9, 15, 19, 17, 3, 18]

serialized = serialize(lista)

for i in range(len(lista)):
    MinInd = i
    for j in range((i + 1), len(lista)):
        if ((lista[j]) < (lista[MinInd])):
            serialized = serialize(lista)
            MinInd = j
    (lista[i], lista[MinInd]) = (lista[MinInd], lista[i])
    serialized = serialize(lista)