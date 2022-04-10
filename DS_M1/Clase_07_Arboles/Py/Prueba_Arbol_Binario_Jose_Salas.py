# Declaración de Clase: Arbol Binario
class ArbolBinario:
    
    # Atributos:
    def __init__(self, dato):
        self.dato = dato
        self.izq = None
        self.der = None


    # Método añadir dato:
    def InsertaVal(self, dato):
        if (dato == self.dato):
            return 

        # Menores a la izquierda
        # Matores a la derecha

        if dato < self.dato:
            if (self.izq):
                self.izq.InsertaVal(dato)
            else:
                self.izq = ArbolBinario(dato)
        else:
            if (self.der):
                self.der.InsertaVal(dato)
            else:
                self.der = ArbolBinario(dato)
    
    # Método buscar:
    def BuscarVal(self, val):
        if (self.dato == val):
            return True
        if (val < self.dato):
            if (self.izq):
                return self.izq.BuscarVal(val)
            else:
                return False
        if (val > self.dato):
            if (self.der):
                return self.der.BuscarVal(val)
            else:
                return False
    
    # Método imprimir arbol (modo in orden):
    def VerVal(self):
        if self.izq:
            self.izq.VerVal()
        nvl = self.contar()
        print((' ' * 3 * nvl), self.dato)
        if self.der:
            self.der.VerVal()
    
    # Método contar niveles del arbol (modo in orden):
    def contar(self):
        if (self.izq):
            nvl = 0
            i = self.izq
            while i:
                nvl +=1
                i = i.izq
            return nvl
        else:
            nvl = 0
            i = self.der
            while i:
                nvl +=1
                i = i.der
            return nvl

# Inicio sección de debuggeo            
def PruebaArbolBinario():
    raiz = ArbolBinario(10)
    raiz.InsertaVal(3)
    raiz.InsertaVal(13)
    raiz.InsertaVal(1)
    raiz.InsertaVal(8)
    raiz.InsertaVal(20)
    raiz.BuscarVal(5)
    raiz.BuscarVal(3)
    raiz.BuscarVal(7)
    raiz.BuscarVal(10)
    raiz.VerVal()
    
if __name__=='__main__':
    PruebaArbolBinario()