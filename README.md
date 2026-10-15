# Nova — Ciudadanía digital y desinformación

> 🚧 **Proyecto en desarrollo.** Esta versión es un prototipo jugable y algunas mecánicas, contenidos y elementos visuales pueden cambiar.

**Nova** es un prototipo interactivo desarrollado con **Processing** que explora cómo nuestras decisiones en redes sociales pueden influir en una comunidad. A través de distintos escenarios de una ciudad ficticia, el jugador encuentra publicaciones y decide si compartirlas, verificarlas/reportarlas o ignorarlas. Cada decisión modifica los indicadores generales de la ciudad.

## 🎯 Objetivo del proyecto

Promover la reflexión sobre la ciudadanía digital, la verificación de información y las consecuencias de compartir contenido en redes sociales.

## 🕹️ Funcionalidades actuales

- **Tres escenarios:** barrio, colegio y plaza electoral.
- **Movimiento del jugador** por el escenario activo.
- **Red social ficticia “Conecta”** integrada en la interfaz.
- **Publicaciones con indicadores** de confiabilidad y viralidad.
- **Tres decisiones posibles** ante cada publicación: compartir, verificar/reportar o ignorar.
- **Indicadores del estado de Nova** que cambian según las decisiones:
  - Información
  - Convivencia
  - Bienestar digital
  - Participación
  - Reputación
- **Aviso visual** cuando hay una publicación pendiente en el escenario actual.

## 🗺️ Escenarios

| Escenario | Contenido de ejemplo |
|---|---|
| Barrio | Una publicación sobre un torneo deportivo en el parque. |
| Colegio | Una publicación sobre una fotografía compartida sin permiso. |
| Plaza electoral | Una publicación sobre una propuesta atribuida a un candidato. |

Las publicaciones incluidas son ejemplos del prototipo y pueden modificarse durante el desarrollo.

## 🎮 Controles

| Tecla / acción | Función |
|---|---|
| `W` | Moverse hacia arriba |
| `A` | Moverse hacia la izquierda |
| `S` | Moverse hacia abajo |
| `D` | Moverse hacia la derecha |
| `1` | Seleccionar el escenario Barrio cuando Conecta está cerrada; dentro de Conecta, compartir la publicación |
| `2` | Seleccionar el escenario Colegio cuando Conecta está cerrada; dentro de Conecta, verificar/reportar |
| `3` | Seleccionar el escenario Plaza cuando Conecta está cerrada; dentro de Conecta, ignorar la publicación |
| `C` | Abrir o cerrar Conecta |
| Clic en el icono del teléfono | Abrir o cerrar Conecta |
| Clic en una opción | Elegir una decisión dentro de Conecta |

**Nota:** el cambio de escenario se realiza con Conecta cerrada. Cuando la red está abierta, las teclas `1`, `2` y `3` sirven para responder a la publicación pendiente.

## 📊 ¿Cómo afectan las decisiones a Nova?

Los indicadores comienzan en **50 puntos** y se mantienen dentro del rango de **0 a 100**.

| Decisión | Efecto en la publicación | Efecto en los indicadores |
|---|---|---|
| Compartir | Aumenta la viralidad en 20 puntos. | Información −10, convivencia −5, bienestar digital −5, participación +5, reputación −10. |
| Verificar / reportar | Reduce la viralidad en 15 puntos. | Información +15, convivencia +10, bienestar digital +5, participación +10, reputación +10. |
| Ignorar | No modifica la viralidad. | Bienestar digital +5. Los demás indicadores no cambian. |

Los valores se limitan al rango de 0 a 100. Cada publicación se marca como procesada después de elegir una opción.

## 🛠️ Tecnologías

- **Processing** (lenguaje basado en Java).
- Dibujo 2D y animación mediante las funciones de Processing.
- Gestión de teclado, ratón, escenarios, publicaciones e indicadores mediante código.

## 🚀 Cómo ejecutar el proyecto

1. Instala [Processing](https://processing.org/download).
2. Descarga o clona este repositorio.
3. Abre el archivo del sketch en Processing.
4. Ejecuta el sketch con el botón **Run**.

> El código compartido utiliza funciones propias de Processing, como `setup()`, `draw()`, `size()` y `background()`. Por ello, debe ejecutarse en Processing y no como una página web independiente.

## 📁 Estructura del proyecto

La estructura puede ajustarse a medida que el proyecto crezca. En la versión actual, la lógica se encuentra en un sketch de Processing organizado por bloques:

- Variables generales y navegación.
- Datos de las publicaciones de Conecta.
- Inicialización y ciclo principal.
- Interfaz de la red social.
- Procesamiento de decisiones.
- Controles de teclado y ratón.
- Movimiento y representación del jugador.
- Dibujo de los tres escenarios.
- Visualización y actualización de los indicadores.

## 🚧 Estado del desarrollo

El proyecto se encuentra en una fase de prototipo. Actualmente incluye los tres escenarios, el movimiento básico, la interfaz de Conecta, las decisiones sobre publicaciones y la actualización de indicadores.

Las próximas mejoras dependerán de la evolución del proyecto. Algunas posibles líneas de trabajo son:

- Mejorar la interfaz y los elementos visuales.
- Incorporar más publicaciones y situaciones.
- Ampliar las consecuencias de las decisiones.
- Añadir objetivos, progresión o un sistema de resultados.
- Refactorizar el código en archivos o módulos más pequeños.

Estas ideas son propuestas de mejora, no funcionalidades ya implementadas.

## 🤝 Contribuciones

Si deseas contribuir, puedes abrir un *issue* para reportar errores o proponer mejoras, o enviar un *pull request* con tus cambios.

## 📄 Licencia

Todavía no se ha especificado una licencia. Añade una licencia al repositorio si quieres definir cómo otras personas pueden usar, modificar y distribuir el proyecto.

---

**Nova** es un proyecto en evolución sobre las decisiones digitales y su impacto en la vida colectiva.
