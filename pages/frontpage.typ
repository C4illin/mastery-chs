#import "lib.typ": join
#import "../font-sizes.typ": *

#let frontpage(school, year, title, subtitle, names, department, subject) = {
  let brown = rgb(144, 102, 78)
  let chalmersGray = cmyk(14%, 0%, 0%, 65%)
  let bg = block(
    inset: (left: 0.75cm, right: 0.75cm, top: 1cm, bottom: 1cm),
    grid(
      rows: (auto, 1fr),
      stack(
        dir: ttb,
        spacing: 0pt,
        image("../img/GrayHeaderPattern.jpg", width: 100%),
        place(
          bottom + left,
          image(
            "../img/AvancezChalmersU_white_right.svg",
            height: 18mm,
          ),
          dx: 40pt,
          dy: -12pt,
        ),
        line(length: 100%, stroke: brown + 4pt),
      )
    ),
  )

  set page(background: bg, margin: 50pt)
  set text(font: "New Computer Modern Sans")

  align(left + bottom)[
    #huge(weight: "bold", title)

    #x-large(subtitle)

    Master's thesis in #subject
    #v(0.75cm)
    #upper(x-large(names))
    #v(1.25cm)
  ]

  align(left + bottom)[
    #upper(text(fill: chalmersGray, weight: "bold")[#department])\
    #pad(x: -20pt, y: -10pt, line(length: 100%, stroke: chalmersGray + 1pt))
    #smallcaps(join(school, [\ ]))\
    Gothenburg, Sweden, #year\
    #link("https://www.chalmers.se")[www.chalmers.se]
    #v(1cm)
  ]
}
