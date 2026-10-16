- Everywhere — chat, docs, plans, commits, skills, rules — write compact and readable: every sentence carries a fact, no filler, no restating, no hedging.
- NEVER write a markdown table — not in notes, chat or commits. A row is `- key — rest`; a row with several clauses is a `key` heading with a bullet per clause; two things compared are two labelled lists.

## Writing markdown

Write the minimum that carries the meaning.

- Heading, then content. No preamble, transitions or closing summary.
- One idea per line. Cut adjectives that carry no fact.
- Never describe what an image or code block already shows.
- Quote real artifacts verbatim — screen titles, labels, error text.
- No bold: no `**Label.**` lead-ins, no emphasis. Structure comes from headings and lists.
- A label with an explanation is a `Label` heading and a `- ` bullet, not `- Label — explanation`. Short unlabelled items stay a plain list.
- A heading is one level below its parent — `###` under `##`. With no heading above, a label starts at `####`.
- Three or more parallel facts in a sentence → a `> Lead-in:` blockquote, colon kept, then a list. A colon before a single fact stays inline.
- A chain `A → B → C` is a list, one step per line, each keeping its trailing `→`.
- A side remark — consequence, bet, caveat — goes in a `>` blockquote that never ends in a colon.
