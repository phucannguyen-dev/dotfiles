# Obsidian SR Flashcard Template

Copy-paste starter:

```markdown
# Tên bài #flashcard/DeckName

Câu hỏi đơn giản? :: Trả lời đơn giản

Câu hỏi thứ 2 ::: Thông tin ngược chiều (tạo 2 thẻ)

Câu hỏi nhiều dòng
có thể xuống dòng
?
Trả lời nhiều dòng
cũng xuống dòng được

Thông tin A
Thông tin B
??
Thông tin 1
Thông tin 2

==Cloze đơn== (mỗi ==...== = 1 thẻ sibling)

==Cloze có hint==^[gợi ý]

==Cloze số==[^1]. ==Cloze số 2==[^2]. ==Cloze số 1 lại==[^1]
```

Key syntax cheat-sheet:

| Syntax | Effect |
|--------|--------|
| `Q :: A` | Single-line basic card |
| `X ::: Y` | Bidirectional (2 cards: X→Y, Y→X) |
| `Q\n?\nA` | Multi-line basic card |
| `A1\nA2\n??\nB1\nB2` | Multi-line bidirectional |
| `==text==` | Simplified cloze (1 card per `==...==`) |
| `==text==^[hint]` | Cloze with hint |
| `==text==[^N]` | Numbered cloze (same N = 1 card) |
| `<!-- :: ... -->` | Ignore card (HTML comment) |