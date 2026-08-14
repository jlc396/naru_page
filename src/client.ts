import type { VNode } from "preact";
import { hydrate } from "preact";
import { mounts } from "./mounts";

function hydrateWhenVisible(el: HTMLElement, make: () => VNode) {
    const io = new IntersectionObserver(
        (entries) => {
            if (entries.some((e) => e.isIntersecting)) {
                io.disconnect();
                hydrate(make(), el);
            }
        },
        { rootMargin: "200px" },
    );
    io.observe(el);
}

for (const btn of document.querySelectorAll<HTMLButtonElement>(
    "table.results button.expand[data-group]",
)) {
    btn.addEventListener("click", () => {
        const table = btn.closest("table");
        const th = btn.closest("th");
        if (!table || !th || !btn.dataset.group) {
            return;
        }

        const shown = table.classList.toggle(`show-${btn.dataset.group}`);
        // keep the group's colspan in sync with its visible columns
        th.colSpan = shown ? Number(th.dataset.span) : 1;
        btn.setAttribute("aria-expanded", String(shown));
    });
}

for (const bar of document.querySelectorAll<HTMLElement>("[role='tablist']")) {
    bar.addEventListener("click", (evt) => {
        const btn = (evt.target as HTMLElement).closest<HTMLButtonElement>(
            "button[data-tab]",
        );
        if (!btn || btn.classList.contains("is-active")) return;
        for (const b of bar.querySelectorAll("button[data-tab]")) {
            b.classList.toggle("is-active", b === btn);
            b.setAttribute("aria-selected", String(b === btn));
        }

        const scope = bar.parentElement ?? document.body;
        for (const p of scope.querySelectorAll<HTMLElement>(
            ".tab-panel[data-panel]",
        )) {
            p.classList.toggle(
                "is-active",
                p.dataset.panel === btn.dataset.tab,
            );
        }
    });
}

for (const table of document.querySelectorAll<HTMLTableElement>(
    "table.results",
)) {
    let lit: HTMLTableCellElement[] = [];
    const clear = () => {
        for (const c of lit) {
            c.classList.remove("col-hover");
        }
        lit = [];
    };
    table.addEventListener("mouseover", (evt) => {
        const cell = (evt.target as HTMLElement).closest("td");

        if (!cell || !table.contains(cell)) {
            return;
        }
        clear();

        for (const row of table.tBodies[0].rows) {
            const c = row.cells[cell.cellIndex];
            if (c) {
                c.classList.add("col-hover");
                lit.push(c);
            }
        }
    });
    table.addEventListener("mouseleave", clear);
}

for (const { id, eager, vnode } of mounts) {
    const el = document.getElementById(id);

    if (!el) {
        continue;
    }

    if (eager) {
        const v = vnode();
        if (v) hydrate(v, el);
    } else {
        hydrateWhenVisible(el, () => vnode()!);
    }
}
