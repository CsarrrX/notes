// ------------------ CONFIGURACIONES GLOBALES ------------------

// Configuración del documento en general
#set page(
  paper: "a4",
  margin: 2.5cm,
)

#set text(
  font: "libertinus serif",
  size: 11pt,
  lang: "es",
)

#set par(
  justify: true,
  leading: 0.7em,
)

// Configuración de los headers 
#set heading(numbering: "1.")

// Configuración del titulo y autor
#set document(
  author: "César Pérez",
  date: datetime.today(),
  title: "Notas de topología y sus aplicaciones",
)
#show title: set text(size: 20pt, weight: "bold")
#show title: set align(center)
#show title: set block(below: 1.2em)

#let displayauthor() = align(center)[
  César Pérez \ 
  Universidad De Las Americas Puebla \
  #link("mailto: cesar.perezar@udlap.mx")
]

// Envs personalizados:
#import "@preview/great-theorems:0.1.2": *
#import "@preview/rich-counters:0.2.1": *

#show: great-theorems-init

#let mathcounter = rich-counter(
  identifier: "mathblocks",
  inherited_levels: 1
)

#let theorem = mathblock(
  blocktitle: "Teorema",
  counter: mathcounter,
  breakable: false
)

#let lemma = mathblock(
  blocktitle: "Lemma",
  counter: mathcounter,
  breakable: false
)

#let remark = mathblock(
  blocktitle: "Nota",
  prefix: [_Nota._],
)

#let example = mathblock(
  blocktitle: "Ejemplo",
  prefix: [_Ejemplo._],
)

#let proposition = mathblock(
  blocktitle: "Proposición",
  counter: mathcounter,
  breakable: false
)

#let definition = mathblock(
  blocktitle: "Definición",
  counter: mathcounter,
  breakable: false
)

#let proof = mathblock(
  blocktitle: "Demostración",
  prefix: [_Demostración._],
  suffix: [#h(1fr) $square$],
)

// Paquetes extra
#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge // diagramas


// ------------------ FIN CONFIGURACIONES GLOBALES ------------------

// ------------------ CONTENIDO ------------------

// Titulo y autor
#title()
#displayauthor()
#pagebreak()

// Tabla de contenidos
#outline()
#pagebreak()

// Capitulo 1
= Espacios métricos
Una gran mayoría de los ejemplos que usamos para los conceptos del curso vienen del análisis topológico de datos, una rama en crecimiento de la topología aplicada. Cuando analizamos datos nos interesa medir distancias en nuestro muestreo (por ejemplo, el error de un modelo de regresión lineal multiple se mide tomando las distancias de cada medición real con la predicción), y para eso necesitamos una buena noción de lo que significa medir, en concreto una buena noción de _distancia_ (Spoiler: *métricas*).

== Métricas
#definition(title: "Métrica")[
  Sea $X$ un conjunto. una *métrica* es una función $d: X times X -> RR$, tal que:
  + $d(x, y) >= 0$
  + $d(x, y) <=> x = y$
  + $d(x, y) = d(y, x)$
  + *Desigualdad del triángulo:* $d(x, z) <= d(x, y) + d(y, z)$
] <dfn1>

#align(center)[
#diagram(
  let (x, y, z) = ((0, 1), (2, 0), (3, 1)),
  spacing: 30pt,
  node(x, $x$),
  node(y, $y$),
  node(z, $z$),
  
  edge(x, y, "<->", label-angle: auto, $d(x, y)$),
  edge(x, z, "<->", label-anchor: "center", label-sep: -10pt, $d(x, z)$),
  edge(y, z, "<->", label-angle: auto, $d(y, z)$),
)
]

#example[
  Tomemos como "métrica" el tiempo que toma llegar de un punto a otro, sabemos que el tiempo transcurrido siempre es positivo, por lo tanto 1. se cumple. Si nos toma 0 unidades de tiempo llegar a un punto significa que estamos parados justamente en ese punto, entonces 2. se cumple. Sin embargo, el tiempo que nos toma ir de un punto $x$ a un punto $y$ no siempre es igual que el tiempo que nos toma ir de $y$ a $x$, por lo tanto este ejemplo *no* es una métrica.
]

#remark[
  A esta pseudo-métrica se le conoce como la *métrica del alpinista*, ya que para un alpinista toma más tiempo llegar a la sima de la montaña que a la cima. 
]

#proposition(title: "Distancia en los reales")[
  Sea $d: RR times RR -> RR$ la función dada por $d(x, y) = abs(x - y)$. Entonces $d$ define una métrica sobre $RR$. 
] <prop1>

