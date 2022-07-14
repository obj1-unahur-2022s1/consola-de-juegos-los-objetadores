import wollok.game.*
import objetos.*

// Imagenes juego

class Visual {
	var property image
	var property position
	
	method metodosChoques(elemento) {}
}

class Texto {
	var property position 
	var texto
	var color
	
	method text() = texto
	method textColor() = color 
	method metodosChoques(elemento) {}
}

// Vidas de "Modo Combate"

const naveCombatePoder0 = new Visual(image="naveCombateContador.png", position=game.at(game.width(), 6))
const naveCombatePoder1 = new Visual(image="naveCombateContador.png", position=game.at(game.width(), 7))
const naveCombatePoder2 = new Visual(image="naveCombateContador.png", position=game.at(game.width(), 8))

// Vidas de "Modo Invisible"

const naveInvPoder0 = new Visual(image="naveInvisibleContador.png", position=game.at(game.width(), 5))
const naveInvPoder1 = new Visual(image="naveInvisibleContador.png", position=game.at(game.width(), 4))
const naveInvPoder2 = new Visual(image="naveInvisibleContador.png", position=game.at(game.width(), 3))

// Vidas astronauta

const astronautaVida0 = new Visual(image="astronautaPuntuacion.png", position=game.at(0, 10))
const astronautaVida1 = new Visual(image="astronautaPuntuacion.png", position=game.at(1, 10))
const astronautaVida2 = new Visual(image="astronautaPuntuacion.png", position=game.at(2, 10))

// Imagenes Asteroides

const imagenesAsteroides = ["asteroideAmarillo1.png", "asteroideAmarillo2.png", "asteroideAmarillo3.png", "asteroideAmarillo4.png", 
	"asteroideAzul1.png", "asteroideAzul2.png", "asteroideAzul3.png", "asteroideAzul4.png", "asteroideRosa1.png", 
	"asteroideRosa2.png", "asteroideRosa3.png", "asteroideRosa4.png", "asteroideCeleste1.png", "asteroideCeleste2.png", 
	"asteroideCeleste3.png", "asteroideCeleste4.png", "asteroideRojo1.png", "asteroideRojo2.png", 
	"asteroideRojo3.png", "asteroideRojo4.png"]

// + 10 mas de los astronautas flotantes

const mas10 = new Visual(position=game.at(7,5), image= "mas10.png")
const menos10 = new Visual(position=game.at(7,5), image= "menos10.png")

// Efecto choque rojo

const efectoRojoChoque = new Visual(image="EfectoChoqueRojo.png", position=game.at(0,0))
 
// Mute

const mute = new Visual(image="mute.png", position=game.at(1,1))

// Elementos visuales del menu y fondos

const fondoEspacio = new Visual(image="fondoPartida.png",position=game.at(0,0))
const fondoMenu = new Visual(image="fondoMenu.jpg", position=game.at(0,0))
const astronautaMenu = new Visual(image="astronautaMenu.png", position=game.at(1,4))

const puntuacionAstronauta = new Visual(image="astronautaPuntuacion.png" ,position=game.at(0, game.height() - 2 ))

// Menu Principal y selleccion de dificultad

const menuMusic = new Visual(image="botonMusic.png", position=game.at(6,2))
const menuDificulties = new Visual(image="menuDificulties.png", position=game.at(3,2))
const dificultadesMenu = new Visual(image="dificultadesMenu.png", position=game.at(6,1))

// Ayudas en pantalla

const help = new Texto(position=game.at(15,1),texto="(a) AYUDA",color=amarillo)
const help1 = new Texto(position=game.at(15,1),texto="(z) MODO COMBATE",color=amarillo)
const help2 = new Texto(position=game.at(15,0),texto="(x) DISPARAR",color=amarillo)
const help3 = new Texto(position=game.at(15,2),texto="(c) MODO INVISIBLE",color=amarillo)
const help4 = new Texto(position=game.at(15,11),texto="(p) ON/OFF MUSICA",color=amarillo)

const amarillo = "#ffff16"

// Game over

const gameOver = new Visual(image="gameOver.png",position=game.at(4,6))

// Mensajes reinicio, consola, menu

const reinicioMensaje = new Visual(position=game.at(5,5), image="reiniciar.png")
const consolaMensaje = new Visual(position=game.at(5,4), image="irConsola.png")
const menuMensaje = new Visual(position=game.at(5,3), image="irMenu.png")

const imagenBateria = ["bateriaCarga 1.png","bateriaCarga 2.png"]