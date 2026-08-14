const server = Bun.serve({
    port: Number(Bun.env.PORT ?? 8080),
    async fetch(req) {
        let path = decodeURIComponent(new URL(req.url).pathname);
        if (path.includes("..")) {
            return new Response("Forbidden", { status: 403 });
        }
        if (path.endsWith("/")) {
            path += "index.html";
        }
        const file = Bun.file(`docs${path}`);
        if (!(await file.exists())) {
            return new Response("Not found", { status: 404 });
        }
        return new Response(file, { headers: { "Cache-Control": "no-store" } });
    },
});

console.log(`Preview at ${server.url} (caching disabled)`);
