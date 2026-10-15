
// VARIABLES GENERALES Y NAVEGACIÓN


int escenario = 1; // 1: BARRIO, 2: COLEGIO, 3: ELECCIÓN/PLAZA



// INDICADORES DE LA CIUDAD DE NOVA


int informacion = 50;
int convivencia = 50;
int bienestar = 50;
int participacion = 50;
int reputacion = 50;



// ARREGLOS DE LA RED SOCIAL CONECTA


// Publicaciones por escenario (1=BARRIO, 2=COLEGIO, 3=ELECCION)
String[] pubTitulos = {
  "¡Torneo deportivo en el parque del barrio!", 
  "¡Fotografía subida sin permiso en el recreo!", 
  "URGENTE: Candidato propone cerrar el colegio"
};
int[] pubEscenarios = {1, 2, 3};
String[] pubAutores = {"@vecinos_nova", "@anonimo_04", "@periodico_local"};
int[] pubConfiabilidad = {85, 30, 45};
int[] pubViralidad = {40, 75, 90};
boolean[] pubProcesadas = {false, false, false};

boolean redSocialAbierta = false;



// VARIABLES DEL JUGADOR


float jugadorX = 500;
float jugadorY = 300;
float velocidadJugador = 3;

// Variables de movimiento teclado
boolean moverArriba = false;
boolean moverAbajo = false;
boolean moverIzquierda = false;
boolean moverDerecha = false;



// SETUP


void setup() {
  size(1000, 400);
}



// DRAW


void draw() {

  // 1. MOSTRAR ESCENARIO CORRESPONDIENTE
  if (escenario == 1) {
    escenarioCalle();
  } else if (escenario == 2) {
    escenarioColegio();
  } else if (escenario == 3) {
    escenarioPlaza();
  }

  // 2. MOVER Y DIBUJAR JUGADOR (Solo si la red social no está abierta)
  if (!redSocialAbierta) {
    moverJugador();
  }
  dibujarJugador();

  // 3. TEXTO DE CONTROLES E INDICADORES
  textSize(14);
  textAlign(LEFT);
  fill(255);
  text("1: Barrio   2: Colegio   3: Plaza     WASD: Moverse     C: Conecta (Red Social)", 15, 390);

  mostrarIndicadores();

  // 4. INTERFAZ DE RED SOCIAL (HUD + PANTALLA)
  gestionarRedSocialGUI();
}



// RED SOCIAL


void gestionarRedSocialGUI() {
  dibujarIconoRedSocial();
  if (redSocialAbierta) {
    dibujarPantallaConecta();
  }
}

// Icono Flotante en la esquina superior derecha
void dibujarIconoRedSocial() {
  pushStyle();
  rectMode(CORNER);
  stroke(255);
  strokeWeight(2);
  fill(30, 144, 255); // Azul Conecta
  rect(width - 65, 15, 50, 50, 12);
  
  // Icono
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(22);
  text("📱", width - 40, 38);
  
  // Notificación roja si hay publicación pendiente en este escenario
  if (hayPublicacionesPendientes(escenario)) {
    fill(255, 50, 50);
    noStroke();
    ellipse(width - 15, 15, 14, 14);
  }
  popStyle();
}

