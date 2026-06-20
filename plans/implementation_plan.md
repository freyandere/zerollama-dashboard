# Plan: Slots Scroll Fix, Repo Links Update, and Guidance Section Repositioning

This plan addresses three UI usability improvements in `monitor-enhanced.html`:
1. Prevent the slots parameter dropdown from losing its scroll position during every 1-second refresh cycle.
2. Update the footer links to show the user's repository, link the original project attribution, and add a link to the official repository.
3. Move the "Active suggestions" card to the top of the dashboard page, displaying it only when recommendations exist or when there is a server connection error.

## Proposed Changes

### Slots Page Update

#### [MODIFY] [monitor-enhanced.html](file:///e:/1.Environment/zerollama-dashboard/monitor-enhanced.html)
- **Slots Parameter Scroll Lock**:
  - In `updateSlotNode(node, s)`:
    - Only clear and rebuild the parameters inside `div.params` if `details.open` is true or `params.children.length === 0` (first rendering).
    - Capture `params.scrollTop` before clearing, and restore it after rendering to prevent scroll-jump.
- **Footer Links & Localization**:
  - Update `footer.app` markup:
    - Turn "Inspired by abhiFSD/llama.cpp-Monitor-Dashboard (MIT)" into a localized hyperlink pointing to `https://github.com/abhiFSD/llama.cpp-Monitor-Dashboard`.
    - Add a localized link "Official Repo" pointing to the original repo `https://github.com/jungrok5/zerollama-dashboard`.
    - Point the main "GitHub" link to the user's new repository `https://github.com/freyandere/zerollama-dashboard`.
  - Update `I18N` translation tables (`en` and `ru`) to include `"footer.official_repo"`.
- **Suggestions Repositioning**:
  - In `ensureRootScaffold()`, append `guidance-section` to `root` before `metrics-section` so it mounts at the top of the page.
  - In `renderGuidance()`, if there are no suggestions and the server is healthy (i.e. `!suggestions.length && !noData`), hide the section using `sec.style.display = "none"` so it doesn't occupy screen space when empty. Otherwise, display it with `sec.style.display = "contents"`.

## Verification Plan

### Automated Tests
- Run `verify_ids.py` to confirm that all required DOM IDs are preserved.

### Manual Verification
- Launch the enhanced dashboard.
- **Verify Slots Scroll**: Click "Show parameters" on an active/idle slot. Scroll down the parameter list. Confirm that the scroll position remains fixed and does not jump to the top every second.
- **Verify Footer Links**: Scroll to the footer, check that "Inspired by..." links to abhiFSD's repo, "Official Repo" links to jungrok5's repo, and "GitHub" links to freyandere's repo. Test translation switching (EN/RU) and check that both text and link layout adjust correctly.
- **Verify Suggestions Section**:
  - In healthy/demo mode, verify that the Guidance card is hidden at the top.
  - Shut down or disconnect the Llama server (or use a bad URL) to trigger "no data" guidance. Verify that the Guidance card pops up at the top of the dashboard.
