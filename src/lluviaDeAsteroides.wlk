import wollok.game.*
import consola.*

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
	const dificultades = [dificultad.facil(), dificultad.medio(), dificultad.dificil()]
	
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
		game.addVisual(fondoAsteroide)
		game.addVisualCharacter(laser)
		game.addVisualCharacter(nave)
		keyboard.q().onPressDo{self.volverALaConsola()}
		keyboard.z().onPressDo { nave.activarModoCombate() }
		keyboard.x().onPressDo { nave.disparar() }
		keyboard.k().onPressDo {self.irMenu()}
		keyboard.r().onPressDo {self.reiniciar()}
		keyboard.v().onPressDo {nave.decirVidas()}
		
		game.addVisual(score)
	
		
		
		game.onTick(dificultades.get(1), "Crear Asteroide grande/mediano", { 
			const asteroide = new Asteroide(position=game.at(0.randomUpTo(16),25),image=imagenesAsteroidesGrandes.anyOne())
			game.addVisual(asteroide)
			asteroide.iniciarMovimiento(asteroide.velocidades().anyOne())
		})
		
		game.onTick(dificultades.get(1), "Crear Asteroide chico", { 
			const asteroide = new Asteroide(position=game.at(0.randomUpTo(16),25),image=imagenesAsteroidesChicos.anyOne())
			game.addVisual(asteroide)
			asteroide.iniciarMovimiento(asteroide.velocidades().anyOne())
		})
		game.whenCollideDo(nave,{elemento=>if(elemento!=laser and elemento!=fondoEspacio and elemento!=fondoAsteroide and elemento!=score)elemento.metodosChoques()});
		game.whenCollideDo(laser,{elemento=>if(elemento!=nave and elemento!=fondoEspacio and elemento!=fondoAsteroide and elemento!=score)elemento.metodosChoques()});
		game.whenCollideDo(nave,{elemento=>if(elemento!=laser and elemento!=fondoEspacio and elemento!=fondoAsteroide and elemento!=score)nave.chocar(elemento)});
		
 }
 
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
		game.addVisual(nave)
		game.addVisual(laser)
		nave.vidas(6)
		nave.asteroidesRotos(0)
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



object dificultad {
	method facil() = 8000
	method medio() = 5000
	method dificil() = 3000
	// FALTA TERMINAR !!!!
/* 	method seleccionarDificultad() {
		keyboard.e().onPressDo(partida.jugar(facil))
		
		keyboard.m().onPressDo(partida.jugar(medio))
		
		keyboard.h().onPressDo(partida.jugar(dificil))
	}*/
}

// OBJETOS

object laser {
	var property position =nave.position()
	const property image = "laserChicoFinal.png"
	
	method disparar() {
		game.onTick(50, "disparar",{ self.mover() })
	}
	
	method mover() {
		position = position.up(1)
		if (position.y() == 25) { 
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
	}
	
	method decirVidas(){
		game.say(self,"tengo "+self.vidas()+" vidas")	
	}
	
	//
	method activarModoCombate() {
		if (not modoCombate) {
			modoCombate = true
			image = "naveCombate.png"
		}
	}
	method disparar() { 
		if (modoCombate) {
			laser.disparar()
		}
	}
} 

class Vida // FALTA TERMINAR
	{
 var property position 
 var property image
 	
 	method chocar()
 		{
 		
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

// VISUALES

class Visual {
	var property image
	var property position = game.origin()
}

// Imagenes Asteroides grandes y medianos

const imagenesAsteroidesGrandes = ["asteroideAmarillo.png", "asteroideAzul.png", "asteroideCeleste.png", "asteroideRojo.png", 
		"asteroideRosa.png", "asteroideAmarillo - copia.png", "asteroideAzul - copia.png", "asteroideCeleste - copia.png", "asteroideRojo - copia.png", 
		"asteroideRosa - copia.png" ]
		
// Imagenes Asteroides chicos
		
const imagenesAsteroidesChicos = ["asteroideAmarillo1.png", "asteroideAzul1.png", "asteroideCeleste1.png", "asteroideRojo1.png", 
		"asteroideRosa1.png", "asteroideAmarillo1 - copia.png", "asteroideAzul1 - copia.png", "asteroideCeleste1 - copia.png", "asteroideRojo1 - copia.png", 
		"asteroideRosa1 - copia.png" ]

// Piedras menu

const rocasMenu = ["piedrasMenu2.png", "piedrasMenu3.png", "piedrasMenu1.png", "piedrasMenu4.png", "piedrasMenu5.png",
	"piedrasMenu6.png","piedrasMenu7.png","piedrasMenu8.png"]

const mute = new Visual(image="mute.png", position=game.at(1,1))
const fondoEspacio = new Visual(image="fondoPartida.jpg", position=game.at(0,0))
const fondoMenu = new Visual(image="fondoMenu.jpg", position=game.at(0,0))
const fondoAsteroide = new Visual(image="fondoAsteroides.png", position=game.at(0,0))
const astronautaMenu = new Visual(image="astronautaMenu.png", position=game.at(1,4))
const astronautaPuntuacion1 = new Visual(image="astronautaPuntuacion.png", position=game.at(0,4))
const astronautaPuntuacion2 = new Visual(image="astronautaPuntuacion.png", position=game.at(0,5))
const astronautaPuntuacion3 = new Visual(image="astronautaPuntuacion.png", position=game.at(0,6))

const puntuacionAstronauta = new Visual(image="astronautaPuntuacion.png" ,position=game.at(0, game.height() - 2 ))

// MUSICA

const musicaInicio = new Sound(file="__-___ ____ _ Super Nintendo  Sega Genesis 80s RetroWave Mix (mp3cut.net).mp3")

// Menu Principal y selleccion de dificultad

const menuPlay = new Visual(image="menuPlay.png", position=game.at(5,3))
const menuMusic = new Visual(image="botonMusic.png", position=game.at(5,2))
const menuDificulties = new Visual(image="menuDificulties.png", position=game.at(4,2))
const easy = new Visual(image="easy.png", position=game.at(4,4))
const medium = new Visual(image="normal.png", position=game.at(4,3))
const hard = new Visual(image="hard.png", position=game.at(4,2))
object score{method position()= new Position(x=0,y=11) method text() = "        score:    "+nave.asteroidesRotos()}
