#!/usr/bin/env python3
import os, sys, json
from io import StringIO

# ================= CONFIG =================

# Path to file storing the number of lines to skip when rendering
SKIP_FILE = os.path.expanduser("~/bin/fetch/SkipLines.txt")

def get_skip_lines_base():
    """
    Determine the base number of lines to skip before rendering.
    Priority:
    1. Environment variable ASGIF_SKIPLINES
    2. SKIP_FILE contents
    3. Default to 0
    """
    if "ASGIF_SKIPLINES" in os.environ:
        try:
            return int(os.environ["ASGIF_SKIPLINES"])
        except ValueError:
            return 0

    try:
        with open(SKIP_FILE, "r", encoding="utf-8") as f:
            return int(f.read().strip() or 0)
    except (FileNotFoundError, ValueError):
        return 0

# ================= ARGUMENTS =================

if len(sys.argv) < 4:
    # Require at least: frame.json, vertical offset, horizontal offset
    print(f"Usage: {sys.argv[0]} <frame.json> <offset_vertical> <offset_horizontal> [--flat <ANSI_COLOR>]")
    sys.exit(1)

frame_path = sys.argv[1]

try:
    # Offsets must be integers
    offset_v = int(sys.argv[2])
    offset_h = int(sys.argv[3])
except ValueError:
    print("Offsets must be integers")
    sys.exit(1)

# Optional flag --flat: render frame in a single flat ANSI color
flat_mode = False
flat_color = "\033[37m"  # default white

if "--flat" in sys.argv:
    idx = sys.argv.index("--flat")
    flat_mode = True
    if len(sys.argv) > idx + 1:
        flat_color = sys.argv[idx + 1]
        # Convert \e sequences to \033 if present
        flat_color = flat_color.replace("\\e", "\\033")
        # Interpret as actual escape sequence
        flat_color = flat_color.encode().decode("unicode_escape")

if not os.path.isfile(frame_path):
    print(f"File not found: {frame_path}")
    sys.exit(1)

# Compute the actual number of lines to skip vertically
skipLines_base = get_skip_lines_base()
skipLines = max(skipLines_base - offset_v, 0)

# ================= RENDER =================

# Hide the terminal cursor during rendering
print("\033[?25l", end="", flush=True)

try:
    # Load frame data from JSON
    with open(frame_path, "r", encoding="utf-8") as f:
        data = json.load(f)

    width  = data["width"]
    height = data["height"]
    pixels = data["pixels"]

    # Initialize blank frame and color matrix
    frame = [[" "] * width for _ in range(height)]
    color = [[(255, 255, 255)] * width for _ in range(height)]

    # Fill frame and color matrices with pixel data
    for p in pixels:
        x, y = p["x"], p["y"]
        if 0 <= x < width and 0 <= y < height:
            frame[y][x] = p["char"]
            color[y][x] = (p["r"], p["g"], p["b"])

    buf = StringIO()  # buffer all output for efficiency
    reset = "\033[0m" # ANSI reset code

    # Base coordinates for rendering
    BASE_ROW = skipLines + 1
    BASE_COL = max(offset_h, 1)

    # Track the last used color to minimize ANSI codes
    last_color = None

    for y in range(height):
        # Move cursor to start of current row
        buf.write(f"\033[{BASE_ROW + y};{BASE_COL}H")

        if flat_mode:
            # Flat mode: write a single ANSI color for the entire line
            buf.write(flat_color)

        for x in range(width):
            c = frame[y][x]

            if not flat_mode:
                # Only output ANSI color if it changed
                r, g, b = color[y][x]
                if last_color != (r, g, b):
                    buf.write(f"\033[38;2;{r};{g};{b}m")
                    last_color = (r, g, b)

            # Write the character
            buf.write(c)

        # Reset colors at the end of the line
        buf.write(reset)

    # Flush all buffered output to stdout
    sys.stdout.write(buf.getvalue())
    sys.stdout.flush()

finally:
    # Restore terminal cursor visibility
    sys.stdout.write("\033[?25h")
    sys.stdout.flush()
