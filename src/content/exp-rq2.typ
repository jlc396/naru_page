// paper sec. IV-C
#import "../lib.typ": div, img

#div("two-cols top")[
  #div(none)[
    #img(
      "static/rq2_frames_scaling.svg",
      cls: "plot-image",
      alt: "Accuracy vs. number of sampled frames.",
    )
  ]
  #div(none)[
    #img(
      "static/rq2_frames_gain.svg",
      cls: "plot-image",
      alt: "Per-dimension gain from denser frame sampling.",
    )
  ]
]
#html.elem("p", attrs: (class: "tab-desc"))[
  The left plot traces overall multiple-choice accuracy on a fixed 500-question subset as the number of sampled frames grows from 8 to 128, and the right plot shows each model's resulting accuracy gain on the narrative versus cultural dimensions.
  The three Gemini models improve substantially with larger frame budgets (e.g., Gemini-3-Pro from about 64% to 71%), whereas the open-weight models improve less consistently, most remaining close to 30% even at 128 frames.
  For every model, narrative gains consistently outpace cultural gains, indicating that narrative errors are largely caused by missing dispersed events that denser sampling directly resolves, while cultural interpretation depends less on visual frequency and more on underlying pragmatic reasoning and domain knowledge.
]