// Pantalla principal del teléfono "Conecta"
void dibujarPantallaConecta() {
  pushStyle();
  
  fill(0, 0, 0, 180);
  rect(0, 0, width, height);

  // Marco del teléfono
  fill(20, 25, 35);
  stroke(30, 144, 255);
  strokeWeight(3);
  rect(width/2 - 200, 20, 400, height - 40, 20);

  // Encabezado
  fill(30, 144, 255);
  rect(width/2 - 200, 20, 400, 45, 20, 20, 0, 0);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(16);
  String nombreEscenario = (escenario == 1) ? "BARRIO" : (escenario == 2) ? "COLEGIO" : "ELECCIÓN";
  text("RED CONECTA - " + nombreEscenario, width/2, 42);

  // Buscar publicación para el escenario actual
  int idx = obtenerIndicePublicacion(escenario);

  if (idx != -1 && !pubProcesadas[idx]) {
    // Tarjeta de Publicación
    fill(35, 42, 55);
    stroke(60, 70, 90);
    rect(width/2 - 180, 80, 360, 140, 10);

    fill(180, 200, 220);
    textAlign(LEFT, TOP);
    textSize(12);
    text("Autor: " + pubAutores[idx], width/2 - 165, 92);
    text("Confiabilidad: " + pubConfiabilidad[idx] + "%  |  Viralidad: " + pubViralidad[idx] + "%", width/2 - 165, 110);

    fill(255);
    textSize(13);
    textLeading(18);
    text(pubTitulos[idx], width/2 - 165, 135, 330, 80);

    // Botones de Decisión (1, 2, 3)
    dibujarBotonOpcion(width/2 - 170, 235, "1. Compartir (Aumenta Viralidad)", color(220, 80, 80));
    dibujarBotonOpcion(width/2 - 170, 280, "2. Verificar / Reportar", color(80, 180, 100));
    dibujarBotonOpcion(width/2 - 170, 325, "3. Ignorar Publicación", color(120, 130, 140));

  } else {
    fill(200);
    textAlign(CENTER, CENTER);
    textSize(14);
    text("No hay publicaciones pendientes\nen esta zona de la ciudad.", width/2, height/2 - 10);
  }

  // Indicación de cierre
  fill(150);
  textSize(11);
  textAlign(CENTER);
  text("[ Presiona C o Clic en el icono para Cerrar ]", width/2, height - 30);

  popStyle();
}

void dibujarBotonOpcion(float x, float y, String texto, int c) {
  fill(c);
  noStroke();
  rect(x, y, 340, 36, 8);
  fill(255);
  textAlign(LEFT, CENTER);
  textSize(13);
  text(texto, x + 15, y + 18);
}


//DECISIONES DE LA RED SOCIAL


void procesarDecision(int idx, int opcion) {
  if (idx < 0 || idx >= pubTitulos.length) return;

  // 1: Compartir, 2: Verificar/Reportar, 3: Ignorar
  if (opcion == 1) {
    pubViralidad[idx] += 20;
    cambiarIndicadores(-10, -5, -5, +5, -10);
  } else if (opcion == 2) {
    pubViralidad[idx] -= 15;
    cambiarIndicadores(+15, +10, +5, +10, +10);
  } else if (opcion == 3) {
    cambiarIndicadores(0, 0, +5, 0, 0);
  }

  // Marcar publicación como procesada
  pubProcesadas[idx] = true;
}

int obtenerIndicePublicacion(int esc) {
  for (int i = 0; i < pubEscenarios.length; i++) {
    if (pubEscenarios[i] == esc && !pubProcesadas[i]) {
      return i;
    }
  }
  return -1;
}

boolean hayPublicacionesPendientes(int esc) {
  return obtenerIndicePublicacion(esc) != -1;
}



// TECLAS PRESIONADAS Y LIBERADAS


void keyPressed() {

  // Abrir / Cerrar Red Social Conecta
  if (key == 'c' || key == 'C') {
    redSocialAbierta = !redSocialAbierta;
  }

  // Si la red social está abierta, responder con números 1, 2, 3
  if (redSocialAbierta) {
    int idx = obtenerIndicePublicacion(escenario);
    if (idx != -1 && !pubProcesadas[idx]) {
      if (key == '1') procesarDecision(idx, 1);
      if (key == '2') procesarDecision(idx, 2);
      if (key == '3') procesarDecision(idx, 3);
    }
  }

  // Cambiar escenario sólo si la red social está cerrada
  if (!redSocialAbierta) {
    if (key == '1') {
      escenario = 1;
      reiniciarPosicionJugador();
    }
    if (key == '2') {
      escenario = 2;
      reiniciarPosicionJugador();
    }
    if (key == '3') {
      escenario = 3;
      reiniciarPosicionJugador();
    }
  }

  // Movimiento WASD
  if (key == 'w' || key == 'W') moverArriba = true;
  if (key == 's' || key == 'S') moverAbajo = true;
  if (key == 'a' || key == 'A') moverIzquierda = true;
  if (key == 'd' || key == 'D') moverDerecha = true;
}

