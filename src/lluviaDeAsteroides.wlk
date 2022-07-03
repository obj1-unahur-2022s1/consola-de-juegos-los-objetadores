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
	const dificultades = [ 800, 600, 400 ]
	
	method terminar(){
		
	}
	
	method iniciar() {
		game.title("Naves Espaciales")
		game.width(16)
		game.height(17)
		game.cellSize(50)
		game.addVisual(fondoMenu)
		self.moverRocasMenu()
		game.addVisual(astronautaMenu)
		self.iniciarMenu()
		self.musica()
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
	method jugar(dificultad) {
		game.clear()
		game.addVisual(fondoEspacio)
		game.addVisual(fondoAsteroide)
		game.addVisualCharacter(laser)
		game.addVisualCharacter(nave)
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
			game.addVisual(asteroide)
			asteroide.iniciarMovimiento(asteroide.velocidades().anyOne())
		})
		
		game.onTick(dificultades.get(dificultad), "Crear Asteroide chico", { 
			const asteroide = new Asteroide(position=game.at(0.randomUpTo(16),25),image=imagenesAsteroidesChicos.anyOne())
			game.addVisual(asteroide)
			asteroide.iniciarMovimiento(asteroide.velocidades().anyOne())
		})
		
		game.onTick(10000, "Crear astronauta", { 
			const astronauta = new Astronauta(position=game.at(0.randomUpTo(16),25))
			game.addVisual(astronauta)
			astronauta.iniciarMovimiento()
        })
		
		game.whenCollideDo(nave,{elemento=>if(elemento!=laser and elemento!=fondoEspacio and elemento!=fondoAsteroide and elemento!=score)elemento.metodosChoques()});
		game.whenCollideDo(laser,{elemento=>if(elemento!=nave and elemento!=fondoEspacio and elemento!=fondoAsteroide and elemento!=score) {
			elemento.metodosChoques()
			laser.position(nave.position())
			}
		});
		game.whenCollideDo(nave,{elemento=>if(elemento!=laser and elemento!=fondoEspacio and elemento!=fondoAsteroide and elemento!=score)nave.chocar(elemento)});
		
 }
 
 	method iniciarMenu(){
 		
		game.addVisual(menuDificulties)
		game.addVisual(menuMusic)
		
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
		game.addVisual(nave)
		game.addVisual(laser)
		nave.vidas(6)
		nave.asteroidesRotos(0)
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



