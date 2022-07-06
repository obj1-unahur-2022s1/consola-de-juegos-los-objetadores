import wollok.game.*
import objetos.*

class Visual {
	var property image
	var property position = game.origin()
}

// Imagenes juego

// Naves vidas de poderes

const naveCombatePoder0 = new Visual(image="naveCombateContador.png", position=game.at(game.width(), 6))
const naveCombatePoder1 = new Visual(image="naveCombateContador.png", position=game.at(game.width(), 7))
const naveCombatePoder2 = new Visual(image="naveCombateContador.png", position=game.at(game.width(), 8))

const naveInvPoder0 = new Visual(image="naveInvisibleContador.png", position=game.at(game.width(), 5))
const naveInvPoder1 = new Visual(image="naveInvisibleContador.png", position=game.at(game.width(), 4))
const naveInvPoder2 = new Visual(image="naveInvisibleContador.png", position=game.at(game.width(), 3))

// Vidas astronauta

const astronautaVida0 = new Visual(image="astronautaPuntuacion.png", position=game.at(0, 10))
const astronautaVida1 = new Visual(image="astronautaPuntuacion.png", position=game.at(1, 10))
const astronautaVida2 = new Visual(image="astronautaPuntuacion.png", position=game.at(2, 10))

	


// Imagenes Asteroides grandes y medianos

const imagenesAsteroides = ["asteroideAmarillo1.png", "asteroideAmarillo2.png", "asteroideAmarillo3.png", "asteroideAmarillo4.png", 
	"asteroideAzul1.png", "asteroideAzul2.png", "asteroideAzul3.png", "asteroideAzul4.png", "asteroideRosa1.png", 
	"asteroideRosa2.png", "asteroideRosa3.png", "asteroideRosa4.png", "asteroideCeleste1.png", "asteroideCeleste2.png", 
	"asteroideCeleste3.png", "asteroideCeleste4.png", "asteroideRojo1.png", "asteroideRojo2.png", 
	"asteroideRojo3.png", "asteroideRojo4.png"]

		

// + mas de los astronautas

object mas10{method position()= new Position(x=7,y=5) method image() = "mas10.png"}

// Piedras menu

const rocasMenu = ["piedrasMenu2.png", "piedrasMenu3.png", "piedrasMenu1.png", "piedrasMenu4.png", "piedrasMenu5.png",
	"piedrasMenu6.png","piedrasMenu7.png","piedrasMenu8.png"]

const mute = new Visual(image="mute.png", position=game.at(1,1))
const fondoEspacio = new Visual(image="fondoPartida.png", position=game.at(0,0))
const fondoMenu = new Visual(image="fondoMenu.jpg", position=game.at(0,0))
const astronautaMenu = new Visual(image="astronautaMenu.png", position=game.at(1,4))

const puntuacionAstronauta = new Visual(image="astronautaPuntuacion.png" ,position=game.at(0, game.height() - 2 ))

// Menu Principal y selleccion de dificultad

const menuMusic = new Visual(image="botonMusic.png", position=game.at(6,2))
const menuDificulties = new Visual(image="menuDificulties.png", position=game.at(3,2))
const dificultadesMenu = new Visual(image="dificultadesMenu.png", position=game.at(6,1))

object help{
	method position()= new Position(x=15,y=0) 
	method text() = "(a) AYUDA"
	method textColor() = "#ffff16" // amarillo
}
object help1{
	method position()= new Position(x=15,y=1) 
	method text() = "(z) MODO COMBATE"
	method textColor() = "#ffff16" // amarillo
}
object help2{
	method position()= new Position(x=15,y=0) 
	method text() = "(x) DISPARAR"
	method textColor() = "#ffff16" // amarillo
}
object help4{
	method position()= new Position(x=15,y=11) 
	method text() = "(p) ON/OFF MUSICA"
	method textColor() = "#ffff16" // amarillo
}
object help3{
	method position()= new Position(x=15,y=2) 
	method text() = "(c) MODO INVISIBLE"
	method textColor() = "#ffff16" // amarillo
}


//object score{method position()= new Position(x=0,y=11) method text() = "        score:    "+nave.asteroidesRotos()}

const gameOver = new Visual(image="gameOver.png",position=game.at(4,6))


object reinicioMensaje{method position()= new Position(x=5,y=5) method image() = "reiniciar.png"}
object consolaMensaje{method position()= new Position(x=5,y=4) method image() = "irConsola.png"}
object menuMensaje{method position()= new Position(x=5,y=3) method image() = "irMenu.png"}
