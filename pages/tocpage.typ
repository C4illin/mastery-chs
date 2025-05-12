#import "@preview/glossy:0.8.0": *

#let in-outline = state("in-outline", false)

#let flex-caption(short, long) = context if in-outline.get() { short } else { long }

#let tocpage(figures, tables, glossary_enabled) = {
  set page(numbering: "i")

  v(100pt)

  show heading: set text(size: 24pt)
  align(center, heading(outlined: false)[Contents])

  v(55pt)

  show outline.entry: set outline.entry(fill: repeat("." + h(6pt)))
  show outline: it => {
    in-outline.update(true)
    it
    in-outline.update(false)
  }
  {
    show outline.entry.where(level: 1): set outline.entry(fill: none)
    show outline.entry.where(level: 1): it => {
      v(8pt)
      strong(it)
    }
    outline(title: none, indent: auto)
  }

  if figures {
    pagebreak(to: "odd")
    v(100pt)
    align(center, text(24pt)[= List of Figures])
    v(55pt)
    [
      #show outline.entry: set outline.entry(fill: repeat("." + h(6pt)))
      #outline(
        title: none,
        target: figure.where(kind: image),
      )
    ]
  }
  if tables {
    pagebreak(to: "odd")
    v(100pt)
    align(center, text(24pt)[= List of Tables])
    [
      #show outline.entry: set outline.entry(fill: repeat("." + h(6pt)))
      #outline(title: none, target: figure.where(kind: table))
    ]
  }

  if glossary_enabled {
    pagebreak(to: "odd")
    v(100pt)
    [
      #let my-theme = (
        // Main glossary section
        section: (title, body) => {
          align(center, text(24pt)[#heading(level: 1, title)])
          v(55pt)
          body
        },
        // Group of related terms
        group: (name, index, total, body) => {
          if name != "" and total > 1 {
            heading(level: 2, name)
          }

          table(
            columns: 2,
            stroke: none,
            align: horizon,
            inset: (x, y) => {
              if (x == 0) {
                (left: 0pt, rest: 5pt)
              } else if (x == 3) {
                (right: 0pt, rest: 5pt)
              } else {
                5pt
              }
            },
            // table.header([*Abbreviation*], [*Full Name*], [*Description*], [*Pages*]),
            ..body
          )
        },
        entry: (entry, index, total) => {
          (entry.short + entry.label, entry.long + box(width: 1fr, repeat("." + h(6pt))) + entry.pages)
        },
      )

      #glossary(
        title: "List of Acronyms",
        theme: my-theme,
        sort: true, // Optional: whether or not to sort the glossary
        ignore-case: true, // Optional: ignore case when sorting terms
        show-all: false, // Optional; Show all terms even if unreferenced
      )
    ]
  }
}