void keyReleased() {
  if (key == 'w' || key == 'W') moverArriba = false;
  if (key == 's' || key == 'S') moverAbajo = false;
  if (key == 'a' || key == 'A') moverIzquierda = false;
  if (key == 'd' || key == 'D') moverDerecha = false;
}

void mousePressed() {
  // Click en el Icono de la Red Social
  if (mouseX >= width - 65 && mouseX <= width - 15 && mouseY >= 15 && mouseY <= 65) {
    redSocialAbierta = !redSocialAbierta;
    return;
  }

  // Click en los botones de opción cuando la red está abierta
  if (redSocialAbierta) {
    int idx = obtenerIndicePublicacion(escenario);
    if (idx != -1 && !pubProcesadas[idx]) {
      if (mouseX >= width/2 - 170 && mouseX <= width/2 + 170 && mouseY >= 235 && mouseY <= 271) {
        procesarDecision(idx, 1);
      } else if (mouseX >= width/2 - 170 && mouseX <= width/2 + 170 && mouseY >= 280 && mouseY <= 316) {
        procesarDecision(idx, 2);
      } else if (mouseX >= width/2 - 170 && mouseX <= width/2 + 170 && mouseY >= 325 && mouseY <= 361) {
        procesarDecision(idx, 3);
      }
    }
  }
}



// MOVER Y REINICIAR JUGADOR


void moverJugador() {
  if (moverArriba) jugadorY -= velocidadJugador;
  if (moverAbajo) jugadorY += velocidadJugador;
  if (moverIzquierda) jugadorX -= velocidadJugador;
  if (moverDerecha) jugadorX += velocidadJugador;

  jugadorX = constrain(jugadorX, 18, width - 18);
  jugadorY = constrain(jugadorY, 40, height - 35);
}

void reiniciarPosicionJugador() {
  jugadorX = 500;
  jugadorY = 300;
}



// DIBUJAR PROTAGONISTA


void dibujarJugador() {
  noStroke();
  fill(70, 70, 70, 120);
  ellipse(jugadorX, jugadorY + 22, 32, 10);

  fill(40, 50, 80);
  rect(jugadorX - 10, jugadorY + 8, 8, 18);
  rect(jugadorX + 2, jugadorY + 8, 8, 18);

  fill(160, 70, 210);
  rect(jugadorX - 14, jugadorY - 15, 28, 25, 5);

  fill(230, 180, 140);
  rect(jugadorX - 18, jugadorY - 10, 5, 18, 3);
  rect(jugadorX + 13, jugadorY - 10, 5, 18, 3);

  fill(230, 180, 140);
  ellipse(jugadorX, jugadorY - 27, 25, 25);

  fill(60, 40, 30);
  arc(jugadorX, jugadorY - 30, 25, 20, PI, TWO_PI);

  fill(255);
  ellipse(jugadorX, jugadorY - 48, 9, 9);
}



// ESCENARIO 1 - BARRIO / CALLE


void escenarioCalle() {
  background(120, 190, 100);
  dibujarCasa(100, 80);
  dibujarCasa(350, 80);
  dibujarCasa(600, 80);

  fill(170);
  rect(0, 245, width, 15);

  fill(70);
  rect(0, 260, width, 140);

  fill(250, 220, 80);
  for (int x = 20; x < width; x += 100) {
    rect(x, 325, 50, 8);
  }
}

