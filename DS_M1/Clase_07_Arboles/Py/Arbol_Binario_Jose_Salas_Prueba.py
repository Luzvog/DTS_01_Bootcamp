
class Nodo():
    #Atributos
    def __init__(self, dato):
        self.dato = dato 
        self.izq = None
        self.der = None
    
class ArbolBinario():
    #Atributos
    def __init__(self):
        self.raiz = None

    #Métodos
    #Insertar Valor
    def recursiva(self, n, dato):            
        if (n is None):
            n = Nodo(dato)                
        elif (dato < self.raiz.dato):
            n.izq = self.recursiva(n.izq, dato)
        elif  (dato > self.raiz.dato):
            n.der = self.recursiva(n.der, dato)
        
        return n

    def inser_val(self, dato):
        self.raiz = self.recursiva(self.raiz, dato)




    #Imprimir Valor

def prueba_ArbolBinario():
    arbl_bin = ArbolBinario()
    arbl_bin.inser_val(10)
    arbl_bin.inser_val(9)
    arbl_bin.inser_val(8)
    arbl_bin.inser_val(11)
    arbl_bin.inser_val(12)
    arbl_bin.inser_val(13)
    #lista_enlazada.imprimir()
    #lista_enlazada.contar_lista()
    #lista_enlazada.buscar(10)
    #lista_enlazada.inser_en(dato = 11.5, indice = 4)
    #lista_enlazada.remover_en(4)


if __name__ == "__main__":
    prueba_ArbolBinario()