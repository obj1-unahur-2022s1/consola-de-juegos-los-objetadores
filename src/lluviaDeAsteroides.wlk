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

object juegoAsteroide {
	var property position = null
	
	method iniciar(){
    	partida.iniciar() 	   
    }
	
	method terminar(){
		
	}
	method image() = "iconoJuego.png"
	
}

// INICIO

object partida {
	const dificultades = [ 1500, 1000, 700 ]
	
	method terminar(){
		juegoAsteroide.iniciar()
	}
	
	method iniciar() {
		game.title("Naves Espaciales")
		game.width(16)
		game.height(17)
		game.cellSize(50)
		game.addVisual(fondoMenu)
		//self.moverRocasMenu()
		game.addVisual(astronautaMenu)
		self.iniciarMenu()
		self.musica()
		keyboard.space().onPressDo {self.jugar()}
	}
	
	method moverRocasMenu() {
		game.addVisual(rocaIzquierda)
		game.addVisual(rocaDerecha)
		rocaIzquierda.iniciar()
		rocaDerecha.iniciar()
	}
	
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
	method jugar() {
		game.clear()
		game.addVisual(fondoEspacio)
		game.addVisualCharacter(laser)
		game.addVisualCharacter(nave)
		nave.vidasCombate().forEach({ v => game.addVisual(v) })
		nave.vidas().forEach({ v => game.addVisual(v) })
		nave.vidasInvisibilidad().forEach({ v => game.addVisual(v) })
		keyboard.q().onPressDo{self.volverALaConsola()}
		keyboard.z().onPressDo { nave.activarModoCombate() }
		keyboard.x().onPressDo { nave.disparar() }
		keyboard.m().onPressDo {self.irMenu()}
		keyboard.r().onPressDo {self.reiniciar()}
		keyboard.v().onPressDo {nave.decirVidas()}
		keyboard.c().onPressDo {nave.activarModoInvisibilidad()}
		
		game.addVisual(score)
		score.iniciar()
		
		game.onTick(1500, "Crear Asteroide grande/mediano", { 
			const asteroide = new Asteroide(position=game.at(0.randomUpTo(16),13),image=imagenesAsteroidesGrandes.anyOne())
			game.addVisual(asteroide)
			asteroide.iniciarMovimiento(asteroide.velocidades().first())
		})
		
		game.onTick(1500, "Crear Asteroide chico", { 
			const asteroide = new Asteroide(position=game.at(0.randomUpTo(16),13),image=imagenesAsteroidesChicos.anyOne())
			game.addVisual(asteroide)
			asteroide.iniciarMovimiento(asteroide.velocidades().first())
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
 
 	method iniciarMenu(){
		game.addVisual(menuPlay)
		game.addVisual(menuMusic)
		//game.addVisual(menuDificulties)
		//keyboard.d().onPressDo {self.menuDificultades()}
	}
	
	/*method menuDificultades(){
		game.removeVisual(menuPlay)
		game.removeVisual(menuMusic)
		game.removeVisual(menuDificulties)
		
		game.addVisual(easy)
		game.addVisual(medium)
		game.addVisual(hard)
		
	
	}*/
	method reiniciar(){
		nave.configReinicio()
		self.jugar()
	}
	
	method irMenu(){
		self.reiniciar()
		self.iniciar()
	}
	
	method volverALaConsola() {
		self.reiniciar()
		consola.hacerTerminar(self)
	}
}



