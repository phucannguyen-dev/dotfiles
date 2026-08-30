---
name: flashcard-md
description: "Tạo flashcards Markdown từ tài liệu học tập (Markdown, PDF, TXT) - định dạng Obsidian Spaced Repetition"
platforms: [linux, macos, windows]
---

# Flashcard Markdown Generator (Obsidian Spaced Repetition)

## Khi nào sử dụng

Dùng khi tạo flashcards cho Obsidian sử dụng plugin **Obsidian Spaced Repetition** (by Stephen Mwangi).

## Định dạng Obsidian SR

### Gán Deck

Thẻ được gán deck qua tag hoặc cấu trúc thư mục:
- Tag: `#flashcard` hoặc `#flashcard/DeckName`
- Frontmatter: `tags: [flashcard]` (tùy chọn)

### Q&A Cards (Câu hỏi & Trả lời)

#### Single-line Basic (1 dòng, 1 thẻ)
```
Câu hỏi :: Trả lời
```

#### Single-line Bidirectional (1 dòng, 2 thẻ ngược chiều)
```
Thông tin 1 ::: Thông tin 2
```

#### Multi-line Basic (nhiều dòng, 1 thẻ)
```
Câu hỏi
có thể nhiều dòng
?
Trả lời
cũng nhiều dòng
```

#### Multi-line Bidirectional (nhiều dòng, 2 thẻ ngược chiều)
```
Thông tin 1A
Thông tin 1B
Thông tin 1C
??
Thông tin 2A
Thông tin 2B
```

### Cloze Cards (Điền từ)

#### Simplified Cloze (mặc định)
```
Câu văn có ==từ cần ẩn==
```
- Mỗi `==...==` tạo 1 thẻ riêng (sibling cards)
- Có thể thêm hint: `==từ==^[gợi ý]`

#### Classic/Numbered Cloze
```
==cloze 1==[^1]. ==cloze 2==[^2]. ==cloze 1 lại==[^1]
```
- Số trong `[^N]` gom nhóm cloze cùng số thành 1 thẻ
- Có thể thêm hint: `==cloze==^[gợi ý][^1]`

#### Generalized Cloze Overlapping
```
==context==[^hshs]
- ==Item 1==[^ashh]
- ==Item 2==[^hash]
```
- Ký tự hành động: `a`=ask, `h`=hide, `s`=show

### Sibling Cards
- Nhiều thẻ từ 1 flashcard (Bidirectional, Multi-cloze) = sibling cards
- Tùy chọn "Bury sibling cards until next day" chỉ review 1 sibling/ngày

### Ignore Cards
Wrap trong HTML comment để bỏ qua:
```
<!-- Câu hỏi :: Trả lời <!--SR:2025-01-01,10,250--> -->
```

## Quy tắc viết

1. **Một khái niệm/thẻ**: Ngắn gọn, rõ ràng
2. **Giữ nguyên LaTeX**: Không chuyển đổi công thức toán/lý/hóa. Trong file: `\\\` là backslash đơn — Obsidian KaTeX render `\\\\` thành literal double-backslash. Khi đụng `\\\` dùng `write_file` thay vì `patch` (xem pitfalls).
3. **LaTeX tuân thủ chuẩn**: Không Unicode (ω, √, π). Không whitespace giữa ký hiệu.
   - Đúng: `\\\frac{2\\\pi}{T}`
   - Sai: `\\\frac{2\pi}{T}`
   - Sai: `$\omega = \sqrt{g/l}$`
4. **Đặt tên file**: `Tên bài - Flashcards.md` (loại bỏ dấu `_`, thay bằng khoảng trắng)
5. **Tag deck**: Thêm `#flashcard/DeckName` đầu file hoặc frontmatter (tag có thể nằm sau frontmatter, scan trong 5 dòng đầu — không chỉ line 1)
6. **Tách thẻ bằng dòng trống** giữa các flashcard

## Quy trình tạo

