# FigCraft comment threads

Shared by `/ps-figcraft:fix`, `/ps-figcraft:code` and `/ps-figcraft:to-pr`. This file is the single source of truth for what a thread's state means.

## Target

Every run starts by resolving the **target**: which open FigCraft file this repo works on. The link lives in `.claude/figcraft.json` at the repo root:

```json
{
  "file": "/Users/me/Documents/FigCraft/project/project-design.figcraft",
  "pages": ["Screens"],
  "frames": { "Login": "src/features/auth/components/login-screen.tsx" }
}
```

1. Read the link. `run_command doc.list` returns the open files with their ids; the link's `file` picks one. Pass that id as `document` on **every** tool call: the default is whichever file is in front, which changes when the owner switches tabs.
2. No link yet: show `doc.list` to the owner with AskUserQuestion, ask once which file (and which pages) belong to this repo, write `.claude/figcraft.json`, and add `.claude/figcraft.json` to the repo's `.gitignore`.
3. The linked file is not open: tell the owner to open it, then stop.
4. `pages` lists page names; an entry ending in `*` is a prefix (`"User |*"`). Empty or missing means every page. A thread whose `pageName` matches no entry is skipped and reported.
5. **Sync check.** The file and the code change between runs, so the link is a claim to verify, not a fact. Before acting, check:
   - every name in `pages` exists in `page.list`;
   - every key in `frames` is a frame in the linked file (`inspect_document` by name) and every value is a path that exists in the repo (`test -e`);
   - the threads' `frameName` values that `frames` does not know are listed as unmapped.

   Any miss is **drift**. Show the owner the drift with AskUserQuestion (rename the mapping, remove it, or skip those threads), update `.claude/figcraft.json` with the answer, and work only the threads whose mapping is sound. No drift: still state the resolved target in one line. `/ps-figcraft:code` always asks the owner to confirm the mapping for each frame it is about to change, since a wrong file means a wrong edit.
6. Open the report with the file name and the pages touched.
7. Create layers with an explicit `parent`; a layer created without one lands on the current page, which is not necessarily the thread's page. Call `page.select` only when no id-based call can do the job.

`frames` maps a frame name to its source file. `/ps-figcraft:code` reads it and adds the mappings it discovers.

## Page layout

A page holds one feature, named `<Scope> | <Feature>` with Scope one of `User`, `Organization`, `Platform` (for example `User | Census entry`, `Platform | Setting`). Desktop screens are 1440 wide and sit left (x 0, y 140); mobile screens are 390 wide and sit right (x 1560, y 140). A source artboard with another width is still placed in a 1440 or 390 frame. The frame name is the label: name each screen after its artboard and add no caption layers. Work that adds a screen goes on the page whose name fits; with no fitting page, ask the owner for the name before creating one. A page's feature is the part after `|`: `/ps-figcraft:code` uses it to narrow the source search.

After any batch that creates or moves layers, run `page.list` and compare the child counts with what the batch should have produced. A layer that landed on the wrong page, or a batch whose result is missing, is fixed or reported before the next thread.

## Reading

FigCraft's MCP server is `figcraft`; its tools are deferred, so load them with ToolSearch `+figcraft` first. Commands run through `run_command`:

- `comment.list {document, page: "all", filter: "open", query: "!fix"}` returns threads with text, anchor node id, frame, page and replies.
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
