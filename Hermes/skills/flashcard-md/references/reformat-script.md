# Non-SR → SR Reformat Script

Python snippet used in session (adapt paths as needed).

```python
import os, re, glob

BASE = "/path/to/Lectures"  # change
DECK_MAP = {"Toán": "Maths", "Vật lý": "Physics", "Hóa học": "Chemistry"}

def strip_frontmatter(txt):
    if txt.startswith("---"):
        end = txt.find("\n---", 3)
        if end != -1:
            return txt[end+4:].lstrip("\n")
    return txt

def parse_cards(txt):
    blocks = re.split(r'---card---\s*\^[\w-]+', txt)
    cards = []
    for b in blocks[1:]:
        parts = b.split("\n---\n", 1)
        if len(parts) != 2:
            continue
        q = parts[0].strip()
        a = re.sub(r'\n> \[!note\].*$', '', parts[1], flags=re.S).strip()
        if q and a:
            cards.append((q, a))
    return cards

def to_sr(cards, title, deck):
    out = [f"# {title} #flashcard/{deck}", ""]
    for q, a in cards:
        if len(a.split("\n")) == 1:
            out.append(f"{q} :: {a}")
        else:
            out.append(q); out.append("?"); out.append(a)
        out.append("")
    return "\n".join(out).rstrip() + "\n"

for sub, deck in DECK_MAP.items():
    d = os.path.join(BASE, sub)
    if not os.path.isdir(d): continue
    for fp in sorted(glob.glob(os.path.join(d, "*Flashcard*.md"))):
        txt = open(fp, encoding="utf-8").read()
        if "---card---" not in txt and "::" in txt:  # already SR
            continue
        body = strip_frontmatter(txt)
        title = re.search(r'^#\s+(.+)$', body, re.M)
        title = title.group(1).replace("#flashcards","").replace("#flashcard","").strip() if title else os.path.basename(fp)
        cards = parse_cards(body)
        if not cards: continue
        sr = to_sr(cards, title, deck)
        open(fp, "w", encoding="utf-8").write(sr)
        print(f"Converted {fp}: {len(cards)} cards")

# Validate
# grep -r '\\\\\\\\' Lectures/  # any 4-backslash = corruption
# grep -rL '#flashcard' Lectures/*/*Flashcard*.md  # missing tag
```

Usage: drop in `execute_code` tool, adjust `BASE`, run. Outputs card counts per file.