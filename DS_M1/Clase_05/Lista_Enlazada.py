
class Node:
    # Atributos
    def __init__(self, dato=None, siguiente=None):
        self.dato = dato
        self.siguiente = siguiente

class ListaEnlazada:
    def __init__(self):
        self.raiz = None

    def AñadirInicio(self, dato):
        n = Node(dato)
        if (self.raiz):
            n.siguiente = self.raiz
            self.raiz = n
        else:
            self.raiz = n

    def AñadirAlfinal(self, dato):
        n = Node(dato)
        if (self.raiz):
            i = self.raiz #n.siguiente
            while i.siguiente:
                i = i.siguiente #n.siguiente
            i.siguiente = n #n.siguiente
            pass
        else:
            self.raiz = n

    


# Inicio sección de debuggeo            
def PruebaListaEnlazada():
    lstlinked = ListaEnlazada()
    lstlinked.AñadirInicio(10)
    lstlinked.AñadirInicio(9)
    lstlinked.AñadirInicio(8)
    lstlinked.AñadirInicio(7)
    lstlinked.AñadirInicio(6)
    lstlinked.AñadirInicio(5)
    lstlinked.AñadirInicio(4)
    lstlinked.AñadirAlfinal(20)
    lstlinked.AñadirAlfinal(21)
    lstlinked.AñadirAlfinal(22)
    lstlinked.AñadirAlfinal(23)
    lstlinked.AñadirAlfinal(24)
    lstlinked.AñadirAlfinal(25)

    
if __name__=='__main__':
    PruebaListaEnlazada()




    

