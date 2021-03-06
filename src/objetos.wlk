import wollok.game.*
import visuales.*
import lluviaDeAsteroides.*

object laser {
	var property position = nave.position()
	const property image = "laserChicoFinal.png"
	
	method disparar() {	game.onTick(70, "disparar",{ self.mover() })}
	method mover() {
		position = position.up(1)
		if (position.y() == 13) { 
			game.removeTickEvent("disparar")
			position = nave.position()
		}
	}
	method metodosChoques(elemento) {}
	method chocar() {}
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
	const property vidasCombateGastadas = []
	const property vidasGastadas = []
	const property vidasInvisibleGastadas = []
	
	method metodosChoques(elemento) {}
	method iniciar() {
		keyboard.x().onPressDo { self.disparar() }
		keyboard.v().onPressDo { self.decirVidas()}
		keyboard.c().onPressDo { self.activarModoInvisibilidad()}
		keyboard.z().onPressDo { self.activarModoCombate() }
	}
	method iniciarVidas() {
		self.vidasCombate().forEach({ v => game.addVisual(v) })
		self.vidas().forEach({ v => game.addVisual(v) })
		self.vidasInvisibilidad().forEach({ v => game.addVisual(v) })
	}
	//acciones de la nave vida 
	method chocar(){
		if (!self.modoInvisible()){
			if (vidas.size() > 0) { self.quitarUnaVida(vidas) } 
			if  (vidas.size() == 0) { self.explotar()}
			else {
				game.addVisual(efectoRojoChoque)
				game.schedule(100 ,{game.removeVisual(efectoRojoChoque)})
			}	
		}
	}
	method explotar(){
		self.reiniciarVidas()
		explosion.animacionExplosion()
		juegoAsteroide.terminar()
	}
	method decirVidas(){ game.say(self,"tengo "+vidas.size().toString()+" vidas")}
	
	method activarModoCombate() {
		if (vidasCombate.size() > 0) {
			modoCombate = true
			image = "naveCombate.png"
			vidasCombateGastadas.add(vidasCombate.last())
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
			vidasInvisibleGastadas.add(vidasInvisibilidad.last())
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
	method agregarVidaCombate(vida){
		vidasCombate.add(vidasCombateGastadas.last())
		game.addVisual(vidasCombateGastadas.last())
		vidasCombateGastadas.remove(vidasCombateGastadas.last())
	}
	method agregarVidaInvisible(vida){
		vidasInvisibilidad.add(vidasInvisibleGastadas.last())
		game.addVisual(vidasInvisibleGastadas.last())
		vidasInvisibleGastadas.remove(vidasInvisibleGastadas.last())
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
		if (modoCombate) { 
			//musica.laser().play()
			laser.disparar()
		}
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
 	
 	method iniciarMovimiento() { game.onTick(300, "mover astronauta", { self.mover() }) }
 	method mover() {
 		position = position.down(1)
	    if (position.y() == -4) { if (game.hasVisual(self)) game.removeVisual(self) game.removeTickEvent("mover astronauta") }
 	}
 	method metodosChoques(elemento){
 		
		game.removeVisual(self)
		game.removeTickEvent("mover astronauta")
		if(elemento != laser){
			game.addVisual(mas10)
			score.segundos(score.segundos() + 10)
			game.schedule(2000, { game.removeVisual(mas10)	})}
		else{
			game.addVisual(menos10)
			score.segundos(score.segundos() - 10)
			game.schedule(2000, { game.removeVisual(menos10)	})}
		}
		
}

class Bateria	{
	var property position 
 	var property image = "bateriaCarga 1.png"
 	
 	
 	method cambioDeColor(){
 		if(game.hasVisual(self)){	
 			game.schedule(1000,{self.image("bateriaCarga 1.png")})
 			game.schedule(2000,{self.image("bateriaCarga 2.png")
 				self.cambioDeColor()
 			})
 		}
 	}
 	method iniciarMovimiento() { game.onTick(500, "mover bateria", { self.mover() }) }
 	method mover() {
 		position = position.down(1)
	    if (position.y() == -4) { if (game.hasVisual(self)) game.removeVisual(self) game.removeTickEvent("mover bateria")}
 	}
 	method metodosChoques(elemento){
		game.removeVisual(self)
		game.removeTickEvent("mover bateria")
		if(self.image()=="bateriaCarga 2.png" and nave.vidasCombate().size()!=3)nave.agregarVidaCombate(elemento)
		if(self.image()=="bateriaCarga 1.png" and nave.vidasInvisibilidad().size()!=3)nave.agregarVidaInvisible(elemento)
		}
}
	
class Asteroide {
	var property position 
	var property image 
	const property imagenAux = image
	
	method velocidad() = 
		if (score.segundos().between(0, 50)) {160}
		else if (score.segundos().between(50, 100)) {120}
		else if (score.segundos().between(100, 150)) {60}
		else {20}
	//colision
	method auxiliarDespuesChoque(){
		if (game.hasVisual(self)) {
			game.removeVisual(self)
			game.schedule(350 ,{game.removeTickEvent("mover asteroide")})
		}
	//	self.volverALaOriginal()
	//	self.moverPosicionLuegoDeChoque()
	//	game.removeTickEvent("choque asteroide")
	}
	method cambiarLaImagen() { self.image("asteroideRoto.png") }
	method volverALaOriginal(){ self.image(imagenAux) }
//	method moverPosicionLuegoDeChoque(){
	//	self.position(new Position(x=0.randomUpTo(game.width()).truncate(0), y =12.randomUpTo(14).truncate(0)))
//	}
//	method chocar(){ game.onTick(100,"choque asteroide",{self.auxiliarDespuesChoque()})	}
	method chocar(){ game.schedule(100 ,{self.auxiliarDespuesChoque()})}
	method metodosChoques(elemento){
		elemento.chocar()
		if (!nave.modoInvisible())self.cambiarLaImagen()
	//	game.addVisual(efectoRojoChoque)
	//	game.schedule(150 ,{game.removeVisual(efectoRojoChoque)})
		if (!nave.modoInvisible())self.chocar()
	}
	
	method iniciarMovimiento(unaVelocidad) {
		game.onTick(unaVelocidad,"mover asteroide",{ self.mover() })
	}
	method mover() {
		position = position.down(1)
		if (position.y() == -4) {
			 	self.auxiliarDespuesChoque()
		}
	}
}

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
	
	method pasarTiempo() { segundos = segundos +1 }
	method iniciar(){
		segundos = 0
		game.onTick(1000,"tiempo",{self.pasarTiempo()})
	}
	method detener(){ game.removeTickEvent("tiempo") }
	method metodosChoques(elemento) {}
}

object musica {
	const property inicio = game.sound("musicaInicio.mp3")
	const property partida = game.sound("musicaPartida.mp3")
}
	
object dificultad{
	method facil() = 800
	method medio() = 400
	method dificil() = 100
}
	
	
	