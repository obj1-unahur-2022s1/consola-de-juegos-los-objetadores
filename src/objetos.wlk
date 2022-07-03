import wollok.game.*
import visuales.*
import lluviaDeAsteroides.*


object laser {
	var property position = nave.position()
	const property image = "laserChicoFinal.png"
	
	method disparar() {
		game.onTick(70, "disparar",{ self.mover() })
	}
	
	method mover() {
		position = position.up(1)
		if (position.y() == 13 or position == nave.position()) { 
			position = nave.position()
			game.removeTickEvent("disparar")
		}
	}
}

object nave {
	var property position = game.at(7,1)
	var property image = "naveBase.png"
	var property modoCombate = false
	var property asteroidesRotos = 0
	var property vidas = 6
	
	//acciones de la nave vida 
	method chocar(elemento){
		if(self.vidas() == 0){self.explotar()}else{vidas = 0.max(vidas-1);}
	}
	
	method explotar(){
		game.removeVisual(self)
		game.removeVisual(laser)
		game.addVisual(reinicioMensaje)
		game.addVisual(consolaMensaje)
		game.addVisual(menuMensaje)
		game.onTick(7000,"opciones",{self.removerVisualesAux()})
	}
	
	method removerVisualesAux(){
		game.removeVisual(reinicioMensaje)
		game.removeVisual(consolaMensaje)
		game.removeVisual(menuMensaje)
		game.removeTickEvent("opciones")
	}
	
	method decirVidas(){
		game.say(self,"tengo "+self.vidas()+" vidas")	
	}
	
	//
	method activarModoCombate() {
		if (not modoCombate) {
			modoCombate = true
			image = "naveCombate.png"
			game.schedule(9000, { 
				modoCombate = false
				image = "naveBase.png"
			})
		}
	}
	method disparar() { 
		if (modoCombate) {
			laser.disparar()
		}
	}
} 

class Astronauta
	{
 var property position 
 var property image = "vidaAstronauta.png"
 	
 	method iniciarMovimiento()
 		{
 		game.onTick(200, "mover asteroide", { self.mover() })
 		}
 		
 	method mover()
 		{
 		position = position.down(1)
	 // if (position.y() == -4) { game.removeVisual(self) }
 		}
    }
	
class Asteroide {
	var property position 
	var property image 
	const property velocidades = [600, 400, 200]
	const property imagenAux = image
	
	
	//colision
	method auxiliarDespuesChoque(){
		self.volverALaOriginal()
		self.moverPosicionLuegoDeChoque()
		nave.asteroidesRotos(nave.asteroidesRotos()+1)
		game.removeTickEvent("choque asteroide")
	}
	method cambiarLaImagen(){
		self.image("asteroideRoto.png")
	}
	method volverALaOriginal(){
		self.image(imagenAux)
	}
	method moverPosicionLuegoDeChoque(){
		self.position(new Position(x=0.randomUpTo(game.width()).truncate(0), y =12.randomUpTo(14).truncate(0)))
	}
	method metodosChoques(){
		self.cambiarLaImagen()
		self.chocar()
	}
	method chocar(){
		game.onTick(100,"choque asteroide",{self.auxiliarDespuesChoque()})
	}
	method iniciarMovimiento(unaVelocidad) {
		game.onTick(unaVelocidad,"mover asteroide",{ self.mover() })
	}
	method mover() {
		position = position.down(1)
		if (position.y() == -4) { game.removeVisual(self) }
	}
}

const izquierda = game.at(20,5.randomUpTo(15))
const derecha = game.at(-15,5.randomUpTo(15))

class ObjetoVivoEnMenu {
	const listaDeImg
	var property position 
	var property image = listaDeImg.anyOne()
	const velocidad = [400, 600, 800]
	
	method iniciar() {
		if (position==izquierda)
			game.onTick(velocidad.anyOne(),"mover izquierda",{ self.moverIzquierda() })
		else	
			game.onTick(velocidad.anyOne(),"mover derecha",{ self.moverDerecha() })
	}
	method moverIzquierda() {
		position = position.left(1)
		if (position.x() == -15) { 
			image = listaDeImg.anyOne()
			position = game.at(20,(2..10).anyOne())
		}
	}
	method moverDerecha() {
		position = position.right(1)
		if (position.x() == 20) { 
			image = listaDeImg.anyOne()
			position = game.at(-15,(2..10).anyOne())
		}
	}
}

const rocaIzquierda = new ObjetoVivoEnMenu(listaDeImg=rocasMenu, position=izquierda)
const rocaDerecha = new ObjetoVivoEnMenu(listaDeImg=rocasMenu, position=derecha)