#proof[
  Sea $d(x, y) = abs(x - y) $ para $x, y in RR$
  + Por definición de valor absoluto $abs(x - y) = d(x, y) >= 0$. 
  + Si $x = y$ entonces $x - y = 0$ y por lo tanto $abs(x - y) = d(x, y) = abs(0) = 0$. Además si $abs(x - y) = d(x, y) = 0$ entonces por definición de valor absoluto $x - y = 0$ lo que implica $x = y$. 
  + Por propiedades de valor absoluto $d(x, y) = abs(x - y) = abs(y - x) = d(y, x)$.
  + Desigualdad del triángulo: $d(x, z) = abs(x - z) = abs((x - y) + (y - z))$, por desigualdad triángular del valor absoluto en $RR$, para cualesquiera números $a, b in RR$ se cumple que $abs(a + b) <= abs(a) + abs(b)$. Sean $a = (x - y), b = (y - z)$ obtenemos $ d(x, z) = abs((x - y) + (y - z)) <= abs(x - y) + abs(y - z) $En terminos de la función: $d(x, z) <= d(x, y) + d(y, z)$ 
  Se concluye que $d$ define una métrica sobre $RR$.
]

#remark[
  Para 4. utilizamos una desigualdad auxiliar, en muchas de las demostraciones de funciones como métricas para demostrar la desigualdad del triángulo vamos a utilizar este tipo de desigualdades.
]

Ahora, veamos ejemplos comunes (y muy utilizados en otras asignaturas) de métricas en $RR^n$:

#proposition(title: "Métrica de Manhattan")[
  Sean $arrow(x) = (x_1, ..., x_n) in RR^n, arrow(y) = (y_1, ..., y_n) in RR^n$ y \ $d:RR^n times RR^n -> RR$ la función dada por: $ d(arrow(x), arrow(y)) = sum_(i=1)^n abs(x_i - y_i) $ Entonces $d$ define una métrica sobre $RR^n$
]

#proof[
  Sean $arrow(x) = (x_1, ..., x_n) in RR^n, arrow(y) = (y_1, ..., y_n) in RR^n, arrow(z) = (z_1, ..., z_n) in RR^n$, \ $alpha in {1, ..., n}$ y $ d(arrow(x), arrow(y)) = sum_(i=1)^n abs(x_i - y_i) $ 
  + Cada uno de los sumandos $abs(x_alpha - y_alpha) >= 0$ entonces $ d(arrow(x), arrow(y)) = sum_(i=1)^n abs(x_i - y_i) >= 0 $ 
  + Si $arrow(x) = arrow(y)$ entonces $x_alpha = y_alpha$ por lo que $x_alpha - y_alpha = 0$, por lo tanto $ d(arrow(x), arrow(y)) = sum_(i=1)^n abs(x_i - y_i) = sum_(i=1)^n abs(0) = 0 $ Además, tenemos que si $d(arrow(x), arrow(y)) = 0$ entonces cada uno de los sumandos $abs(x_alpha - y_alpha) = 0,$ y $x_alpha = y_alpha$ por lo tanto $arrow(x) = arrow(y)$ 
  + Como $abs(x_alpha - y_alpha) = abs(y_alpha - x_alpha)$ entonces $ d(arrow(x), arrow(y)) = sum_(i=1)^n abs(x_i - y_i) = sum_(i=1)^n abs(y_i - x_i) = d(arrow(y), arrow(x)) $
  + Por @prop1 tenemos que $abs(x_alpha - z_alpha) <= abs(x_alpha - y_alpha) + abs(y_alpha - z_alpha)$ entonces por axiomas de orden en $RR$ tenemos que $ (d(x, z) = sum_(i=1)^n abs(x_i - z_i)) <= (sum_(i=1)^n abs(x_i - y_i) + sum_(i=1)^n abs(y_i - z_i) = d(x, y) + d(y, z)) $
  Se concluye que $d$ define una métrica sobre $RR^n$
]

#remark[
  Se le conoce como métrica de Manhattan ya que en $RR^2$ al visualizar la métrica se "parece" a las calles de Nueva York, en el sentido que es de _izquierda a derecha_ y _arriba a abajo_ y no en diagonal:
]

