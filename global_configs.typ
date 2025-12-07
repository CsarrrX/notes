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
  title: "CAMBIAR TITULO",
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

#let proposition = mathblock(
  blocktitle: "Proposición",
  counter: mathcounter,
)

#let proof = mathblock(
  blocktitle: "Demostración",
  counter: mathcounter,
)

#let definition = mathblock(
  blocktitle: "Definición",
  counter: mathcounter,
)

#let proof = proofblock()

// ------------------ FIN CONFIGURACIONES GLOBALES ------------------
