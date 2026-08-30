---
name: flashcard-csv
description: "Tạo flashcards CSV từ tài liệu học tập (Markdown, PDF, TXT)"
platforms: [linux, macos, windows]
---

# Flashcard Generator (CSV & Obsidian SR)

## Khi nào sử dụng

Dùng khi người dùng yêu cầu tạo flashcards từ tài liệu học tập, ghi chú, hoặc bất kỳ nội dung giáo dục nào. Hỗ trợ hai định dạng: **CSV (cho Anki)** và **Markdown (cho Obsidian Spaced Repetition)**.

## Định dạng xuất

### 1. Định dạng CSV (Anki)
Cấu trúc cột: `Front;Back;Notes`
... (giữ nguyên các quy tắc CSV hiện tại) ...

### 2. Định dạng Markdown (Obsidian Spaced Repetition)
Sử dụng định dạng inline trong file `.md`. Yêu cầu thêm tag deck (ví dụ: `#flashcards/DeckName`) vào file.

**Các loại thẻ:**
- **Single-line Basic**: `Câu hỏi :: Câu trả lời`
- **Single-line Bidirectional**: `Câu hỏi | Câu trả lời`
- **Multi-line Basic**: 
  ```
  Câu hỏi
  ?
  Câu trả lời
  ```
- **Cloze**: `Câu văn có {{c1::phần bị ẩn}}`

**Quy tắc:**
- Mỗi thẻ nằm trên một dòng (đối với single-line).
- Phân cách rõ ràng giữa Front và Back.
- Giữ nguyên LaTeX.

### Đặt tên file

Tên file flashcard CSV format: `Tên gốc - Flashcards.csv` (thêm " - Flashcards" trước extension). **Loại bỏ tất cả dấu gạch dưới** và giữ khoảng trắng:
- `Dao_động_điều_hòa.md` → `Dao động điều hòa - Flashcards.csv`
- `Cân_bằng_hóa_học.md` → `Cân bằng hóa học - Flashcards.csv`
- `Lecture_Notes.pdf` → `Lecture Notes - Flashcards.csv`
- `Con_lắc_đơn.md` → `Con lắc đơn - Flashcards.csv`
- `Xin chào.md` → `Xin chào - Flashcards.csv`

**Quy trình xử lý tên file:**
1. Lấy tên file nguồn gốc.
2. Loại bỏ extension.
3. Thay thế `_` bằng khoảng trắng.
4. Thêm hậu tố:
   - CSV: ` - Flashcards.csv`
   - Markdown: ` - Flashcards.md` (nếu tạo file mới)
5. Lưu vào thư mục yêu cầu.

**Lưu ý:** File nguồn có thể có tên bị encode với ký tự đặc biệt (ví dụ: `Dao_đo__ng_đie__u_ho_a_54E4052A.md` trong cache). Luôn ưu tiên dùng tên file gốc từ metadata hoặc tên người dùng cung cấp, không dùng tên file tạm trong cache.

## Nguyên tắc quan trọng

**Flashcards CHỈ tập trung vào lý thuyết:**
- Định nghĩa, khái niệm
- Công thức, định lý
- Phân loại, so sánh
- Tính chất, đặc điểm
- Quy trình, phương pháp

**KHÔNG tạo thẻ cho:**
- ❌ Bài tập số cụ thể
- ❌ Đề bài toán có số liệu
- ❌ Ví dụ tính toán chi tiết
- ❌ Câu hỏi yêu cầu "giải" hoặc "tính"

## Chiến lược tạo thẻ

### Các loại thẻ hiệu quả

1. **Định nghĩa**: Khái niệm là gì?
   ```
   Front: Dao động điều hòa là gì?
   Back: Dao động tuần hoàn mà li độ tuân theo hàm sin hoặc cosin
   Notes: Khái niệm cơ bản
   ```

2. **Công thức**: Viết công thức X?
   ```
   Front: Công thức chu kì con lắc đơn?
   Back: T = 2π√(l/g)
   Notes: Đơn vị: s
   ```

3. **So sánh**: X khác Y như thế nào?
   ```
   Front: Acid mạnh khác acid yếu như thế nào?
   Back: Acid mạnh phân li hoàn toàn (α = 1), acid yếu phân li không hoàn toàn (0 < α < 1)
   Notes: Phân loại chất điện li
   ```

4. **Ví dụ**: Ví dụ về X?
   ```
   Front: Ví dụ về base tan?
   Back: LiOH, KOH, NaOH, Ba(OH)₂, Ca(OH)₂
   Notes: Chất điện li mạnh
   ```

5. **Quy trình**: Các bước làm X?
   ```
   Front: Các bước viết phương trình ion thu gọn?
   Back: 1) Viết PT phân tử; 2) Phân li chất điện li mạnh; 3) Giữ nguyên chất yếu; 4) Rút gọn ion giống nhau
   Notes: 4 bước
   ```

### Tránh những lỗi này

