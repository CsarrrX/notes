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
)

#let lemma = mathblock(
  blocktitle: "Lemma",
  counter: mathcounter,
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
)

#let definition = mathblock(
  blocktitle: "Definición",
  counter: mathcounter,
)

#let proof = mathblock(
  blocktitle: "Demostración",
  prefix: [_Demostración._],
  suffix: [#h(1fr) $square$],
)

// Paquetes extra
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
Una gran mayoría de los ejemplos que usamos para los conceptos del curso vienen del análisis topológico de datos, una rama en crecimiento de la topología aplicada. Cuando analizamos datos nos interesa medir distancias en nuestro muestreo (como el error de un modelo de regresión lineal multiple), y para eso necesitamos una buena noción de lo que significa medir, en concreto una buena noción de _distancia_ (Spoiler: *métricas*).

== Métricas
#definition[
  Sea $X$ un conjunto. una *métrica* es una función $d: X times X -> RR$, tal que:
  + $d(x, y) >= 0$
  + $d(x, y) <=> x = y$
  + $d(x, y) = d(y, x)$
  + *Desigualdad del triángulo:* $d(x, z) <= d(x, y) + d(y, z)$
]

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

#proposition[*(Distancia en $RR$)*
  Sea $d: RR times RR -> RR$ la función dada por $d(x, y) = abs(x - y)$. Entonces $d$ define una métrica sobre $RR$. 
]

#proof[
  Sea $d(x, y) = abs(x - y) $ para $x, y in RR$
  + Por definición de valor absoluto $abs(x - y) = d(x, y) >= 0$. 
  + Si $x = y$ entonces $x - y = 0$ y por lo tanto $abs(x - y) = d(x, y) = abs(0) = 0$. Además si $abs(x - y) = d(x, y) = 0$ entonces por definición de valor absoluto $x - y = 0$ lo que implica $x = y$. 
  + Por propiedades de valor absoluto $d(x, y) = abs(x - y) = abs(y - x) = d(y, x)$.
  + Desigualdad del triángulo: $d(x, z) = abs(x - z) = abs((x - y) + (y - z))$, por desigualdad triángular del valor absoluto en $RR$, para cualesquiera números $a, b in RR$ se cumple que $abs(a + b) <= abs(a) + abs(b)$. Sean $a = (x - y), b = (y - z)$ obtenemos $ d(x, z) = abs((x - y) + (y - z)) <= abs(x - y) + abs(y - z) $En terminos de la función: $d(x, z) <= d(x, y) + d(y, z)$ 
  Se concluye que $d$ define una métrica sobre $RR$.
]

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