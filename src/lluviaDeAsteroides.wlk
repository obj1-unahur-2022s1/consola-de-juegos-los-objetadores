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
	const dificultades = [dificultad.facil(), dificultad.medio(), dificultad.dificil()]
	var property position = null
	const visualesFinalJuego = [ reinicioMensaje, consolaMensaje, menuMensaje, gameOver ]
		
	method image() = "iconoJuego.png"
	
	method iniciar() {
		game.title("Naves Espaciales")
		game.width(16)
		game.height(17)
		game.addVisual(fondoMenu)
		game.addVisual(astronautaMenu)
		self.iniciarMenu()
		musica.inicio().play()
	}
	
	method jugar(unaDificultad) {
		musica.inicio().stop()
		game.clear()
		musica.partida().play()
		game.addVisual(fondoEspacio)
		game.addVisual(score)
		game.addVisualCharacter(laser)
		game.addVisualCharacter(nave)
		
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
		keyboard.h().onPressDo{self.ayuda()}

		game.addVisual(help)
		
		game.onTick(dificultades.get(unaDificultad), "Crear Asteroide grande/mediano", { 
			const asteroide = new Asteroide(position=game.at(0.randomUpTo(5),13),image=imagenesAsteroidesGrandes.anyOne())
			game.addVisual(asteroide)
			asteroide.iniciarMovimiento(asteroide.velocidad())
		})
		
		game.onTick(dificultades.get(unaDificultad), "Crear Asteroide chico", { 
			const asteroide = new Asteroide(position=game.at(6.randomUpTo(11),13),image=imagenesAsteroidesChicos.anyOne())
			game.addVisual(asteroide)
			asteroide.iniciarMovimiento(asteroide.velocidad())
		})
		
		game.onTick(dificultades.get(unaDificultad), "Crear Asteroide chico", { 
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
 	
 	
 	method iniciarMenu(){
	
		game.addVisual(menuMusic)
		game.addVisual(menuDificulties)
		
		keyboard.d().onPressDo {self.menuDificultades()}
	}
	
	
	
	method menuDificultades(){
		
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
		nave.configReinicio()
		self.jugar(0)
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

object dificultad{
	method facil() = 800
	method medio() = 600
	method dificil() = 400
}