❌ **Quá dài**: Front hoặc Back có nhiều đoạn văn
❌ **Không rõ ràng**: "Điều gì quan trọng về X?" → Quá mơ hồ
❌ **Nhiều khái niệm**: Một thẻ hỏi về 3-4 công thức khác nhau
❌ **Thiếu ngữ cảnh**: Notes để trống khi cần phân loại
❌ **Chuyển đổi LaTeX**: `$\sin 2a$` thành "sin 2a" → SAI

✅ **Đúng**: Mỗi thẻ = 1 ý, ngắn gọn, rõ ràng, giữ nguyên LaTeX

## Quy trình tạo flashcard

1. **Đọc và phân tích**: Đọc toàn bộ tài liệu để hiểu cấu trúc
2. **Xác định khái niệm chính**: Định nghĩa, công thức, ví dụ, quy trình
3. **Tạo thẻ**: Viết Front/Back/Notes ngắn gọn
4. **Tạo biến thể**: Với công thức quan trọng, tạo 2 hướng (Front: "sin 2a = ?" và "2 sin a cos a là công thức gì?")
5. **Kiểm tra**: Đảm bảo mỗi thẻ độc lập, không cần thẻ khác để hiểu
6. **Ghi file**: Dùng `write_file` với tên file theo quy tắc

## Ví dụ hoàn chỉnh

### Input: Văn bản về con lắc đơn

```markdown
## Chu kì con lắc đơn
Chu kì T của con lắc đơn: T = 2π√(l/g)
Trong đó:
- l: chiều dài dây treo (m)
- g: gia tốc trọng trường (m/s²)
```

### Output: CSV

```csv
Front;Back;Notes
Công thức chu kì con lắc đơn?;T = 2π√(l/g);Đơn vị: s
Chu kì con lắc đơn phụ thuộc vào đại lượng nào?;Chiều dài dây treo l và gia tốc trọng trường g;Không phụ thuộc khối lượng
l trong công thức con lắc đơn là gì?;Chiều dài dây treo (đơn vị: m);Đại lượng
g trong công thức con lắc đơn là gì?;Gia tốc trọng trường (đơn vị: m/s²);Đại lượng
```

## Xử lý các trường hợp đặc biệt

### Công thức toán/lý/hóa
- **TUYỆT ĐỐI giữ nguyên mọi ký hiệu LaTeX**, không chuyển đổi dưới bất kỳ hình thức nào
- **BỎ TẤT CẢ DẤU CÁCH TỒN TẠI TRONG CÔNG THỨC LATEX** (khoảng trắng, tab, newline trong công thức)
- Không Unicode (ω, √, π). Không whitespace giữa ký hiệu.
   - Đúng: `\\\frac{2\\\pi}{T}`
   - Sai: `\\\frac{2\pi}{T}`
   - Sai: `$\omega = \sqrt{g/l}$`
- Ví dụ: `\\\sin 2a = 2\\\sin a \\\cos a` → `$\\\sin2a=2\\\sin a\\\cos a$`
- Ví dụ: `$T = 2\\\pi\\\sqrt{\\\frac{l}{g}}$` → `$T=2\\\pi\\\sqrt{\\\frac{l}{g}}$`
- **KHÔNG** chuyển sang Unicode (ω, √, π)
- **KHÔNG** bỏ dấu `$` hoặc `\\\`
- **KHÔNG** đơn giản hóa công thức

### Bảng biểu
- Tách mỗi hàng thành 1 thẻ riêng
- Hoặc tạo thẻ tổng hợp nếu bảng ngắn

### Danh sách dài
- Chia thành nhiều thẻ nhỏ hơn
- Hoặc nhóm theo category trong Notes

### Ngôn ngữ
- Phát hiện ngôn ngữ từ source (Tiếng Việt, English, 中文, etc.)
- Viết flashcard bằng cùng ngôn ngữ với source

## Lưu ý quan trọng

- **Luôn đọc toàn bộ tài liệu trước** khi tạo thẻ
- **Không bỏ sót khái niệm quan trọng**: Định nghĩa, công thức chính, ví dụ điển hình
- **Tối ưu cho spaced repetition**: Mỗi thẻ phải có thể ôn tập độc lập
- **Kiểm tra định dạng**: Đảm bảo không có dấu `;` trong nội dung (nếu có, dùng dấu khác hoặc escape)
- **Xác nhận với người dùng**: Sau khi tạo, báo số lượng thẻ và nội dung tóm tắt

## Checklist trước khi hoàn thành

- [ ] Đã đọc toàn bộ source?
- [ ] Mỗi thẻ ngắn gọn, rõ ràng, 1 khái niệm?
- [ ] Giữ nguyên LaTeX và ký hiệu đặc biệt?
- [ ] Tên file đúng quy tắc (tên gốc không có `_`, có khoảng trắng, thêm " - Flashcards", extension `.csv`)?
- [ ] Có dòng header `Front;Back;Notes`?
- [ ] Phân cách bằng dấu chấm phẩy?
- [ ] Ô chứa ký tự đặc biệt đã escape đúng (dấu nháy kép, xuống dòng, dấu chấm phẩy)?
- [ ] Báo cáo số lượng thẻ cho người dùng?

