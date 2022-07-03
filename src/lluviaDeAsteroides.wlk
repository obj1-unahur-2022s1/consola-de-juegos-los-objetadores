import wollok.game.*
import consola.*
import objetos.*
import visuales.*

class Juego {
	var property position = null
	var property color 
	
	method iniciar(){
        game.addVisual(object{method position()= game.center() method text() = "Juego "+color + " - <q> para salir"})		
	}
	
	method terminar(){

	}
	method image() = "juego" + color + ".png"
	
}

// INICIO

object juegoAsteroide {
	var property position = null
	const visualesFinalJuego = [ reinicioMensaje, consolaMensaje, menuMensaje, gameOver ]
		
	method image() = "iconoJuego.png"
	
	method iniciar() {
		game.title("Naves Espaciales")
		game.width(16)
		game.height(17)
		game.addVisual(fondoMenu)
		game.addVisual(astronautaMenu)
<<<<<<< HEAD
		self.iniciarMenu()
		self.musica()
=======
		//self.iniciarMenu()
		musica.inicio().play()
		keyboard.space().onPressDo {self.jugar()}
>>>>>>> 244714fd79e094891f66aa0f0abf164d9c0ed7f6
	}
	
<<<<<<< HEAD
	method musica() {
		keyboard.p().onPressDo { 
			musicaInicio.play()
			musicaInicio.volume(0.5) 
		}
		keyboard.s().onPressDo {
			if (musicaInicio.paused()) { 
				musicaInicio.resume()
				game.removeVisual(mute)
			} 
			else { 
				musicaInicio.pause()
				game.addVisual(mute)
			}
		}
	}
	method jugar(dificultad) {
=======
	method jugar() {
		musica.inicio().stop()
>>>>>>> 244714fd79e094891f66aa0f0abf164d9c0ed7f6
		game.clear()
		musica.partida().play()
		game.addVisual(fondoEspacio)
		game.addVisual(score)
		game.addVisualCharacter(laser)
		game.addVisualCharacter(nave)
<<<<<<< HEAD
		keyboard.q().onPressDo{self.volverALaConsola()}
		keyboard.z().onPressDo { nave.activarModoCombate() }
		keyboard.x().onPressDo { nave.disparar() }
		keyboard.m().onPressDo {self.irMenu()}
		keyboard.r().onPressDo {self.reiniciar()}
		keyboard.v().onPressDo {nave.decirVidas()}
		keyboard.h().onPressDo{self.ayuda()}
		
		game.addVisual(help)
		
		
		game.addVisual(score)
	
		game.onTick(dificultades.get(dificultad), "Crear Asteroide grande/mediano", { 
			const asteroide = new Asteroide(position=game.at(0.randomUpTo(16),25),image=imagenesAsteroidesGrandes.anyOne())
=======
		
		nave.iniciar()
		score.iniciar()
		nave.iniciarVidas()
		
		keyboard.q().onPressDo{self.volverALaConsola()}
		keyboard.m().onPressDo {self.irMenu()}
		keyboard.r().onPressDo {self.reiniciar()}
		keyboard.p().onPressDo {
			if (musica.partida().paused()) {
				musica.partida().resume()
				game.removeVisual(mute)			
			}
			else {
				game.addVisual(mute)
				musica.partida().pause()
			}
		}
		
		game.onTick(2500, "Crear Asteroide grande/mediano", { 
			const asteroide = new Asteroide(position=game.at(0.randomUpTo(5),13),image=imagenesAsteroidesGrandes.anyOne())
>>>>>>> 244714fd79e094891f66aa0f0abf164d9c0ed7f6
			game.addVisual(asteroide)
			asteroide.iniciarMovimiento(asteroide.velocidad())
		})
		
<<<<<<< HEAD
		game.onTick(dificultades.get(dificultad), "Crear Asteroide chico", { 
			const asteroide = new Asteroide(position=game.at(0.randomUpTo(16),25),image=imagenesAsteroidesChicos.anyOne())
=======
		game.onTick(1500, "Crear Asteroide chico", { 
			const asteroide = new Asteroide(position=game.at(6.randomUpTo(11),13),image=imagenesAsteroidesChicos.anyOne())
>>>>>>> 244714fd79e094891f66aa0f0abf164d9c0ed7f6
			game.addVisual(asteroide)
			asteroide.iniciarMovimiento(asteroide.velocidad())
		})
		
		game.onTick(2000, "Crear Asteroide chico", { 
			const asteroide = new Asteroide(position=game.at(12.randomUpTo(16),13),image=imagenesAsteroidesChicos.anyOne())
			game.addVisual(asteroide)
			asteroide.iniciarMovimiento(asteroide.velocidad())
		})
		
		game.onTick(10000, "Crear astronauta", { 
			const astronauta = new Astronauta(position=game.at(0.randomUpTo(16),13))
			game.addVisual(astronauta)
			astronauta.iniciarMovimiento()
        })
				
		// Las condiciones del if sirve para cuando la nave toca el score o cualquier otro objeto no se quite una vida
		game.onCollideDo(nave,{elemento=>if(elemento!=laser and elemento!=fondoEspacio and not nave.modoInvisible() and elemento!=score and elemento!=astronautaVida0 and elemento!=astronautaVida1 and elemento!=astronautaVida2)elemento.metodosChoques()});
		game.onCollideDo(laser,{elemento=>if(elemento!=nave and elemento!=fondoEspacio and elemento!=score and not nave.modoInvisible() and elemento!=astronautaVida0 and elemento!=astronautaVida1 and elemento!=astronautaVida2) {elemento.metodosChoques()}});
		game.onCollideDo(nave,{elemento=>if(elemento!=laser and elemento!=fondoEspacio and not nave.modoInvisible() and elemento!=score and elemento!=astronautaVida0 and elemento!=astronautaVida1 and elemento!=astronautaVida2 and self.elementoNoEsMensajesFinal(elemento))nave.chocar(elemento)});
 	
	 }
	 
	method elementoNoEsMensajesFinal(elemento) = elemento!=reinicioMensaje and elemento!=consolaMensaje and elemento!=menuMensaje
 	
 	method terminar() {
 		game.removeVisual(laser)
 		score.detener()
		visualesFinalJuego.forEach({ v => game.addVisual(v) })
		game.schedule(15000, {
			musica.partida().stop()
			visualesFinalJuego.forEach({ v => game.removeVisual(v) })
		})
		
 	}
 	
 	/*
 	method iniciarMenu(){
 		
		game.addVisual(menuDificulties)
		game.addVisual(menuMusic)
		
		keyboard.d().onPressDo {self.menuDificultades()}
	}
	
<<<<<<< HEAD
	method menuDificultades(){
		
=======
	*/
	
	/*method menuDificultades(){
		game.removeVisual(menuPlay)
>>>>>>> 244714fd79e094891f66aa0f0abf164d9c0ed7f6
		game.removeVisual(menuMusic)
		game.removeVisual(menuDificulties)
		
		game.addVisual(easy)
		game.addVisual(medium)
		game.addVisual(hard)
		
		keyboard.e().onPressDo {self.jugar(0)}
		keyboard.n().onPressDo {self.jugar(1)}
		keyboard.h().onPressDo {self.jugar(2)}
	}
	method reiniciar(){
<<<<<<< HEAD
		game.addVisual(nave)
		game.addVisual(laser)
		nave.vidas(6)
		nave.asteroidesRotos(0)
		self.jugar(0)
		
=======
		nave.configReinicio()
		self.jugar()
>>>>>>> 244714fd79e094891f66aa0f0abf164d9c0ed7f6
	}
	
	method irMenu(){
		self.reiniciar()
		self.iniciar()
	}
	
	method volverALaConsola() {
		self.reiniciar()
		consola.hacerTerminar(self)
	}
	
	method ayuda(){
		game.removeVisual(help)
		
		game.addVisual(help1)
		game.addVisual(help2)
	}

}