1. Phân tích tài liệu → Trích xuất định nghĩa/công thức/ví dụ
2. Chọn loại thẻ phù hợp (Q&A basic, bidirectional, cloze)
3. Viết theo cú pháp Obsidian SR
4. Thêm tag deck
5. Ghi file `.md`

## Pitfalls

- **`patch` tool escapes LaTeX backslashes**: Khi `old_string` chứa `\\` (single LaTeX backslash), `patch` match literal-text lưu double-escape trong file kết quả. Repro: regex `\\sin` → file mới có `\\\\sin`. Fix: với LaTeX-heavy edits, dùng `write_file` (full rewrite) hoặc escape thêm 1 lần `\\\\` trong cả `old_string` và `new_string`. Validate sau khi patch: `grep -c '\\\\' file.md` (4 backslashes = 2 escaped = corruption).
- **Frontmatter pushes tag off line 1**: `#flashcard/X` có thể nằm line 3-5 nếu file có frontmatter. Validator check line đầu sẽ miss. Scan 5 dòng đầu thay vì 1.
- **Non-SR formats encountered in vaults**: Một số vault dùng custom format không tương thích — phải reformat thay vì patch. Pattern phổ biến:
  - `---card--- ^lemma-XXX` / `---` separators / `> [!note]` callouts (Anki-style)
  - `tags: flashcards` (plural) — đổi thành `#flashcard/Deck`
  - H1 `# X #flashcards` không có deck name — thêm `/Deck` suffix
- **Duplicate files** (root + subfolder): Vault có thể có cùng bài ở `Lectures/Foo.md` và `Lectures/Toán/Foo - Flashcard.md`. Xác định canonical trước khi xóa/sửa.

## Reformat recipe (non-SR → SR)

Khi vault có flashcard custom-format cần convert sang Obsidian SR:

1. List all files, identify which use SR (have `::` / `:::` / `==`) vs custom (`---card---`, `^lemma`).
2. Programmatic reformat bằng `execute_code` Python:
   - Strip frontmatter: nếu file bắt đầu bằng `---`, lấy phần sau `---` thứ 2.
   - Parse card blocks: split on `---card--- ^<id>`, mỗi block split on `\n---\n` thành Q/A.
   - Strip trailing callout: drop everything từ `\n> [!note]` trở đi.
   - Emit: `# Title #flashcard/Deck` header + `Q :: A` lines (multiline Q/A dùng `?` separator).
3. Validate output: không còn `---card---` / `^lemma` / `> [!note]`, có `#flashcard` trong 5 dòng đầu, không có `\\\\` corruption.
4. Cross-check vs lecture để fill gaps: compare lecture headings vs card count, đọc lecture, bổ sung thẻ cho khái niệm thiếu.

See `references/reformat-script.md` cho full Python script.

## Vietnamese content

Nếu vault dùng tiếng Việt (phổ biến ở lecture notes Việt Nam):
- Deck name dùng tiếng Anh để dễ nhóm: `Maths`, `Physics`, `Chemistry` (không dùng `Toán`/`Vật lý`/`Hóa học` trong tag vì SR plugin có thể xử lý slug khác nhau).
- Q/A giữ nguyên tiếng Việt + LaTeX cho công thức.
- Tên file giữ nguyên có dấu (Obsidian hỗ trợ).

## Ví dụ hoàn chỉnh

```markdown
# Dao động điều hòa #flashcard/physics

Chu kỳ dao động điều hòa là gì? :: Là khoảng thời gian ngắn nhất để vật lặp lại trạng thái dao động

Công thức tính ω :: ω = \frac{2\pi}{T}

Tần số f và chu kỳ T ::: f = \frac{1}{T}

==Dao động điều hòa== là dao động mà li độ tuân theo hàm ==sin== hoặc ==cos==

Công thức năng lượng: E = \frac{1}{2} m \omega^2 A^2 [^1]
Trong đó: m = khối lượng[^1], ω = tần số góc[^1], A = biên độ[^1]
```