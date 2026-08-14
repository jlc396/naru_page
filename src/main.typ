#let d = yaml("site.yaml")

#html.elem("html", attrs: (lang: "en"), {
  html.elem("head", {
    html.elem("meta", attrs: (charset: "utf-8"))
    html.elem("meta", attrs: (name: "description", content: d.site.description))
    html.elem("meta", attrs: (name: "keywords", content: d.site.keywords))
    html.elem("meta", attrs: (
      name: "viewport",
      content: "width=device-width, initial-scale=1",
    ))
    html.elem("title", d.site.title)

    html.elem("link", attrs: (
      href: "https://fonts.googleapis.com/css?family=Google+Sans|Noto+Sans|Castoro",
      rel: "stylesheet",
    ))
    html.elem("link", attrs: (
      rel: "stylesheet",
      href: "https://nerfies.github.io/static/css/fontawesome.all.min.css",
    ))
    html.elem("link", attrs: (
      rel: "stylesheet",
      href: "https://cdn.jsdelivr.net/gh/jpswalsh/academicons@1/css/academicons.min.css",
    ))
    html.elem("link", attrs: (rel: "stylesheet", href: "static/index.css"))
    if "favicon" in d.site {
      html.elem("link", attrs: (rel: "icon", href: d.site.favicon))
    }

    html.elem("script", attrs: (
      defer: "",
      src: "https://nerfies.github.io/static/js/fontawesome.all.min.js",
    ))
    html.elem("script", attrs: (type: "module", src: "static/client.js"))
  })
  html.elem("body", include "page.typ")
})
