#import "lib.typ" : join
#import "../font-sizes.typ" : *

#let lastpage(school, year, title, subtitle, names, department, subject) = {
  let brown = rgb(144,102,78)
  let chalmersGray = cmyk(14%,0%,0%,65%)
  let bg = block(
    inset: (left: 0.75cm, right: 0.75cm, top: 1cm, bottom: 1cm),
    grid(
      rows: (auto, 1fr),
      stack(
        dir: ttb,
        spacing: 0pt,
        box(fill: chalmersGray, height: 28mm, width: 100%),
        line(length: 100%, stroke: brown + 4pt)
      )
    )
  )

  set page(background: bg, margin: 40pt)
  set text(font: "New Computer Modern Sans", fill: white, size: 0.8em, weight: "bold")
  pad(left: 15mm)[#align(left + top)[
    #upper(department)\
    #upper(join(school, [\ ]))\
    Gothenburg, Sweden\
    #link("https://www.chalmers.se")[www.chalmers.se]
    #v(1cm)
  ]]

  align(center + bottom)[ #image("../img/AvancezChalmersU_black_centered.svg", width: 40mm)
  ]
  v(1cm)
}
