#import "lib.typ" : join
#import "../font-sizes.typ" : *

#let thirdpage(school, year, title, subtitle, authors, department) = {
  set text(font: "New Computer Modern")
  set page(margin: (left: 120pt, right: 120pt, top: 90pt, bottom: 90pt))

  align(center + horizon,
    grid(
      rows: (auto, 1fr, auto),
      large(smallcaps[Master's thesis #year]),
      {
        x-large(weight: "bold", title)
        v(0.2cm)
        large(subtitle)
        v(1cm)
        large(upper(authors))
      },
      [
        #image("../img/AvancezChalmersU_black_centered.svg", width: 45%)
        #v(5mm)
        #department\
        #smallcaps(join(school, [\ ]))\
        Gothenburg, Sweden, #year
      ]
    )
  )
}
