#import "../tabs.typ": tabs

#let prompt(path) = html.elem(
  "pre",
  attrs: (class: "prompt"),
  html.elem("code", read(path)),
)

#tabs(
  vertical: true,
  (
    (
      key: "chunking",
      label: "1. Chunking",
      body: prompt("../../assets/prompts/chunking.md"),
    ),
    (
      key: "segmentation",
      label: "2. Semantic Segmentation",
      body: prompt("../../assets/prompts/segmentation.md"),
    ),
    (heading: "3. Task-Oriented Annotation"),
    (
      key: "narrative",
      label: "3.a Narrative Module",
      indent: true,
      body: prompt("../../assets/prompts/narrative.md"),
    ),
    (
      key: "culture",
      label: "3.b Culture Module",
      indent: true,
      body: prompt("../../assets/prompts/culture.md"),
    ),
  ),
)