void dibujarCasa(float x, float y) {
  fill(150, 120, 90);
  rect(x + 7, y + 7, 220, 169);

  fill(230, 180, 120);
  rect(x, y, 220, 169);

  fill(110, 50, 45);
  triangle(x - 12, y + 7, x + 232, y + 7, x + 110, y - 53);

  fill(170, 70, 60);
  triangle(x - 20, y, x + 240, y, x + 110, y - 60);

  fill(130, 50, 45);
  rect(x - 20, y - 5, 260, 7);

  fill(100, 60, 40);
  rect(x + 85, y + 100, 50, 69);

  fill(80, 130, 150);
  rect(x + 20, y + 45, 55, 55);
  fill(120, 200, 230);
  rect(x + 25, y + 50, 45, 45);

  fill(80, 130, 150);
  rect(x + 145, y + 45, 55, 55);
  fill(120, 200, 230);
  rect(x + 150, y + 50, 45, 45);
}



// ESCENARIO 2 - COLEGIO


void escenarioColegio() {
  background(190, 190, 170);

  fill(230, 190, 120);
  rect(0, 0, width, 110);

  fill(180, 140, 90);
  rect(0, 100, width, 10);

  fill(120, 120, 110);
  rect(0, 110, width, 10);

  fill(80, 130, 150);
  rect(80, 30, 70, 50);
  fill(120, 200, 230);
  rect(85, 35, 60, 40);

  fill(80, 130, 150);
  rect(200, 30, 70, 50);
  fill(120, 200, 230);
  rect(205, 35, 60, 40);

  fill(80, 130, 150);
  rect(730, 30, 70, 50);
  fill(120, 200, 230);
  rect(735, 35, 60, 40);

  fill(80, 130, 150);
  rect(850, 30, 70, 50);
  fill(120, 200, 230);
  rect(855, 35, 60, 40);

  noStroke();
  fill(70, 50, 40);
  rect(458, 35, 90, 75);
  fill(110, 70, 45);
  rect(450, 30, 90, 80);
  stroke(70, 50, 40);
  strokeWeight(2);
  line(495, 30, 495, 110);
  noStroke();

  fill(130, 130, 120);
  rect(307, 167, 406, 186);
  fill(170, 150, 110);
  rect(300, 160, 400, 185);

  noFill();
  stroke(255);
  strokeWeight(3);
  rect(310, 170, 380, 165);
  line(500, 170, 500, 335);
  ellipse(500, 252, 70, 70);
  noStroke();

  fill(90, 110, 70);
  ellipse(60, 290, 80, 30);
  fill(110, 70, 40);
  rect(52, 230, 16, 70);
  fill(60, 145, 70);
  ellipse(60, 220, 75, 75);

  fill(90, 70, 50);
  rect(147, 207, 120, 25);
  fill(150, 100, 60);
  rect(140, 200, 120, 20);
  fill(90, 70, 50);
  rect(155, 220, 15, 25);
  rect(230, 220, 15, 25);

  fill(90, 110, 70);
  ellipse(930, 210, 90, 35);
  fill(110, 70, 40);
  rect(920, 150, 20, 70);
  fill(60, 145, 70);
  ellipse(930, 145, 90, 90);

  fill(90, 70, 50);
  rect(787, 287, 120, 25);
  fill(150, 100, 60);
  rect(780, 280, 120, 20);
  fill(90, 70, 50);
  rect(795, 300, 15, 25);
  rect(870, 300, 15, 25);
}



// ESCENARIO 3 - PLAZA ELECTORAL


