import wollok.game.*
import objetos.*

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
//const astronautaPuntuacion1 = new Visual(image="astronautaPuntuacion.png", position=game.at(0,4))
//const astronautaPuntuacion2 = new Visual(image="astronautaPuntuacion.png", position=game.at(0,5))
//const astronautaPuntuacion3 = new Visual(image="astronautaPuntuacion.png", position=game.at(0,6))

const puntuacionAstronauta = new Visual(image="astronautaPuntuacion.png" ,position=game.at(0, game.height() - 2 ))

// MUSICA

const musicaInicio = new Sound(file="__-___ ____ _ Super Nintendo  Sega Genesis 80s RetroWave Mix (mp3cut.net).mp3")

// Menu Principal y selleccion de dificultad

const menuMusic = new Visual(image="botonMusic.png", position=game.at(4,2))
const menuDificulties = new Visual(image="menuDificulties.png", position=game.at(4,3))
const easy = new Visual(image="easy.png", position=game.at(4,4))
const medium = new Visual(image="normal.png", position=game.at(4,3))
const hard = new Visual(image="hard.png", position=game.at(4,2))

object help{method position()= new Position(x=15,y=0) method text() = "(h) ayuda"}
object help1{method position()= new Position(x=15,y=1) method text() = "(z)modo combate"}
object help2{method position()= new Position(x=15,y=0) method text() = "(x)disparar"}

object score{method position()= new Position(x=0,y=11) method text() = "        score:    "+nave.asteroidesRotos()}

object reinicioMensaje{method position()= new Position(x=5,y=5) method text() = "presione r para reiniciar"}
object consolaMensaje{method position()= new Position(x=5,y=7) method text() = "presione q para ir a la consola"}
object menuMensaje{method position()= new Position(x=5,y=6) method text() = "presione m para ir al menu"}
