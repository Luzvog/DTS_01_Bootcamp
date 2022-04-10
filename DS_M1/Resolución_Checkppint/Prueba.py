class Nodo():
    def __init__(self, dato):
        self.__dato = dato
        self.__siguiente = None

    def getDato(self):
        return self.__dato

    def getSiguiente(self):
        return self.__siguiente

    def setDato(self, val):
        self.__dato = val

    def setSiguiente(self, val):
        self.__siguiente = val

class Lst():
    def __init__(self):
        self.__cabecera = None

    def agregarElemento(self,dato):
        if (self.__cabecera != None):
            puntero = self.__cabecera
            while(puntero != None):
                if(puntero.getSiguiente() == None):
                    puntero.setSiguiente(Nodo(dato))
                    break
                puntero = puntero.getSiguiente()
        else:
            self.__cabecera = Nodo(dato)

    def getCabecera(self):
        return self.__cabecera


def Ret_Pregunta10(lista):

    lista = Lst()
    lista.agregarElemento(1)
    lista.agregarElemento(2)
    lista.agregarElemento(3)
    print(Ret_Pregunta10(lista))

if __name__=='__main__':
    Ret_Pregunta10()