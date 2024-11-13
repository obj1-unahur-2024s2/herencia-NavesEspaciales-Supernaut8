class Nave {
    var property velocidad
    var direccionAlSol
    var property nivelDeCombustible

    method acelerar(cantidad) {
        velocidad = 100000.min(velocidad + cantidad)
    }
    method desacelerar(cantidad) {
        velocidad = 0.max(velocidad - cantidad)
    }
    method irHaciaElSol() {
        direccionAlSol = 10
    }
    method escaparDelSol() {
        direccionAlSol = -10
    }
    method ponerseParaleloAlSol() {
        direccionAlSol = 0
    }
    method acercarseUnPocoAlSol() {
        direccionAlSol = 0.max(direccionAlSol + 1)
    } 
    method alejarseUnPocoDelSol() {
        direccionAlSol = -10.max(direccionAlSol - 1)
    }
    method prepararViaje() {
        self.cargarCombustible(30000)
        self.acelerar(5000)
    }
    method cargarCombustible(cantidad) {
        nivelDeCombustible = nivelDeCombustible + cantidad
    }
    method descargarCombustible(cantidad) {
        nivelDeCombustible = 0.max(nivelDeCombustible - cantidad)
    }
    method estaTranquila() = self.nivelDeCombustible() >= 4000 
                                && 
                             self.velocidad() <= 12000
    method recibirAmenaza() {
        self.escapar()
        self.avisar()
    }
    method escapar()
    method avisar()
    method estaDeRelajo() = self.estaTranquila() && self.tienePocaActividad()
    method tienePocaActividad()
}

class NaveBaliza inherits Nave {
    const coloresUsados = []
    var colorDeBaliza

    method cambiarColorDeBaliza(unColor) {
        colorDeBaliza = unColor
        coloresUsados.add(unColor)
    }
    override method prepararViaje() {
        super()
        self.cambiarColorDeBaliza("verde")
        self.ponerseParaleloAlSol()
    } 
    override method estaTranquila() = super() 
                                        &&
                                      colorDeBaliza != "rojo"
    override method escapar() {
        self.irHaciaElSol()
    } 
    override method avisar() {
        self.cambiarColorDeBaliza("rojo")
    }
    override method tienePocaActividad() = coloresUsados.size() == 1
}

class NaveDePasajeros inherits Nave {
    const cantidadDePasajeros
    var comida
    var bebida
    var racionesDeComidaServidas = 0

    method cargarComida(raciones) {
        comida = raciones * cantidadDePasajeros
    }
    method descargarComida(raciones) {
        comida = comida - raciones
    }
    method cargarBebida(raciones) {
        bebida = raciones * cantidadDePasajeros
    }
    method descargarBebida(raciones) {
        bebida = bebida - raciones
    }
    override method prepararViaje() {
        super()
        self.cargarComida(4)
        self.cargarComida(6)
        self.acercarseUnPocoAlSol()
    }
    override method escapar() {
        velocidad = velocidad * 2
    } 
    override method avisar() {
        self.darRacionesAPasajeros(1, 2)
    }
    method darRacionesAPasajeros(racionesDeComida, racionesDeBebida) {
        racionesDeComidaServidas = racionesDeComidaServidas + racionesDeComida
        self.descargarComida(racionesDeComida)
        self.descargarBebida(racionesDeBebida)
    }
    override method tienePocaActividad() = racionesDeComidaServidas < 50
}

class NaveDeCombate inherits Nave {
    const mensajesEmitidos = []
    method ponerseVisible()
    method ponerseInvisible()
    method estaInvisible()
    method desplegarMisiles()
    method replegarMisiles()
    method misilesDesplegados()
    method emitirMensaje(unMensaje) {
        mensajesEmitidos.add(unMensaje)
    }
    method esEscueta() = mensajesEmitidos.max({m => m.length()}).length() < 30
    override method prepararViaje() {
        super()
        self.ponerseInvisible()
        self.replegarMisiles()
        self.acelerar(15000)
        self.emitirMensaje("Saliendo en misión")
    }
    override method estaTranquila() = super() 
                                        &&
                                      ! self.misilesDesplegados()
    override method escapar() {
        self.acercarseUnPocoAlSol()
        self.acercarseUnPocoAlSol()
    } 
    override method avisar() {
        self.emitirMensaje("Amenaza recibida")
    }
}

class NaveHospital inherits NaveDePasajeros {
    var quirofanosListos = false

    method prepararQuirofanos() {
        quirofanosListos = true
    }
    override method estaTranquila() = super() 
                                        &&
                                      quirofanosListos == false
    override method recibirAmenaza() {
        super()
        self.prepararQuirofanos()
    }
}
class NaveDeCombateSigilosa inherits NaveDeCombate {
    override method estaTranquila() = super() 
                                        &&
                                      ! self.estaInvisible()
    override method escapar() {
        super()
        self.desplegarMisiles()
        self.ponerseInvisible()
    }
}

object combustible {
  
}