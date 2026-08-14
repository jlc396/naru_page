// paper sec. IV-B
#import "../results-table.typ": table-tab

#table-tab(
  [
    #html.elem("p", attrs: (class: "tab-desc"))[
      The table reports multiple-choice accuracy across the full benchmark for eight model configurations, broken down into four narrative (N.1–N.4) and five cultural (C.1–C.5) categories with their macro-averages.
      Performance follows a distinct tiering: proprietary models lead significantly, with Gemini-3-Flash highest at 76.2% overall, while open-source models fall into a lower 29.6–39.8% regime.
      Category-level results reveal a capability-dependent split: the Gemini models achieve approximately 11 percentage points higher accuracy on narrative tasks than on cultural ones, whereas open-source models show virtually no difference between the two dimensions.
    ]
  ],
  json("../../assets/results_RQ1.json"),
)