void escenarioPlaza() {
  background(175, 220, 245);

  fill(210, 190, 150);
  rect(350, 25, 300, 130);

  fill(130, 90, 70);
  triangle(330, 25, 670, 25, 500, 0);

  fill(100, 70, 50);
  rect(465, 85, 70, 70);

  fill(100, 180, 220);
  rect(385, 65, 50, 40);
  rect(565, 65, 50, 40);

  fill(240);
  ellipse(500, 45, 35, 35);

  fill(190, 185, 170);
  rect(0, 155, width, 245);

  stroke(160);
  strokeWeight(1);
  for (int x = 0; x < width; x += 50) {
    line(x, 155, x, 400);
  }
  for (int y = 155; y < 400; y += 50) {
    line(0, y, width, y);
  }
  noStroke();

  stroke(80);
  line(0, 55, width, 55);
  noStroke();

  for (int x = 20; x < width; x += 50) {
    if ((x / 50) % 2 == 0) {
      fill(220, 80, 80);
    } else {
      fill(80, 120, 210);
    }
    triangle(x, 55, x + 20, 55, x + 10, 75);
  }

  fill(100);
  rect(713, 28, 235, 67);
  fill(245, 235, 200);
  rect(705, 20, 235, 67);

  fill(50);
  textAlign(CENTER);
  textSize(18);
  text("ELECCIONES MUNICIPALES", 822, 45);
  textSize(22);
  text("FALTAN 7 DIAS", 822, 72);

  fill(90);
  rect(370, 275, 260, 65);
  fill(130, 90, 60);
  rect(360, 265, 260, 65);

  fill(225);
  rect(380, 180, 220, 85);

  fill(60);
  textSize(18);
  text("DEBATE CIUDADANO", 490, 215);

  fill(100, 70, 50);
  rect(465, 220, 50, 45);

  fill(230);
  rect(70, 220, 160, 100);
  fill(180, 60, 60);
  rect(70, 220, 160, 25);
  fill(50);
  textSize(16);
  text("CANDIDATO A", 150, 240);
  fill(120, 80, 50);
  rect(90, 275, 120, 25);

  fill(230);
  rect(770, 220, 160, 100);
  fill(70, 100, 190);
  rect(770, 220, 160, 25);
  fill(50);
  text("CANDIDATO B", 850, 240);
  fill(120, 80, 50);
  rect(790, 275, 120, 25);

  dibujarPersona(280, 300);
  dibujarPersona(330, 330);
  dibujarPersona(660, 310);
  dibujarPersona(710, 340);
  dibujarPersona(250, 355);
  dibujarPersona(750, 355);

  float movimiento = sin(frameCount / 20) * 3;
  fill(245, 240, 210);
  rect(255, 210 + movimiento, 90, 45);
  fill(50);
  textSize(13);
  text("TU VOTO\nCUENTA", 300, 227 + movimiento);

  fill(130, 160, 170);
  ellipse(500, 360, 160, 45);
  fill(90, 140, 170);
  ellipse(500, 350, 110, 30);
  fill(120, 180, 220);
  ellipse(500, 347, 90, 20);

  textAlign(LEFT);
}

void dibujarPersona(float x, float y) {
  fill(110, 110, 100);
  ellipse(x, y + 35, 30, 10);

  fill(50);
  rect(x - 8, y + 18, 6, 18);
  rect(x + 3, y + 18, 6, 18);

  fill(80, 120, 190);
  rect(x - 12, y - 5, 24, 25);

  fill(230, 180, 140);
  ellipse(x, y - 15, 22, 22);
}



// MOSTRAR INDICADORES DE LA CIUDAD


void mostrarIndicadores() {
  noStroke();
  fill(0, 170);
  rect(15, 15, 230, 145, 10);

  fill(255);
  textAlign(LEFT);
  textSize(16);
  text("ESTADO DE NOVA", 30, 40);

  textSize(13);
  text("Informacion: " + informacion, 30, 65);
  text("Convivencia: " + convivencia, 30, 85);
  text("Bienestar digital: " + bienestar, 30, 105);
  text("Participacion: " + participacion, 30, 125);
  text("Reputacion: " + reputacion, 30, 145);
}



// CAMBIAR INDICADORES


void cambiarIndicadores(
  int cambioInformacion,
  int cambioConvivencia,
  int cambioBienestar,
  int cambioParticipacion,
  int cambioReputacion
) {
  informacion += cambioInformacion;
  convivencia += cambioConvivencia;
  bienestar += cambioBienestar;
  participacion += cambioParticipacion;
  reputacion += cambioReputacion;

  informacion = constrain(informacion, 0, 100);
  convivencia = constrain(convivencia, 0, 100);
  bienestar = constrain(bienestar, 0, 100);
  participacion = constrain(participacion, 0, 100);
  reputacion = constrain(reputacion, 0, 100);
}
