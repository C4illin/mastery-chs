#import "pages/frontpage.typ" : frontpage
#import "pages/thirdpage.typ" : thirdpage
#import "pages/fourthpage.typ" : fourthpage
#import "pages/abspage.typ" : abspage
#import "pages/ackpage.typ" : ackpage
#import "pages/tocpage.typ" : tocpage
#import "pages/lastpage.typ" : lastpage
#import "font-sizes.typ"

/// Creates a footer which displays the page counter with the given args, at the
/// right side on odd pages and at the left side on even pages.
#let footer(..args) = context if counter(page).get().at(0).bit-and(1) == 0 {
  align(left, counter(page).display(..args))
} else {
  align(right, counter(page).display(..args))
}

/// Creates a header that, on non-chapter pages, calculates text by the given
/// `text` function taking the chapter index and name, and adding a line below.
///
/// ```
/// #import "@preview/mastery-chs:0.1.0" : header
/// #set page(header: header(text: (idx, name) => [Chapter #idx: #name]))
/// ```
#let header(text: (idx, name) => [#idx. #name]) = context {
  // check if the next title page is this page
  let nextsel = selector(heading.where(level: 1)).after(here())
  let nextheaders = query(nextsel)
  let needsheader = true
  if nextheaders.len() > 0 {
    if nextheaders.first().location().page() == here().page() {
      // skip header if that is the case
      needsheader = false
    }
  }

  // if we want a header, find the appropriate heading
  if needsheader {
    let prevsel = selector(heading.where(level: 1)).before(here())
    let prevheaders = query(prevsel)
    if prevheaders.len() > 0 {
      text(counter(heading).get().at(0), prevheaders.last().body)
      line(length: 100%)
    }
  }
}

/// Creates the prelude pages of the Chalmers Master's Thesis template. This
/// includes the front page, the cover page, the inside of the cover page,
/// the abstract page, the acknowledgement page, and the table of contents.
/// Resets the page counter afterwards.
///
/// Note: You most likely want to use the `template` function in a `show` rule
/// instead, which sets the style as well
#let pages(school, date, title, subtitle, authors, department, subject, supervisor, examiner, abstract, keywords, acknowledgements, figures, tables) = {
  let blankpagebreak(..args) = {
    set page(footer: none)
    pagebreak(..args)
  }

  // first page
  frontpage(school, date.year(), title, subtitle, authors.join([\ ]), department, subject)

  // third page (cover page)
  pagebreak(to: "odd")
  thirdpage(school, date.year(), title, subtitle, authors.join([\ ]), department)

  // fourth page (inside cover page)
  pagebreak(to: "even")
  set page(footer: footer("i"))
  fourthpage(school, date.year(), title, subtitle, authors, department, supervisor, examiner)

  // abstract page
  abspage(school, title, subtitle, authors, department, abstract, keywords)

  // acknowledgement page
  blankpagebreak(to: "odd")
  ackpage(date, authors, acknowledgements)

  // toc
  blankpagebreak(to: "odd")
  set page(
    footer: footer("i"),
    header: header(text: (idx, body) => body)
  )
  tocpage(figures, tables)

  // skip to next odd page, reset page counter
  pagebreak(to: "odd")
  counter(page).update(1)
}

/// Instantiates the Chalmers University of Technology template. Should be used
/// in a `show` rule:
///
/// ```
/// #import "@preview/mastery-chs:0.1.0" : template
/// #show template.with(
///   school: ("Chalmers University of Technology", "University of Gothenburg"),
///   title: "My amazing Master's Thesis"
///   authors: ("Author 1", "Author 2")
/// )
/// ```
///
/// The arguments supported are:
/// - `font-size`: The default font size (default: 12pt)
/// - `school`: One or multiple universities (a string or array)
/// - `date`: The date of the thesis (default: today)
/// - `title`: The title of the thesis
/// - `subtitle`: The subtitle of the thesis
/// - `authors`: Array of the authors
/// - `department`: Department of issuing the thesis
/// - `subject`: Subject, like `Computer Science and Engineering`
/// - `supervisor`: Pair `(name, department)` of the supervisor
/// - `examiner`: Pair `(name, department)` of the examiner
/// - `abstract`: Content that should appear in the abstract
/// - `keywords`: (Possibly empty) array of keywords
/// - `acknowledgements`: Content that should appear in the acknowledgements
/// - `figures`: Bool on if to include table of figures
/// - `tables`: Bool on if to include table of tables
///
/// Full example:
/// ```
/// #import "@preview/mastery-chs:0.1.0" : template
/// #let department = "Department of Computer Science and Engineering"
/// #show: template.with(
///   school: ("Chalmers University of Technology", "University of Gothenburg"),
///   title: "Developing a Backend-Compatibility Check for the BNF Converter",
///   subtitle: "And Implementing a Blazingly-Fast BNFC Back-End in Rust",
///   authors: ("Jonathan Widén", "Leopold Wigbratt"),
///   supervisor: ("Andreas Abel", department),
///   examiner: ("Carl-Johan Seger", department),
///   department: department,
///   subject: "Computer Science and Engineering"
/// )
/// ```
///
/// In addition to creating the prelude pages (by the `pages` function), this
/// function puts top-level headings (chapters) on a new odd page, adds headings
/// to non-chapter pages, and adds a footer to all pages
#let template(
  font-size: 12pt,
  school: "Chalmers University of Technology",
  date: datetime.today(),
  title: "My Thesis Title",
  subtitle: "My Thesis Subtitle",
  authors: ("Author 1", "Author 2"),
  department: "Department of Tech",
  subject: "Science",
  supervisor: ("Mr Supervisor", "Department"),
  examiner: ("Mr Examiner", "Department"),
  abstract: [My abstract goes here],
  keywords: ("Keyword 1", "keyword 2"),
  acknowledgements: [My acknowledgements goes here],
  figures: true,
  tables: true,
  content
) = {
  set text(font-size)
  set page(
    footer: none,
    numbering: "i"
  )

  // prelude pages
  pages(school, date, title, subtitle, authors, department, subject, supervisor, examiner, abstract, keywords, acknowledgements, figures, tables)

  // default page style
  set page(
    footer: footer("1"),
    header: header(),
    numbering: "1"
  )

  // Make the "Figure/Table" text in captions bold and left align wider captions
  show figure.caption: it => box(
    align(left)[
      #text(weight: "bold")[
        #it.supplement
        #context it.counter.display(it.numbering) 
      ]
      #it.separator#it.body
    ]
  )

  // Make captions for figures containing tables display above the table
  show figure.where(
  kind: table
  ): set figure.caption(position: top)

  set heading(numbering: "1.1")
  counter(heading).update(0)

  show heading.where(level: 1): it => context {
    pagebreak(to: "odd", weak: true)
    align(center, {
      v(30pt)
      text(64pt, weight: "regular", str(counter(heading).get().at(0)))
      v(-30pt)
      text(38pt, it.body)
      v(20pt)
    })
  }

  content

  pagebreak()
  set page(
    footer: none,
    header: none,
  )
  lastpage(school, date.year(), title, subtitle, authors.join([\ ]), department, subject)
}
