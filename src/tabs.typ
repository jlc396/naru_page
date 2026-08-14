#let tabs(entries, vertical: false) = {
  let selectable = entries.filter(e => "key" in e)
  let first-key = selectable.first().key

  let bar = html.elem(
    "div",
    attrs: (
      class: if vertical { "tabs vertical" } else { "tabs" },
      role: "tablist",
    ),
    {
      for e in entries {
        if "key" in e {
          let active = e.key == first-key
          html.elem(
            "button",
            attrs: (
              type: "button",
              class: "tab"
                + (if e.at("indent", default: false) { " indent" } else { "" })
                + (if active { " is-active" } else { "" }),
              role: "tab",
              data-tab: e.key,
              aria-selected: if active { "true" } else { "false" },
            ),
            e.label,
          )
        } else {
          html.elem("div", attrs: (class: "tab-heading"), e.heading)
        }
      }
    },
  )

  let panels = for e in selectable {
    html.elem(
      "div",
      attrs: (
        class: if e.key == first-key { "tab-panel is-active" } else {
          "tab-panel"
        },
        data-panel: e.key,
        role: "tabpanel",
      ),
      e.body,
    )
  }

  if vertical {
    html.elem("div", attrs: (class: "vtabs"), {
      bar
      html.elem("div", attrs: (class: "vtab-panels"), panels)
    })
  } else {
    bar
    panels
  }
}
