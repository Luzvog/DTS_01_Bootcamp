class Nodo():
    def __init__(self, dato):
        self.dato = dato
        self.izq = None
        self.der = None

class Arbol():
    def __init__(self):
        self.raiz = None

    def insertaVal(self, dato):
        n = Nodo(dato)
        bandera=True
        if (self.raiz == None):
            self.raiz = n
        else:
            puntero = self.raiz
            while(bandera==True):
                if (n.dato > puntero.dato):
                    if (puntero.der == None):
                        puntero.der = n
                        bandera=False
                    else:
                        puntero=puntero.der
                elif(n.dato < puntero.dato):
                    if (puntero.izq == None):
                        puntero.izq = n
                        bandera=False
                    else:
                        puntero=puntero.izq
                elif(puntero.dato==n.dato):
                    bandera=False

    def mostrarArbol(self):
        p=self.raiz
        lista=[]
        self.__mostrarArbol(p,lista)
        for i in lista:
            print(i)


    def __mostrarArbol(self,puntero,lista):
        if(puntero.izq != None):
            self.__mostrarArbol(puntero.izq,lista)
        lista.append(puntero.dato)
        if(puntero.der !=None):
            self.__mostrarArbol(puntero.der,lista)


    def buscarval(self,valor):
        puntero=self.raiz
        while(puntero != None):
            if(valor==puntero.dato):
                return True
            elif (valor>puntero.dato):
                puntero=puntero.der
            else:
                puntero=puntero.izq
        return False


def run():
    a = Arbol()
    a.insertaVal(2)
    a.insertaVal(10)
    a.insertaVal(5)
    a.insertaVal(1)
    a.insertaVal(7)
    a.mostrarArbol()
    print(a.buscarval(7))
    print(a.buscarval(4))

if __name__=='__main__':
    run()