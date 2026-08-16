from pathlib import Path

path = Path("_movedesc.txt")
text = path.read_text(encoding="utf-8")

def halfwidth_digit_to_fullwidth(s: str) -> str:
    table = str.maketrans("0123456789?-", "０１２３４５６７８９？－")
    return s.translate(table)

def normalize_description(key: str, desc_lines: list[str]) -> str:
    # 先把半角数字转全角数字
    desc_lines = [halfwidth_digit_to_fullwidth(line) for line in desc_lines]

    if len(desc_lines) > 2:
        raise ValueError(f"{key} 描述超过 2 行: {desc_lines}")

    # 如果只有一行，补第二行空字符串
    if len(desc_lines) == 1:
        desc_lines.append("")

    # 如果没有描述，也补两行
    if len(desc_lines) == 0:
        desc_lines = ["", ""]

    normalized_lines = []

    for line_no, line in enumerate(desc_lines, start=1):
        char_count = len(line)

        if char_count > 12:
            raise ValueError(
                f"{key} 第 {line_no} 行超过 12 个字符：{char_count} 个字符 -> {line}"
            )

        line = line + "〇" * (12 - char_count)
        normalized_lines.append(line)

    return "\n".join(normalized_lines)


items = []

for block in text.split("\n\n"):
    block = block.strip()
    if not block:
        continue

    lines = [line.strip() for line in block.splitlines() if line.strip()]
    if not lines:
        continue

    label_line = lines[0]

    if not label_line.endswith("Desc:") and not label_line.endswith("Description:"):
        raise ValueError(f"标签格式不正确: {label_line}")

    key = label_line
    desc_lines = lines[1:]

    description = normalize_description(key, desc_lines)

    items.append({
        "key": key,
        "description": description
    })

for item in items:
    lines = item["description"].split("\n")
    print(item["key"])
    print("\tdb_w \"" + lines[0] +"\"")
    print("\tnext \"" + lines[1] +"@\"")
    print()