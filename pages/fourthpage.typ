#import "lib.typ" : join
#import "../font-sizes.typ" : *

#let fourthpage(school, year, title, subtitle, authors, department, supervisor, examiner) = {
  grid(rows: (1fr, auto),
    {
      let vv = v(1cm)
      v(4.5cm)
      [
        #title\
        #subtitle\
        #smallcaps(authors.join[\ ])
      ]
      vv
      [
        #sym.copyright #authors.join(", "), #year
      ]
      vv
      grid(
        columns: (auto, auto, auto),
        gutter: 6pt,
        "Supervisor:", [#supervisor.at(0),], supervisor.at(1),
        "Examiner:", [#examiner.at(0),], examiner.at(1)
      )
      vv
      [
        Master's thesis #year\
        #department\
        #join(school, ", ", last: " and ")\
        SE-412 96 Gothenburg\
        Telephone +46 31-772 10 00
      ]
    },
    [
      Typeset in Typst\
      Gothenburg, Sweden, #year
    ]
  )
  pagebreak()
}