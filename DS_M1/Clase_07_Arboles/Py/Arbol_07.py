class Nodo:
    def __init__(self, dato):
        self.izq = None
        self.der = None
        self.dato = dato

    def insertaVal(self, dato):
        if self.dato:
            if dato < self.dato:
                if self.izq == None:
                    self.izq = Nodo(dato)
                else:
                    self.izq.insertaVal(dato)
            elif dato > self.dato:
                if self.der == None:
                    self.der = Nodo(dato)
                else:
                    self.der.insertaVal(dato)
        else:
            self.dato = dato

    def buscaVal(self, lkpval):
        if lkpval < self.dato:
            if self.izq == None:
                return False
            return self.izq.buscaVal(lkpval)
        elif lkpval > self.dato:
            if self.der == None:
                return False
            return self.der.buscaVal(lkpval)
        else:
            return True

    def verVal(self):
        if self.izq:
            self.izq.verVal()
        print(self.dato)
        if self.der:
            self.der.verVal()


def run():
    root = Nodo(10)
    root.insertaVal(3)
    root.insertaVal(13)
    root.insertaVal(1)
    root.insertaVal(8)
    root.insertaVal(20)

if __name__=='__main__':
    run()