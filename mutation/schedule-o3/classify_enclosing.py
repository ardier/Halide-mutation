#!/usr/bin/env python3
"""Classify each line of a C++ source file by its lexically-enclosing
function/method, via brace matching (comments and string/char literals
stripped first so braces inside them don't confuse the scan).

Usage: classify_enclosing.py <file.cpp> [line1 line2 ...]

Prints, for every requested line, the stack of enclosing function names
(innermost last) and the [start,end] line range of the innermost one.
If no lines given, prints every detected function definition's name and
line range (a directory of the file), which is useful for eyeballing.
"""
import re
import sys


KEYWORDS_NOT_FUNCS = {
    "if", "for", "while", "switch", "catch", "sizeof", "return",
    "do", "else", "new", "delete", "static_assert", "decltype",
}


def strip_comments_and_strings(text):
    """Replace comment/string/char contents with spaces, keep newlines
    so line numbers are unaffected."""
    out = []
    i = 0
    n = len(text)
    while i < n:
        c = text[i]
        if c == '/' and i + 1 < n and text[i + 1] == '/':
            while i < n and text[i] != '\n':
                out.append(' ')
                i += 1
            continue
        if c == '/' and i + 1 < n and text[i + 1] == '*':
            out.append('  ')
            i += 2
            while i < n and not (text[i] == '*' and i + 1 < n and text[i + 1] == '/'):
                out.append('\n' if text[i] == '\n' else ' ')
                i += 1
            out.append('  ')
            i += 2
            continue
        if c == '"':
            out.append(' ')
            i += 1
            # raw strings R"(...)" -- handle common case minimally
            while i < n and text[i] != '"':
                if text[i] == '\\' and i + 1 < n:
                    out.append(' ' if text[i] != '\n' else '\n')
                    out.append(' ' if text[i + 1] != '\n' else '\n')
                    i += 2
                    continue
                out.append(' ' if text[i] != '\n' else '\n')
                i += 1
            out.append(' ')
            i += 1
            continue
        if c == "'":
            out.append(' ')
            i += 1
            while i < n and text[i] != "'":
                if text[i] == '\\' and i + 1 < n:
                    out.append(' ')
                    out.append(' ')
                    i += 2
                    continue
                out.append(' ' if text[i] != '\n' else '\n')
                i += 1
            out.append(' ')
            i += 1
            continue
        out.append(c)
        i += 1
    return ''.join(out)


FUNC_SIG_RE = re.compile(
    r"""
    (?:(?P<qual>\w+)::)?      # optional Class:: qualifier right before name
    (?P<name>\w+)
    \s*\([^()]*(?:\([^()]*\)[^()]*)*\)   # balanced-ish arg list, 1 level of nesting
    \s*(?:const)?\s*(?:override)?\s*(?:noexcept)?\s*$
    """,
    re.VERBOSE | re.DOTALL,
)


def find_prev_chunk_start(text, brace_pos):
    """Walk backward from a '{' to the previous top-level ; } { (at the
    same or shallower nesting via a simple paren/angle-bracket-agnostic
    scan) to get the raw signature text."""
    depth_paren = 0
    i = brace_pos - 1
    while i >= 0:
        c = text[i]
        if c in ')':
            depth_paren += 1
        elif c in '(':
            depth_paren -= 1
        elif c in ';{}' and depth_paren <= 0:
            return i + 1
        i -= 1
    return 0


def classify_functions(text):
    """Return a list of (name, start_line, end_line, depth) for every
    brace-delimited region that looks like a function/method definition,
    using 1-indexed inclusive line numbers for the region *body*
    (from the line of '{' to the line of matching '}')."""
    clean = strip_comments_and_strings(text)
    n = len(clean)
    line_of = [0] * (n + 1)
    line = 1
    for idx, ch in enumerate(clean):
        line_of[idx] = line
        if ch == '\n':
            line += 1
    line_of[n] = line

    stack = []  # (is_func, name, start_idx)
    funcs = []
    i = 0
    while i < n:
        c = clean[i]
        if c == '{':
            prev_start = find_prev_chunk_start(clean, i)
            sig = clean[prev_start:i].strip()
            is_func = False
            name = None
            if sig and not sig.endswith('='):
                m = FUNC_SIG_RE.search(sig)
                if m:
                    cand = m.group('name')
                    if cand not in KEYWORDS_NOT_FUNCS:
                        # exclude control-flow-like: "if (...)" caught by keyword set;
                        # exclude class/struct decls: sig contains 'class '/'struct '
                        if not re.search(r'\b(class|struct|namespace|enum)\b', sig):
                            is_func = True
                            qual = m.group('qual')
                            name = (qual + '::' + cand) if qual else cand
            stack.append((is_func, name, i))
            i += 1
            continue
        if c == '}':
            if stack:
                is_func, name, start_idx = stack.pop()
                if is_func:
                    funcs.append((name, line_of[start_idx], line_of[i]))
            i += 1
            continue
        i += 1
    return funcs, clean


def enclosing_stack(funcs, lineno):
    """All funcs whose [start,end] contains lineno, sorted outermost first."""
    hits = [f for f in funcs if f[1] <= lineno <= f[2]]
    hits.sort(key=lambda f: (f[2] - f[1]))
    return list(reversed(hits))  # outermost (largest range) first


def main():
    path = sys.argv[1]
    text = open(path, encoding='utf-8', errors='replace').read()
    funcs, _ = classify_functions(text)
    lines = [int(x) for x in sys.argv[2:]]
    if not lines:
        for name, s, e in sorted(funcs, key=lambda f: f[1]):
            print(f"{name:<40} {s:>5} - {e:>5}  ({e-s+1} lines)")
        return
    for ln in lines:
        stack = enclosing_stack(funcs, ln)
        innermost = stack[0] if stack else None
        names = " > ".join(f[0] for f in reversed(stack)) if stack else "<top-level>"
        rng = f"[{innermost[1]}-{innermost[2]}]" if innermost else "-"
        print(f"line {ln:>5}: innermost={innermost[0] if innermost else None!s:<30} {rng:<14} stack={names}")


if __name__ == "__main__":
    main()
