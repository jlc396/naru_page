// paper sec. IV-D
#import "../results-table.typ": table-tab

#table-tab(
  [
    #html.elem("p", attrs: (class: "tab-desc"))[
      This table shows the complementary open-ended evaluation on the same 500-question subset: all answer choices are removed, models generate answers directly, and an automated judge scores each response by atomic-fact recall — the fraction of reference facts it covers.
      Removing the choices preserves the performance hierarchy, with the Gemini family maintaining a substantial advantage (66–78% recall versus 21–56% for open-source models), but the capability profile shifts distinctly.
      Most strikingly, Sequential/Topical Flow (N.2) — the strongest narrative subcategory under multiple choice — degrades into the weakest narrative category for seven of the eight models, plausibly because multiple-choice options serve as structural scaffolds for temporal organization.
    ]
  ],
  json("../data/results_RQ3.json"),
  digits: 0,
  avgs: false,
  scale: 100,
)
