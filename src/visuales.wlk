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

const imagenesAsteroidesGrandes = ["asteroideAmarillo.png", "asteroideAzul.png", "asteroideCeleste.png", "asteroideRojo.png", 
		"asteroideRosa.png", "asteroideAmarillo - copia.png", "asteroideAzul - copia.png", "asteroideCeleste - copia.png", "asteroideRojo - copia.png", 
		"asteroideRosa - copia.png" ]
		
// Imagenes Asteroides chicos
		
const imagenesAsteroidesChicos = ["asteroideAmarillo1.png", "asteroideAzul1.png", "asteroideCeleste1.png", "asteroideRojo1.png", 
		"asteroideRosa1.png", "asteroideAmarillo1 - copia.png", "asteroideAzul1 - copia.png", "asteroideCeleste1 - copia.png", "asteroideRojo1 - copia.png", 
		"asteroideRosa1 - copia.png" ]

// + mas de los astronautas

const mas10 = new Visual(image="mas10.png", position=game.at(7, 5))

// Piedras menu

const rocasMenu = ["piedrasMenu2.png", "piedrasMenu3.png", "piedrasMenu1.png", "piedrasMenu4.png", "piedrasMenu5.png",
	"piedrasMenu6.png","piedrasMenu7.png","piedrasMenu8.png"]

const mute = new Visual(image="mute.png", position=game.at(1,1))
const fondoEspacio = new Visual(image="fondoPartida.png", position=game.at(0,0))
const fondoMenu = new Visual(image="fondoMenu.jpg", position=game.at(0,0))
const astronautaMenu = new Visual(image="astronautaMenu.png", position=game.at(1,4))
//const astronautaPuntuacion1 = new Visual(image="astronautaPuntuacion.png", position=game.at(0,4))
//const astronautaPuntuacion2 = new Visual(image="astronautaPuntuacion.png", position=game.at(0,5))
//const astronautaPuntuacion3 = new Visual(image="astronautaPuntuacion.png", position=game.at(0,6))

const puntuacionAstronauta = new Visual(image="astronautaPuntuacion.png" ,position=game.at(0, game.height() - 2 ))

// MUSICA

//const musicaInicio = new Sound(file="__-___ ____ _ Super Nintendo  Sega Genesis 80s RetroWave Mix (mp3cut.net).mp3")

// Menu Principal y selleccion de dificultad

const menuMusic = new Visual(image="botonMusic.png", position=game.at(4,2))
const menuDificulties = new Visual(image="menuDificulties.png", position=game.at(4,3))
const easy = new Visual(image="easy.png", position=game.at(4,4))
const medium = new Visual(image="normal.png", position=game.at(4,3))
const hard = new Visual(image="hard.png", position=game.at(4,2))


object help{method position()= new Position(x=15,y=0) method text() = "(a) ayuda"}
object help1{method position()= new Position(x=15,y=1) method text() = "(z)modo combate"}
object help2{method position()= new Position(x=15,y=0) method text() = "(x)disparar"}

//object score{method position()= new Position(x=0,y=11) method text() = "        score:    "+nave.asteroidesRotos()}

const gameOver = new Visual(image="gameOver.png",position=game.at(4,6))


object reinicioMensaje{method position()= new Position(x=5,y=5) method image() = "reiniciar.png"}
object consolaMensaje{method position()= new Position(x=5,y=4) method image() = "irConsola.png"}
object menuMensaje{method position()= new Position(x=5,y=3) method image() = "irMenu.png"}
