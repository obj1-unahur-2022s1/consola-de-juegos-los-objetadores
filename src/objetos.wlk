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
		if (position.y() == 13) { 
			game.removeTickEvent("disparar")
			position = nave.position()
		}
	}
}

object nave {
	var property position = game.at(8,1)
	var property image = "naveBase.png"
	var property modoCombate = false
	var property modoInvisible = false
	var property asteroidesRotos = 0
	const property vidas = [astronautaVida0, astronautaVida1, astronautaVida2 ]
	const property vidasCombate = [ naveCombatePoder0, naveCombatePoder1, naveCombatePoder2 ]
	const property vidasInvisibilidad = [ naveInvPoder0, naveInvPoder1, naveInvPoder2 ]
	
	method iniciar() {
		keyboard.x().onPressDo { self.disparar() }
		keyboard.v().onPressDo { self.decirVidas()}
		keyboard.c().onPressDo { self.activarModoInvisibilidad()}
		keyboard.z().onPressDo { self.activarModoCombate() }
	}
	
	
	//acciones de la nave vida 
	method chocar(elemento){
		if (vidas.size() > 0) { self.quitarUnaVida(vidas) } 
		if  (vidas.size() == 0) { 
			self.explotar()
		}
	}
	
	method explotar(){
		self.reiniciarVidas()
		explosion.animacionExplosion()
		juegoAsteroide.terminar()
	}
	
	method decirVidas(){
		game.say(self,"tengo "+vidas.size().toString()+" vidas")	
	}
	
	method activarModoCombate() {
		if (vidasCombate.size() > 0) {
			modoCombate = true
			image = "naveCombate.png"
			self.quitarUnaVida(vidasCombate) 
			game.schedule(10000, { 
				modoCombate = false
				image = "naveBase.png"
			})
		}
		else { game.say(self, "No tengo mas poderes") }
	}
	
	method activarModoInvisibilidad() {
		if (vidasInvisibilidad.size() > 0) {
			modoInvisible = true
			image = "naveInvisible.png"
			self.quitarUnaVida(vidasInvisibilidad) 
			game.schedule(10000, { 
				modoInvisible = false
				image = "naveBase.png"
			})
		}
		else { game.say(self, "No tengo mas poderes") }
	}
	
	method quitarUnaVida(vida) {
			game.removeVisual(vida.last())
			vida.remove(vida.last())
	}
	
	method reiniciarVidas() {
		vidas.clear()
		vidasCombate.clear()
		vidasInvisibilidad.clear()
		vidas.addAll([astronautaVida0, astronautaVida1, astronautaVida2 ])
		vidasCombate.addAll([ naveCombatePoder0, naveCombatePoder1, naveCombatePoder2 ])
		vidasInvisibilidad.addAll([ naveInvPoder0, naveInvPoder1, naveInvPoder2 ])
	}
	
	method disparar() {
		if (modoCombate) { laser.disparar() }
	}
	method configReinicio(){
		self.reiniciarVidas()
		self.position(game.at(7,1))
		laser.position(self.position())
		self.asteroidesRotos(0)
		self.modoCombate(false)
		self.image("naveBase.png")
	}
} 

class Astronauta	{
 	var property position 
 	var property image = "vidaAstronauta.png"
 	
 	method iniciarMovimiento() {
 		game.onTick(200, "mover astronauta", { self.mover() })
 	}
 		
 	method mover() {
 		position = position.down(1)
	    if (position.y() == -4) { game.removeVisual(self) }
 	}
 		
	method metodosChoques(){
		game.removeVisual(self)
		game.removeTickEvent("mover astronauta")
		game.addVisual(mas10)
		score.segundos(score.segundos() + 10)
		game.schedule(2000, { game.removeVisual(mas10)	})
		
	}
}
	
class Asteroide {
	var property position 
	var property image 
	const property velocidades = [120, 50]
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

object explosion{
	var property image = "explosion1.png"
	var  property position = nave.position()
	
	method animacionExplosion(){
		game.removeVisual(nave)
		self.position(nave.position())
		game.addVisual(self)
		game.schedule(100,{self.image("explosion2.png")})
		game.schedule(200,{self.image("explosion3.png")})
		game.schedule(300,{self.image("explosion4.png")})
		game.schedule(400,{self.image("explosion5.png")})
		game.schedule(500,{self.image("explosion6.png")})
		game.schedule(600,{self.image("explosion7.png")})
		game.schedule(700,{self.image("explosion8.png")})
		game.schedule(800,{self.image("explosion9.png")})
		game.schedule(900,{self.image("explosion10.png")})
		game.schedule(1000,{self.image("explosion11.png")})
		game.schedule(1100,{self.image("explosion12.png")})
		game.schedule(1200,{game.removeVisual(self)})
	}
}

object score {
	
	var property segundos = 0
	
	method text() = segundos.toString()
	method textColor() = "#d714b2"
	method position() = game.at(0, 8)
	
	method pasarTiempo() {
		segundos = segundos +1
	}
	method iniciar(){
		segundos = 0
		game.onTick(1000,"tiempo",{self.pasarTiempo()})
	}
	method detener(){
		game.removeTickEvent("tiempo")
	}
}


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