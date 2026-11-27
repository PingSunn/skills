# FigCraft comment threads

Shared by `/ps-figcraft:fix`, `/ps-figcraft:code` and `/ps-figcraft:to-pr`. This file is the single source of truth for what a thread's state means.

## Reading

FigCraft's MCP server is `figcraft`; its tools are deferred, so load them with ToolSearch `+figcraft` first. Commands run through `run_command`:

- `comment.list {page: "all", filter: "open", query: "!fix"}` returns threads with text, anchor node id, frame, page and replies.
- `comment.reply {id, text, author: "Claude"}` replies. Always pass `author: "Claude"`: the author name is how a thread's state is read.
- `comment.resolve` belongs to the owner. Leave threads open.

If the figcraft tools are missing or `comment.list` fails, FigCraft is not attached. Tell the owner to start it with `--control 41871` (read root the project, write root `~/Documents/FigCraft/<project>-preview`) and to run `/mcp`, then stop.

## Thread states

A **tracked thread** has a first message starting with `!fix`. Read the state from the last message:

| Last message | State | Next |
| --- | --- | --- |
| a human wrote it | **todo** | `/ps-figcraft:fix` works it |
| Claude asked about blast radius | **waiting** | the owner's reply "ok" turns it into **todo**; any other human reply is new instructions |
| Claude: `Fixed: ...` | **fixed** | `/ps-figcraft:code` works it |
| Claude: `Code: <branch>@<sha>` | **coded** | `/ps-figcraft:to-pr` works it |
| Claude: `PR: <url>` | **shipped** | nothing |

Prefix every Claude reply with its state word (`Fixed:`, `Ask:`, `Code:`, `PR:`) so the table can be read back.
