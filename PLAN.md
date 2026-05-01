# PLAN.md — zerollama-dashboard

Per-phase implementation plan. Each phase = one commit.

| # | Phase | Output |
|---|---|---|
| 1 | Bootstrap + skeleton + i18n key table | LICENSE, 5 README, CLAUDE.md, PLAN.md, .gitignore, monitor.html skeleton |
| 2 | Polling engine + boot sequence + router-mode detection | monitor.html |
| 3 | Metrics cards + self-drawn SVG sparklines | monitor.html |
| 4 | Slot grid + sampling parameter expander | monitor.html |
| 5 | Model cards + LoRA + router selector + Server config card + POST controls | monitor.html |
| 6 | Log panel (HTTP Range tail + auto-detect) | monitor.html, README updates |
| 7 | Guidance system (rule catalog, ⓘ tooltips, Active suggestions) | monitor.html |
| 8 | i18n translations (ko, ja, zh-CN, es) + header selector + 4 README translations | monitor.html, READMEs |
| 9 | Polish, a11y, mobile, screenshots, final verification | monitor.html, README |

## URL parameters

| Param | Default | Purpose |
|---|---|---|
| `server` | same origin | llama-server base URL |
| `model` | (none) | router mode: default selected model |
| `poll` | `1000` | polling interval (ms) |
| `log` | auto | log file path; auto-detect if not specified, hide panel if HEAD fails |
| `lang` | auto | UI language; falls back to `navigator.language`, then `en` |

## Verification (per phase)

1. Serve `python3 -m http.server 8000`
2. Test against `llama-server` in both single and router mode
3. Exercise: server down, `--no-metrics`, `--no-slots`, bogus URL, mobile viewport
4. Confirm POST controls always prompt
