// from c2e6453 & cea54f1
#import "../tabs.typ": tabs

#let i(t) = html.elem("em", t)
#let sb(t) = html.elem("sub", t)
#let sp(t) = html.elem("sup", t)
#let kw(t) = html.elem("span", attrs: (class: "kw"), t)
#let cm(t) = html.elem("span", attrs: (class: "comment"), {
  "▹ "
  t
})
#let ln(body, ind: 0) = html.elem("li", html.elem(
  "span",
  attrs: (
    class: "algo-line" + ("", " indent", " indent2", " indent3").at(ind),
  ),
  body,
))
#let note(body) = html.elem("div", attrs: (class: "algo-note"), body)
#let algorithm(label, title, lines) = html.elem(
  "div",
  attrs: (class: "algorithm", aria-label: title),
  {
    html.elem("div", attrs: (class: "algorithm-caption"), {
      html.elem("span", attrs: (class: "algorithm-label"), label)
      title
    })
    html.elem("ol", attrs: (class: "algorithm-body"), lines)
  },
)

#html.elem(
  "p",
  attrs: (class: "section-lead"),
  "Detailed pseudocode referenced in the paper for video selection and iterative MCQ debiasing.",
)
#tabs(
  vertical: true,
  (
    (
      key: "filtering",
      label: "1. Diversity Filtering",
      body: [
        #note[
          Incremental semantic diversity filtering used during video selection.
          Titles and descriptions are embedded with #html.elem("code", "text-embedding-3"); a candidate is kept only if its cosine similarity to every selected sample is at most #i("τ") = 0.85.
          The initial seed set size is #i("q") = 30.
        ]
        #algorithm("Algorithm 1", "Incremental Semantic Diversity Filtering", {
          ln({
            kw("Require:")
            " Stream of candidates "
            i({
              "D"
              sb("in")
            })
            ", embedding model "
            i("φ(·)")
            ", cosine similarity threshold "
            i("τ")
            ", initial set size threshold "
            i("q")
          })
          ln({
            kw("Ensure:")
            " Filtered dataset "
            i("S")
          })
          ln({
            i("S")
            " ← LoadCachedState() "
            cm("Initialize with persisted data")
          })
          ln({
            kw("for")
            " "
            i("x")
            " ∈ "
            i({
              "D"
              sb("in")
            })
            " "
            kw("do")
          })
          ln(ind: 1, {
            i({
              "v"
              sb("x")
            })
            " ← "
            i("φ")
            "("
            i("x")
            ") "
            cm("Generate normalized embedding")
          })
          ln(ind: 1, {
            kw("if")
            " |"
            i("S")
            "| < "
            i("q")
            " "
            kw("then")
          })
          ln(ind: 2, {
            i("S")
            " ← "
            i("S")
            " ∪ {("
            i("x")
            ", "
            i({
              "v"
              sb("x")
            })
            ")}"
          })
          ln(ind: 1, kw("else"))
          ln(ind: 2, {
            "Let "
            i({
              "V"
              sb("S")
            })
            " be the set of vectors currently in "
            i("S")
          })
          ln(ind: 2, {
            i({
              "σ"
              sb("max")
            })
            " ← max"
            sb({
              i({
                "v"
                sb("s")
              })
              " ∈ "
              i({
                "V"
                sb("S")
              })
            })
            " ("
            i({
              "v"
              sb("x")
            })
            sp("⊤")
            " "
            i({
              "v"
              sb("s")
            })
            ") "
            cm("Max cosine similarity")
          })
          ln(ind: 2, {
            kw("if")
            " "
            i({
              "σ"
              sb("max")
            })
            " ≤ "
            i("τ")
            " "
            kw("then")
          })
          ln(ind: 3, {
            i("S")
            " ← "
            i("S")
            " ∪ {("
            i("x")
            ", "
            i({
              "v"
              sb("x")
            })
            ")} "
            cm("Add distinctive sample")
          })
          ln(ind: 3, {
            "UpdateCache("
            i("S")
            ")"
          })
          ln(ind: 2, kw("else"))
          ln(ind: 3, {
            kw("continue")
            " "
            cm("Reject redundant sample")
          })
          ln(ind: 2, kw("end if"))
          ln(ind: 1, kw("end if"))
          ln(kw("end for"))
          ln({
            kw("return")
            " "
            i("S")
          })
        })
      ],
    ),
    (
      key: "solver-critic",
      label: "2. Solver–Critic Loop",
      body: [
        #note[
          Iterative debiasing for generated MCQs.
          A Blind Solver ensemble answers each item with the video withheld; a Diagnostic Agent attributes any success to a vulnerability and emits a Refine Plan; a Distractor Patching Agent rewrites only the implicated distractor.
          The stem and correct answer stay fixed.
          The loop continues until no open item remains vulnerable or the round budget #i("R") is exhausted.
        ]
        #algorithm(
          "Algorithm 2",
          "Iterative Debiasing via the Solver–Critic Loop",
          {
            ln({
              kw("Require:")
              " MCQ batch "
              i("Q")
              ", Blind-Solver ensemble size "
              i("N")
              ", maximum rounds "
              i("R")
            })
            ln({
              kw("Ensure:")
              " Debiased batch "
              i("Q")
              " "
              cm("stem and correct answer immutable; only distractors change")
            })
            ln({
              i("O")
              " ← "
              i("Q")
              " "
              cm("items still open for refinement")
            })
            ln({
              kw("for")
              " "
              i("r")
              " = 1 "
              kw("to")
              " "
              i("R")
              " "
              kw("do")
            })
            ln(ind: 1, {
              kw("for")
              " "
              i("q")
              " ∈ "
              i("O")
              " "
              kw("do")
              " "
              cm({
                "Blind Solver: video withheld, "
                i("V")
                " = ∅"
              })
            })
            ln(ind: 2, {
              i({
                "C"
                sb("q")
              })
              " ← { "
              i("i")
              " : BlindSolver"
              sb(i("i"))
              "("
              i("q")
              ") selects the correct answer } "
              cm({
                i("N")
                " diversified samples"
              })
            })
            ln(ind: 1, kw("end for"))
            ln(ind: 1, {
              i("H")
              " ← { "
              i("q")
              " ∈ "
              i("O")
              " : "
              i({
                "C"
                sb("q")
              })
              " = ∅ } "
              cm("no sample succeeds ⇒ not vulnerable")
            })
            ln(ind: 1, {
              i("O")
              " ← "
              i("O")
              " \\ "
              i("H")
              " "
              cm("freeze non-vulnerable items")
            })
            ln(ind: 1, {
              kw("if")
              " "
              i("O")
              " = ∅ "
              kw("then")
            })
            ln(ind: 2, {
              kw("break")
              " "
              cm("blind accuracy approaches chance")
            })
            ln(ind: 1, kw("end if"))
            ln(ind: 1, {
              i("P")
              " ← Diagnose({ ("
              i("q")
              ", {reasoning("
              i("i")
              ") : "
              i("i")
              " ∈ "
              i({
                "C"
                sb("q")
              })
              "}) : "
              i("q")
              " ∈ "
              i("O")
              " }) "
              cm("one Refine Plan per vulnerable item")
            })
            ln(ind: 1, {
              kw("for")
              " "
              i("p")
              " ∈ "
              i("P")
              " "
              kw("do")
            })
            ln(ind: 2, {
              i("e")
              " ← Patch("
              i("p")
              ") "
              cm("one plan ⇒ one distractor edit")
            })
            ln(ind: 2, {
              "Apply("
              i("e")
              ", "
              i({
                "q"
                sb("p")
              })
              ") "
              cm("overwrite the named distractor only")
            })
            ln(ind: 1, kw("end for"))
            ln(kw("end for"))
            ln({
              kw("return")
              " "
              i("Q")
            })
          },
        )
        #note[
          Each patch names the Refine Plan it addresses and the distractor it targets.
          Patches that reference an unknown plan or fall outside the plan's target are rejected and regenerated.
        ]
      ],
    ),
  ),
)
