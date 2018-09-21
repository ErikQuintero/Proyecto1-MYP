require "socket"
require "thread"

class Cliente
	#thread
    attr_accessor :name, :socket, :thread
    def initialize(nombre, estado, socket, text, serial)
        @nombre = nombre
        @estado = estado
        @socket = socket
        @serial = serial
        #@thread = thread
        @text = " "
    end
    
    def getEstado
    	return estado 
    end
    
    def getNombre
    	return nombre 
    end  
    
    def getText 
    	return text
    end 
    
    def setText(s)
    	@text = s
    end 
    
    def setEtado(e)
    	@estado = estado 
    end
    
    def enviarMensaje(s)
    	socket.puts(s)
    end
    
    def recibirMensaje
    	while true 
    		recibido = socket.recv(1024)
    	end 	
    end 
    
end

text = " "
puts "Dame el host"
red = gets.chomp
puts "Dame el puerto"
port = Integer(gets.chomp)
socket = TCPSocket.new(red,port)
cliente = Cliente.new("Erik", "ACTIVE", socket, text, 0)

# Permite que el cliente ingrese texto en el chat de manera iterativa que sera
# enviado a todos los usuario que se encuentren conectado al servidor.
# El cliente sale cuando la letra q es tipeada y enviada.
while text != "DISCONNECT"
	print"[Mensaje:] " 
	text = STDIN.gets.chomp
    cliente.enviarMensaje(text)
end
socket.close
