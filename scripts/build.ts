import { mkdir } from "node:fs/promises";
import { basename } from "node:path";
import { $, Glob } from "bun";

const html =
    await $`typst compile --features html --format html --root . src/main.typ -`
        .quiet()
        .text();

await mkdir("docs/static", { recursive: true });

await Bun.write("docs/.nojekyll", "");
await Bun.write("docs/index.html", html);
for await (const pdf of new Glob("assets/*.pdf").scan()) {
    if (basename(pdf) === "paper.pdf") continue;
    await $`pdftocairo -svg ${pdf} docs/static/${basename(pdf, ".pdf")}.svg`.quiet();
}
await $`bun build src/client.ts --outfile docs/static/client.js --minify`.quiet();
await Bun.write("docs/static/index.css", Bun.file("src/styles/index.css"));

console.log(`Built docs/ (${(await $`du -sh docs`.text()).split("\t")[0]})`);
