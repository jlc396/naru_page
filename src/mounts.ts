import type { JSX } from "preact";
import type { ResearchLink } from "./components/Navbar";
import { h } from "preact";
import Navbar from "./components/Navbar";
import data from "./site.yaml";

const navbar = (
    data as { navbar?: { homeHref?: string; research?: ResearchLink[] } }
).navbar;

export interface Mount {
    id: string;
    eager?: boolean;
    vnode: () => JSX.Element | null;
}

export const mounts: Mount[] = [
    {
        id: "navbar-root",
        eager: true,
        vnode: () =>
            navbar && (navbar.homeHref || navbar.research?.length)
                ? h(Navbar, {
                      homeHref: navbar.homeHref,
                      research: navbar.research,
                  })
                : null,
    },
];
