#!/usr/bin/env python3
import os
import sys
import regex

if len(sys.argv) != 2:
    print(f"Usage: {sys.argv[0]} <directory-to-scan>")
    sys.exit(2)

start_dir = sys.argv[1]
if not os.path.isdir(start_dir):
    print(f"Error: '{start_dir}' is not a directory or does not exist.")
    sys.exit(2)

cyr_pattern      = regex.compile(r'\p{Cyrillic}')
emoji_pattern    = regex.compile(r'\p{Extended_Pictographic}')
emoticon_pattern = regex.compile(r'(?<=\s)[:;=8][\-~^]?[)(DPp](?=\s|$)')

# Binary file extensions to skip
# This list can be extended as needed
BINARY_EXTS = {
    '.png', '.jpg', '.jpeg', '.gif', '.bmp', '.ico',
    '.exe', '.dll', '.so', '.class', '.jar',
    '.pdf', '.zip', '.tar', '.tar.gz', '.7z',
}

def is_binary_file(path, chunk_size=1024):
    """
    Check if a file is binary by reading a chunk of it.
    If it contains null bytes or more than 30% non-text bytes,
    it is considered binary.
    """
    try:
        with open(path, 'rb') as f:
            chunk = f.read(chunk_size)
    except OSError:
        return True
    if b'\x00' in chunk:
        return True
    # Calculate the percentage of non-text bytes
    # Text bytes are typically in the range 0x20 to 0x7E
    text_bytes = set(range(0x20, 0x100)) | {9, 10, 13}
    # if more than 30% of the bytes are not in the text range, consider it binary
    non_text = sum(1 for b in chunk if b not in text_bytes)
    return (non_text / max(len(chunk),1)) > 0.30

found = False

for root, dirs, files in os.walk(start_dir):
    for name in files:
        path = os.path.join(root, name)
        rel  = os.path.relpath(path, start_dir)
        ext  = os.path.splitext(name)[1].lower()

        # Ignoring files with known binary extensions
        if ext in BINARY_EXTS:
            continue
        # Ignoring files that are likely binary
        if is_binary_file(path):
            continue

        # Checking filename for Cyrillic characters
        if cyr_pattern.search(name):
            print(f"::error file={rel}::filename contains Cyrillic")
            found = True

        # Checking file content for Cyrillic, emoji, or emoticons
        try:
            with open(path, encoding='utf-8', errors='ignore') as f:
                for num, line in enumerate(f, 1):
                    if (cyr_pattern.search(line)
                        or emoji_pattern.search(line)
                        or emoticon_pattern.search(line)):
                        msg = line.strip().replace('%', '%%')
                        print(f"::error file={rel},line={num}::{msg}")
                        found = True
        except OSError:
            continue

if found:
    sys.exit(1)
else:
    print("::notice:: No Cyrillic or emoji found")
    sys.exit(0)
