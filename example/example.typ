//#import "mastery-chs/lib.typ" : template
#import "../lib.typ": template, appendices
#import "@preview/glossy:0.8.0": *
#import "glossary.typ": entry-list
#show: init-glossary.with(entry-list)

#let lorem = [Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.]

#show: template.with(
  // Override defaults fields here, such as title, authors, etc
  subject: "Programme Name",
  supervisor: ("Name", "Company or Department"),
  examiner: ("Name", "Department"),
  cover: [Wind visualization constructed in Matlab showing a surface of constant wind speed along with streamlines of the flow.],
  abstract: [#lorem],
  keywords: ("lorem", "ipsum", "dolor", "sit", "amet", "consectetur", "adipisicing", "elit", "sed", "do"),
  acknowledgements: [#lorem],
  glossary_enabled: true,
  cover_image: image("cover.jpg", width: 80%),
)

= Introduction

== Background

== Purpose

== Goals

== Limitations / Demarcations

This chapter presents the section levels that can be used in the template

== Section levels

The following table presents an overview of the section levels that are used in this document. The number of levels that are numbered and included in the table of contents is set in the settings file `Settings.tex`. The levels are shown in @Section_ref.

#table(
  columns: (auto, auto),
  align: horizon,
  table.header(
    [*Latex name*],
    [*Command*],
  ),

  [Chapter], [`= Chapter name`],
  [Section], [`== Section name`],
  [Subsection], [`=== Subsection name`],
  [Subsubsection], [`==== Subsubsection name`],
  [Paragraph], [`===== Paragraph name`],
  [Subparagraph], [`====== Subparagraph name`],
)


== Section <Section_ref>

=== Subsection

==== Subsubsection

===== Paragraph

====== Subparagraph

= New Chapter

#bibliography("example-refs.bib", style: "ieee")
#show: appendices

= Some appendix here <theappendix>

== wow
