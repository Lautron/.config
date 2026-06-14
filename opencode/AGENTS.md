<!-- context7 -->
Use the `context7` MCP tools to fetch current documentation whenever the user asks about a library, framework, SDK, API, CLI tool, or cloud service -- even well-known ones like React, Next.js, Prisma, Express, Tailwind, Django, or Spring Boot. This includes API syntax, configuration, version migration, library-specific debugging, setup instructions, and CLI tool usage. Use even when you think you know the answer -- your training data may not reflect recent changes. Prefer this over web search for library docs.

Do not use for: refactoring, writing scripts from scratch, debugging business logic, code review, or general programming concepts.

## Tools

The `context7` MCP server is configured in `opencode.jsonc` under `mcp.context7` and exposes two tools. In opencode agent permission blocks, tools are referenced with the server name as a prefix:

- `context7_resolve-library-id` -- resolves a library name to a Context7 library ID (format: `/org/project` or `/org/project/version`).
- `context7_query-docs` -- retrieves current documentation for a resolved library ID.

Grant access to all context7 tools with the wildcard permission key:

```jsonc
"permission": {
  "context7_*": "allow"
}
```

## Steps

1. Resolve library: call the `context7_resolve-library-id` tool with the user's full question as the `query` and the library/framework/SDK/API/CLI/cloud-service name as `libraryName` (use the official name with proper punctuation, e.g., "Next.js" not "nextjs", "Customer.io" not "customerio", "Three.js" not "threejs"). Skip this step only if the user already provided an ID in `/org/project` or `/org/project/version` format.
2. Pick the best match from the results by: exact name match, description relevance, code snippet count, source reputation (High/Medium preferred), and benchmark score (higher is better). If results don't look right, try alternate names or queries (e.g., "next.js" not "nextjs", or rephrase the question).
3. Fetch docs: call the `context7_query-docs` tool with the chosen `libraryId` and the user's full question as the `query`. Be specific and detailed -- vague single-word queries return worse results.

## Quota and Auth

The context7 MCP server requires a `CONTEXT7_KEY` env var. If a tool call fails with a quota error, inform the user and suggest `npx ctx7@latest login` (or setting `CONTEXT7_KEY` directly) to obtain an API key. Do not silently fall back to training data.

## Limits

Do not call these tools more than 3 times per question. Do not include sensitive information (API keys, passwords, credentials) in queries.
<!-- context7 -->
