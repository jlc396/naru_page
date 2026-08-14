#import "lib.typ": *
#import "tabs.typ": tabs

#let d = yaml("site.yaml")

#let navbar-data = d.at("navbar", default: none) // optional
#if (
  navbar-data != none
    and (
      navbar-data.at("homeHref", default: "") != ""
        or navbar-data.at("research", default: ()).len() > 0
    )
) {
  div(none, id: "navbar-root", none)
}

#section(cls: "masthead")[
  #div("container")[
    #html.elem("h1", attrs: (class: "publication-title"), d.masthead.title)
    #div("publication-authors")[
      #for (i, a) in d.masthead.authors.enumerate() [
        #author-span(a, last: i == d.masthead.authors.len() - 1)
      ]
    ]
    #if "author_comment" in d.masthead [
      #div("publication-authors author-note", d.masthead.author_comment)
    ]
    #div("publication-authors")[
      #for (i, aff) in d.masthead.affiliations.enumerate() [
        #html.elem("span", attrs: (class: "author-block"), {
          html.elem("sup", str(i + 1))
          aff
          if i < d.masthead.affiliations.len() - 1 { "," }
        })
      ]
    ]
    #div("publication-links")[
      #for l in d.masthead.links [#link-button(l)]
    ]
  ]
]

#section[
  #div("container narrow centered")[
    #include "content/introduction.typ"
  ]
]

#section[
  #div("container wide centered")[
    #title3[Workflow]
    #img(
      "static/workflow.svg",
      cls: "workflow-image",
      alt: "Workflow overview of NARUBench.",
    )
  ]
  #div("container narrow centered")[
    #include "content/workflow.typ"
  ]
]

#section[
  #div("container wide centered")[
    #title3[Experiment Results]
    #tabs((
      (
        key: "mcq",
        label: "Overall Performance",
        body: [#include "content/exp-rq1.typ"],
      ),
      (
        key: "temporal",
        label: "Effect of Temporal Evidence",
        body: [#include "content/exp-rq2.typ"],
      ),
      (
        key: "open",
        label: "Open-Ended Evaluation",
        body: [#include "content/exp-rq3.typ"],
      ),
    ))
  ]
]

#section[
  #div("container wide")[
    #div("centered")[#title3[Annotation Pipeline]]
    #include "content/pipeline.typ"
  ]
]

#section(id: "BibTeX")[
  #div("container")[
    #include "content/bibtex.typ"
  ]
]

#html.elem("footer")[
  #div("container")[
    #div("centered")[
      #html.elem(
        "a",
        attrs: (
          class: "icon-link",
          href: d.footer.paperPdf,
          aria-label: "Paper PDF",
        ),
        icon("fas fa-file-pdf"),
      )
      #html.elem(
        "a",
        attrs: (
          class: "icon-link",
          href: d.footer.github,
          aria-label: "GitHub",
        ),
        icon("fab fa-github"),
      )
    ]
    #div("container narrow centered")[
      Design inspired by #link("https://nerfies.github.io/")[Nerfies] · Built with Typst + Preact · #link("https://github.com/ma-labo/naru")[Source] under #link("http://creativecommons.org/licenses/by-sa/4.0/")[CC BY-SA 4.0]
    ]
  ]
]
