import { mkdir } from "node:fs/promises";
import { basename } from "node:path";
import { $, Glob } from "bun";
import { renderToString } from "preact-render-to-string";
import { mounts } from "../src/mounts";

let html =
    await $`typst compile --features html --format html --root . src/main.typ -`
        .quiet()
        .text();

for (const { id, vnode } of mounts) {
    const v = vnode();
    if (!v) {
        continue;
    }

    const re = new RegExp(`(<div[^>]*\\bid="${id}"[^>]*>)(</div>)`);
    if (!re.test(html)) {
        // skip commented out mount in page.typ
        console.warn(`note: mount div #${id} not in typst output, skipped`);
        continue;
    }
    html = html.replace(re, `$1${renderToString(v)}$2`);
}

await mkdir("docs/static", { recursive: true });
await Bun.write("docs/.nojekyll", "");
await Bun.write("docs/index.html", html);
for await (const f of new Glob("assets/*").scan()) {
    await Bun.write(`docs/static/${basename(f)}`, Bun.file(f));
}
await $`bun build src/client.ts --outfile docs/static/client.js --minify`.quiet();

const base = "src/styles/index.css";
const parts = [];
for await (const f of new Glob("src/**/*.css").scan()) {
    if (f !== base) parts.push(f);
}
parts.sort();
let css = "";
for (const f of [base, ...parts]) {
    css += `/* === ${f} === */\n\n${await Bun.file(f).text()}\n`;
}
await Bun.write("docs/static/index.css", css);

console.log(`Built docs/ (${(await $`du -sh docs`.text()).split("\t")[0]})`);