#align(center)[
#cetz.canvas({
  import cetz.draw: *

  // --- CONFIGURACIÓN ---
  let xp = 1.5; let yp = 1.5
  let xq = 5.5; let yq = 3.5
  
  // Estilos
  let axis-style = (thickness: 1pt, paint: black)
  let dash-style = (dash: "dashed", paint: black) 
  let point-style = (fill: red, stroke: none, radius: 0.08) 
  
  // --- 1. EJES ---
  line((-1, 0), (6.5, 0), stroke: axis-style) // Eje X
  line((0, -1), (0, 5), stroke: axis-style)   // Eje Y

  // --- 2. PROYECCIONES A LOS EJES (Solo a los ejes) ---
  // Proyecciones hacia el Eje X
  line((xp, 0), (xp, yp), stroke: dash-style) // De P abajo
  line((xq, 0), (xq, yq), stroke: dash-style) // De Q abajo
  
  // Proyecciones hacia el Eje Y
  line((0, yp), (xp, yp), stroke: dash-style) // De P izquierda
  line((0, yq), (xq, yq), stroke: dash-style) // De Q izquierda
  
  // (Se eliminaron las proyecciones internas que conectaban P y Q directamente)

  // --- 3. PUNTOS Y ETIQUETAS P/Q ---
  circle((xp, yp), ..point-style)
  content((xp, yp), [$P$], anchor: "north-east", padding: 0.15)
  
  circle((xq, yq), ..point-style)
  content((xq, yq), [$Q$], anchor: "south-west", padding: 0.15)

  // --- 4. LLAVES Y TEXTO DE DISTANCIA ---

  // --- Horizontal: |x_1 - y_1| ---
  let h-brace-y = -0.6 
  let h-text-y = -1.2  
  
  line((xp, h-brace-y), (xq, h-brace-y), stroke: (paint: black))
  line((xp, h-brace-y - 0.1), (xp, h-brace-y + 0.1), stroke: (paint: black)) 
  line((xq, h-brace-y - 0.1), (xq, h-brace-y + 0.1), stroke: (paint: black)) 
  
  content(((xp + xq)/2, h-text-y), text(size: 10pt)[$|x_1 - y_1|$])


  // --- Vertical: |x_2 - y_2| ---
  let v-brace-x = -0.6 
  let v-text-x = -1.8  
  
  line((v-brace-x, yp), (v-brace-x, yq), stroke: (paint: black))
  line((v-brace-x - 0.1, yp), (v-brace-x + 0.1, yp), stroke: (paint: black)) 
  line((v-brace-x - 0.1, yq), (v-brace-x + 0.1, yq), stroke: (paint: black)) 
  
  content((v-text-x, (yp + yq)/2), text(size: 10pt)[$|x_2 - y_2|$])

})
]

#proposition(title: "Métrica euclidiana")[
  Sean $arrow(x) = (x_1, ..., x_n) in RR^n, arrow(y) = (y_1, ..., y_n) in RR^n$ y \ $d:RR^n times RR^n -> RR$ la función dada por: $ d(arrow(x), arrow(y)) = sqrt(sum_(i=1)^n (x_i - y_i)^(2)) $ Entonces $d$ define una métrica sobre $RR^n$
] <prop2>

#proof[
  Sean $arrow(x) = (x_1, ..., x_n) in RR^n, arrow(y) = (y_1, ..., y_n) in RR^n, alpha in {1, ..., n}$ y $ d(arrow(x), arrow(y)) = sqrt(sum_(i=1)^n (x_i - y_i)^(2)) $ 
  + Cada uno de los sumandos $(x_alpha - y_alpha)^2 >= 0$ entonces $ d(arrow(x), arrow(y)) = sqrt(sum_(i=1)^n (x_i - y_i)^(2)) >= 0 $ 
  + Si $arrow(x) = arrow(y)$ entonces $x_alpha = y_alpha$ por lo que $x_alpha - y_alpha = 0$, por lo tanto $ d(arrow(x), arrow(y)) = sqrt(sum_(i=1)^n (x_i - y_i)^(2)) = sqrt(sum_(i=1)^n (0)^(2)) = 0 $ Además, tenemos que si $d(arrow(x), arrow(y)) = 0$ entonces cada uno de los sumandos $(x_alpha - y_alpha)^2 = 0$ y \ $x_alpha = y_alpha$ por lo tanto $arrow(x) = arrow(y)$ 
  + Como $(x_alpha - y_alpha)^2 = (y_alpha - x_alpha)^2$ entonces $ d(arrow(x), arrow(y)) = sqrt(sum_(i=1)^n (x_i - y_i)^(2)) = sqrt(sum_(i=1)^n (y_i - x_i)^(2)) = d(arrow(y), arrow(x)) $
  + To be continued (Spoiler: *Desigualdad de Cauchy-Schwarz*)
]

== Métricas para datos categoricos
== Distancia entre funciones
== Normas
== Distancias entre distancias
== Espacios
== La desigualdad de Cauchy-Schwarz

// Capitulo 2
= Conceptos fundamentales de topología
== Bolas
== Conjuntos abiertos y propiedades de bolas
== Topología
== Conjuntos cerrados
== Subespacios
== Frontera, clausura, interior y exterior
== Continuidad
// ------------------ FIN CONTENIDO ------------------