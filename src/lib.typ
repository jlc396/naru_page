#let brand(body) = html.elem("span", attrs: (class: "brand"), body)

#let title3(body) = html.elem("h2", body)

#let title4(body) = html.elem("h3", body)

#let title(body) = html.elem("h2", body)

#let div(cls, body, id: none) = {
  let attrs = (:)
  if cls != none { attrs.insert("class", cls) }
  if id != none { attrs.insert("id", id) }
  html.elem("div", attrs: attrs, body)
}

#let section(body, cls: none, id: none) = {
  let attrs = (:)
  if cls != none { attrs.insert("class", cls) }
  if id != none { attrs.insert("id", id) }
  html.elem("section", attrs: attrs, body)
}

#let icon(cls) = html.elem("i", attrs: (class: cls), none)

#let img(src, cls: none, alt: "") = {
  let attrs = (src: src, alt: alt)
  if cls != none { attrs.insert("class", cls) }
  html.elem("img", attrs: attrs, none)
}

#let link-button(l) = html.elem(
  "a",
  attrs: (href: l.href, class: "pill"),
  {
    icon(l.icon)
    html.elem("span", l.label)
  },
)

#let author-span(a, last: false) = html.elem(
  "span",
  attrs: (class: "author-block"),
  {
    if "href" in a { html.elem("a", attrs: (href: a.href), a.name) } else {
      a.name
    }
    html.elem("sup", a.sup)
    if not last { "," }
  },
)
