---
name: jq-json-inspection
description: Use before reading, searching, or inspecting any JSON file, including configs, schemas, OpenAPI documents, fixtures, and generated output. Read JSON only with shell jq and explore its structure depth-first using object keys and the first element of each array.
---

# Inspect JSON with jq

Use the shell's `jq` executable for every read of a JSON file, even when only one field is needed. Pass the file path directly to `jq`. Do not open, preview, search, or dump the file with editor tools, `Get-Content`, `cat`, `rg`, another parser, or an unfiltered `jq` command. If shell execution or `jq` is unavailable, stop and report the blocker instead of falling back to another reader. If `jq` reports a parse error, report it without opening the raw file.

## Explore Depth-First

1. Check the root type with `jq 'type' -- './path/to/file.json'` if it is unknown.
2. At an object, run `keys` on that node to discover its fields. Pick a relevant key, descend into it, and finish inspecting that branch before returning to a sibling. When the node type is unknown, query `type` before choosing the next step.
3. At an array, inspect only index `0`, and apply the same rule at every nested array. Use `limit(1; .[])` on a node already known to be an array: it emits nothing for an empty array and distinguishes an empty array from one whose first element is `null`. Never emit the whole array or use later elements to infer the schema.
4. Stop at a scalar's type unless the task needs its exact value. Do not print whole objects or subtrees, including the first element of an array if it is an object or another array. Treat the first element as a sample, not proof that later elements have the same shape.

## Example Queries

For a root object containing an `items` array:

```sh
jq 'keys' -- './path/to/file.json'
jq --arg key 'items' 'getpath([$key]) | type' -- './path/to/file.json'
jq --arg key 'items' 'getpath([$key]) | limit(1; .[]) | type' -- './path/to/file.json'
jq --arg key 'items' 'getpath([$key]) | limit(1; .[]) | keys' -- './path/to/file.json'
```

Run the last command only after confirming that the first element is an object. Descend further by extending the path, for example `getpath([$key, 0, $field])` with `--arg field 'name'` to inspect `name` on the first item. Pass dynamic key names via `--arg` rather than interpolating them into the filter. The list returned by `keys` is a list of field names, not an input array; keep it intact to discover sibling branches.
