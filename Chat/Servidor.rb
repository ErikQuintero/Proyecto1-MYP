require "socket"

class ServidorDelChat

  def initialize(port)
   @descriptores = Array::new
   @serverSocket = TCPServer.new("", port)
   @serverSocket.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, 1)
   printf("ServidorDelChat iniciado sobre el puerto %d\n", port)
   @descriptores.push(@serverSocket)
  end  
 
  #def enviarMensaje2(mensaje)
  	#@serverSocket.send(mensaje,0)
  #end
  
  def iniciar
    while 1
    res = select( @descriptores, nil, nil, nil )
    	if res != nil 
       	for sock in res[0]
          	if sock == @serverSocket then
            	conexionNueva
          	else
            	if sock.eof? 
             	   str = sprintf("Cliente desconectado %s:%s\n",
              	   sock.peeraddr[2], sock.peeraddr[1])
              		bsAux(str, sock)
              		sock.close
              		@descriptores.delete(sock)
            	else
              		str = sprintf("[%s|%s]: %s",
                	sock.peeraddr[2], sock.peeraddr[1], sock.gets())
              		bsAux( str, sock )
            end
          end
        end
      end
    end
  end
 
  private
  def bsAux(str, omit_sock)
  	@descriptores.each do |clisock|
    	if clisock != @serverSocket && clisock != omit_sock
    	    clisock.write(str)
    	end
    end
    print(str)
  end
 
  def conexionNueva
  	newsock = @serverSocket.accept
  	  @descriptores.push(newsock)
      newsock.write("Estas conectado al ServidorDelChat de Erik.\n")
      str = sprintf("Cliente Unido %s:%s\n", newsock.peeraddr[2], newsock.peeraddr[1])
      bsAux(str, newsock)
  end 
 
end 

puts "Dame el puerto"
p = Integer(gets.chomp)
servidor = ServidorDelChat.new(p)
servidor.iniciar
