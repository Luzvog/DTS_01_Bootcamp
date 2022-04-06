#In[1]:

from os import system

class Jarras:

    # Atributos:
    def __init__(self):
        self.jarra3 = 0
        self.jarra5 = 0       

    # Métodos:
    def LLenarJarra3(self):
        self.jarra3 = 3
    
    def LLenarJarra5(self):
        self.jarra5 = 5
    
    def VaciarJarra3(self):
        self.jarra3 = 0
    
    def VaciarJarra5(self):
        self.jarra5 = 0

    def PasarJarra3a5(self):
        CapacidadDisponible = 5 - self.jarra5
        self.jarra5 = self.jarra3 + self.jarra5
        if (self.jarra5 > 5):
            self.jarra5 = 5
        if (CapacidadDisponible < 3):
            self.jarra3 = self.jarra3 - CapacidadDisponible
        else:
            self.jarra3 = 0   

    def PasarJarra5a3(self):
        CapacidadDisponible = 3 - self.jarra3
        self.jarra3 = self.jarra5 + self.jarra3
        if (self.jarra3 > 3):
            self.jarra3 = 3
        self.jarra5 = self.jarra5 - CapacidadDisponible

    def ConsultarCapacidad(self):
        gano = False
        if (self.jarra5 == 4):
            gano = True
        return gano

    def capacidades(self):
        i = 0
        CapacidadDisponible3 = 3 - self.jarra3
        print('Jarra 3________________________________')
        while (i < 3):
            if (i < CapacidadDisponible3):
                print('Capacidad Disponible', '[     ]')
            else:
                print('Capacidad Ocupada   ', '[-----]')
            i += 1
        print('\n')

        i = 0
        CapacidadDisponible5 = 5 - self.jarra5
        print('Jarra 5________________________________')
        while (i < 5):
            if (i < CapacidadDisponible5):
                print('Capacidad Disponible', '[     ]')
            else:
                print('Capacidad Ocupada   ', '[-----]')
            i += 1
        print('\n')
    
    # Métodos de interface de usuario:
    def MostrarComandos(self):
        print('Menú de Comandos')
        print('1. Llenar la jarra de 3 litros.')
        print('2. Llenar la jarra de 5 litros.')
        print('3. Vaciar la jarra de 3 litros.')
        print('4. Vaciar la jarra de 5 litros.')
        print('5. Verter el contenido de la jarra de 3 litros en la de 5 litros.')
        print('6. Verter el contenido de la jarra de 5 litros en la de 3 litros')
        print('7. Cerrar Juego')
        print('8. Ayuda')
        print('\n')
#In[2]:
# Instanciamiento de la clase:
JuegoJarras = Jarras()
print('Inicio Juego', '\n')
print('>>>OBJETIVO<<<')
print('--------------------------------------------------------------------------------------------------------------------------')
print('El juego donde constas de 2 jarras, de capacidad 5 y 3 litros respectivamente, y debes colocar 4 litros en la jarra de 5L.')
print('--------------------------------------------------------------------------------------------------------------------------', '\n')

# Interface de usuario.
DetenerJuego = False    
while (DetenerJuego == False):
    print('Capacidades actuales de las jarras')
    JuegoJarras.capacidades()
    JuegoJarras.MostrarComandos()
    comandos = ['1', '2', '3', '4', '5', '6', '7', '8']
    print('Ingrece Comando :')
    comando = input()
    ctrl = False
    while (ctrl == False):
        if (comando in  comandos):
            ctrl = True
            if (comando == '1'):
                JuegoJarras.LLenarJarra3()
            if (comando == '2'):
                JuegoJarras.LLenarJarra5()
            if (comando == '3'):
                JuegoJarras.VaciarJarra3()
            if (comando == '4'):
                JuegoJarras.VaciarJarra5()
            if (comando == '5'):
                JuegoJarras.PasarJarra3a5()
            if (comando == '6'):
                JuegoJarras.PasarJarra5a3()
            if (comando == '7'):
                DetenerJuego = True
            if (comando == '8'):
                print('>>>OBJETIVO<<<', '\n')
                print('El juego donde constas de 2 jarras, de capacidad 5 y 3 litros respectivamente, y debes colocar 4 litros en la jarra de 5L.')
                print('--------------------------------------------------------------------------------------------------------------------------', '\n')
        else:
            print('Ingrece Comando: ', '\n')
            comando = input()            
    
    ganador = JuegoJarras.ConsultarCapacidad()
    if (ganador == True):
        print('>>>GANASTE<<<', '\n')
        print('Capacidades actuales de las jarras', '\n')
        JuegoJarras.capacidades()
        DetenerJuego = True