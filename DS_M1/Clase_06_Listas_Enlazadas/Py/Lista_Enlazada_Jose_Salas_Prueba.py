"""
Crear una lista enlazada e implementar los siguientes métodos: Insertar al inicio, insertar al final, buscar valor, ver valor, mostrar longitud, insertar en, remover valor.
"""

from itertools import count
import re
from sqlalchemy import false


class nodo():
    #Atributos:
    def __init__(self, dato, siguiente = None):
        """Está función define las características que configuraran al nodo.

        Args:
            dato (str/ int/ float/ list): información que será almacenada.
        """
        self.dato = dato
        self.siguiente = siguiente

class ListaEnlazada():
    #Atributos
    def __init__(self):
        """Esta función define los atributos de la lista enlazada.
        """
        self.origen = None

    #Métodos
    #Insertar al inicio.
    def inser_ini(self, dato):
        """Este método perimite añadir datos al inicio de la lista

        Args:
            dato (str/ int/ float/ list): información que será almacenada.
        """
        n = nodo(dato)
        if (self.origen):
            n.siguiente = self.origen
            self.origen = n
        else:
            self.origen = n


    #Insertar al final.
    def inser_fin(self, dato):
        """Este método permite añadir datos al final de la lista.

        Args:
            dato (str/ int/ float/ list): información que será almacenada.
        """
        n = nodo(dato)
        if (self.origen):
            i = self.origen
            while (i.siguiente):
                i = i.siguiente
            i.siguiente = n
            pass
        else:
            self.origen = n



    #Insertar en.
    def inser_en(self, indice, dato):
        """Este método permite añadir datos en una posicón intermedia de la lista. Se debe especificar el índice correpondiente a la posición en la cual se quieren almacenar los datos.

        Args:
            indice (int): posición relativa en la cual se desea insertar el nuevo nodo.
            dato (str/ int/ float/ list): información que será almacenada.
        """
        if ((indice < 0) or (indice > self.contar_lista())):
            print("El índice debe ser mayor que 0 y menor que la longutud de la lista")
        
        if (indice == 0):
            self.inser_ini(dato)
            return

        cont = 0
        i = self.origen 
        while i.siguiente:
            if  cont == (indice - 1):
                n = nodo(dato, i.siguiente)
                i.siguiente = n
                break
            i = i.siguiente
            cont += 1

    #Remover en.
    def remover_en(self, indice):
        """Este método permite añadir datos en una posicón intermedia de la lista. Se debe especificar el índice correpondiente a la posición en la cual se quieren almacenar los datos.

        Args:
            indice (int): posición relativa en la cual se desea remover el nodo.
        """
        if ((indice < 0) or (indice > self.contar_lista())):
            print("El índice debe ser mayor que 0 y menor que la longutud de la lista")
        
        if (indice == 0):
            self.origen = self.origen.siguiente
            return

        cont = 0
        i = self.origen 
        while i.siguiente:
            if  cont == (indice - 1):
                i.siguiente = i.siguiente.siguiente
                break
            i = i.siguiente
            cont += 1
        


    #Mostar longitud.
    def contar_lista(self):
        """Este método cuenta el número de nodos que posee la lista, por lo tanto devuelve su extensión.

        Returns:
            int: extención de la lista expresada en número de nodos.
        """
        cont = 0
        if (self.origen):
            cont = 1
            i = self.origen
            while (i.siguiente):
                i = i.siguiente
                cont += 1
            print(f"La lista tiene: {cont} elementos", "\n")
            return cont
        else:
            print(f"La lista tiene: {cont} elementos", "\n")
            return cont



    #Buscar Valor.
    def buscar(self, buscador):
        """Este método busca en la lista el parametro buscado

        Args:
            buscador (str/ int/ float/ list): parametro a ser buscado.

        Returns:
            int: parametro encontrado.
            int: posición relativa del parametro buscado en la lista.
        """
        buscador = buscador
        cont = 0
        if (self.origen):
            i = self.origen
            cont = 1
            if (not buscador == i.dato):
                while (i.siguiente):
                    i = i.siguiente
                    cont += 1
                    if (not buscador == i.dato):
                        pass
                    else:
                        print(f"El parametro {i.dato} está en la lista en la posición {cont}", "\n")
                        return buscador, cont
                pass
            else:
                print(f"El parametro {i.dato} está en la lista en la posición {cont}", "\n")
                return buscador, cont
        else:
            print("La lista está vacía", "\n")


    #Imprimir lista.
    def imprimir(self):
        """Este método permite imprimir la lista en pantalla.
        """
        if (self.origen):
            i = self.origen
            cadena = str(i.dato)
            if (i.siguiente):
                while (i.siguiente):
                    i = i.siguiente
                    cadena = cadena + " ===> " + str(i.dato)
                print(cadena)
            else:
                print(f"La lista tiene un solo elemento: {cadena}")
        else:
            print("La lista está vacía")
            return


def prueba_ListaEnlazada():
    lista_enlazada = ListaEnlazada()
    lista_enlazada.inser_ini(10)
    lista_enlazada.inser_ini(9)
    lista_enlazada.inser_ini(8)
    lista_enlazada.inser_fin(11)
    lista_enlazada.inser_fin(12)
    lista_enlazada.inser_fin(13)
    #lista_enlazada.imprimir()
    #lista_enlazada.contar_lista()
    #lista_enlazada.buscar(10)
    lista_enlazada.inser_en(dato = 11.5, indice = 4)
    lista_enlazada.remover_en(4)


if __name__ == "__main__":
    prueba_ListaEnlazada()