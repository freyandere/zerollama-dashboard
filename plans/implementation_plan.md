# Plan: Fix Chat Dialog Overflow and Viewport Boundaries

This plan covers styling fixes in `monitor-enhanced.html` to prevent the chat dialogue from expanding beyond viewport boundaries and ensure the input section remains fixed and visible at the bottom of the card while messages scroll.

## User Review Required

> [!NOTE]
> - `.chat-body` will be updated to have a fixed height of `600px` (with `max-height: 80vh` fallback for smaller viewports) and `overflow: hidden`.
> - On mobile viewports (width <= 720px), `.chat-body` height will adapt dynamically to `70vh` (with `max-height: 90vh`).
> - `.chat-main` will be explicitly constrained to `height: 100%` to ensure its child containers (messages and input row) fit exactly inside the parent grid track.

## Proposed Changes

### UI & Styling Fixes

#### [MODIFY] [monitor-enhanced.html](file:///e:/1.Environment/zerollama-dashboard/monitor-enhanced.html)
- Update `.chat-body` CSS selector:
  - Add `height: 600px;` and `max-height: 80vh;`.
  - Add `overflow: hidden;`.
- Update `.chat-main` CSS selector:
  - Add `height: 100%;` to keep children within the boundaries.
- Update `@media (max-width: 720px)` CSS block:
  - Set `.chat-body` to `height: 70vh; max-height: 90vh;`.

## Verification Plan

### Automated Tests
- Run `verify_ids.py` to check that no critical DOM element IDs have been removed or broken.

### Manual Verification
- Launch the server and open the dashboard.
- Expand the Chat tab, send multiple messages to fill the chat history, and verify that:
  - The chat input row and "Send" button remain fixed at the bottom of the card.
  - The messages container is scrollable and does not overflow visually or push the card off-screen.
  - The parameter sidebar displays correctly and remains scrollable if it contains overflow.
