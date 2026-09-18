- NEVER write a markdown table — not in a note, not in chat, not in a commit message. They are unreadable in a plain editor and wrap to mush in a terminal. A row is a list line: `- key — the rest of the row`. A row needing more than one clause becomes `#### key` with a bullet per clause. Two things compared side by side are two labelled lists, not two columns. A table whose top-left header cell is empty is the worst shape of all — that is a list someone turned sideways.

## Writing markdown

Write the minimum that carries the meaning.

- Heading, then content. No preamble, no transition sentences, no closing summary that repeats the body.
- One idea per line. Cut every adjective that carries no fact.
- Never describe what an image or code block already shows.
- Quote real artifacts verbatim — screen titles, labels, error text. Don't paraphrase them.

Structure comes from headings and lists, never from bold.

- No `**Label.** text` lead-ins and no inline bold for emphasis. If a sentence needs bold to land, rewrite the sentence.
- A label with an explanation is `#### Label` followed by a `- ` bullet holding the explanation — not `- Label — explanation` on one line. Plain lists stay plain when the items are short and unlabelled.
- A sentence packing three or more parallel facts becomes `##### Lead-in:` (colon kept) followed by a list, one fact per line. A colon that just means "namely" before a single fact stays inline.
- A chain of steps (`A → B → C`) is a list, one step per line, each line keeping its trailing `→`. Never run it inside a sentence.

A side remark — a consequence, a bet, a caveat that is not the claim itself — goes in a `>` blockquote instead of its own paragraph.
