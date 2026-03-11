# Color Palette — Catppuccin

**This is the single source of truth for all colors and brand-specific styles.** Two themes are provided: Mocha (dark) as the default, and Latte (light) as an alternative. Pick the theme that matches the user's request or default to Mocha.

---

## Mocha (Dark — Default)

### Shape Colors (Semantic)

| Semantic Purpose | Fill | Stroke |
|---|---|---|
| Primary/Neutral | `#89b4fa` (Blue) | `#181825` (Mantle) |
| Secondary | `#74c7ec` (Sapphire) | `#181825` (Mantle) |
| Tertiary | `#b4befe` (Lavender) | `#181825` (Mantle) |
| Start/Trigger | `#fab387` (Peach) | `#181825` (Mantle) |
| End/Success | `#a6e3a1` (Green) | `#181825` (Mantle) |
| Warning/Reset | `#f38ba8` (Red) | `#181825` (Mantle) |
| Decision | `#f9e2af` (Yellow) | `#181825` (Mantle) |
| AI/LLM | `#cba6f7` (Mauve) | `#181825` (Mantle) |
| Inactive/Disabled | `#585b70` (Surface 2) | `#313244` (Surface 0, dashed) |
| Error | `#eba0ac` (Maroon) | `#181825` (Mantle) |

### Text Colors (Hierarchy)

| Level | Color | Use For |
|---|---|---|
| Title | `#89b4fa` | Section headings, major labels |
| Subtitle | `#74c7ec` | Subheadings, secondary labels |
| Body/Detail | `#a6adc8` | Descriptions, annotations, metadata |
| On light fills | `#1e1e2e` | Text inside light-colored shapes |
| On dark fills | `#cdd6f4` | Text inside dark-colored shapes |

### Evidence Artifact Colors

| Artifact | Background | Text Color |
|---|---|---|
| Code snippet | `#181825` (Mantle) | Syntax-colored (language-appropriate) |
| JSON/data example | `#181825` (Mantle) | `#a6e3a1` (Green) |

### Default Stroke & Line Colors

| Element | Color |
|---|---|
| Arrows | `#cdd6f4` (Text) — must contrast against the dark canvas, never use Mantle |
| Structural lines (dividers, trees, timelines) | `#6c7086` (Overlay 0) |
| Marker dots (fill + stroke) | `#89b4fa` (Blue) |

### Background

| Property | Value |
|---|---|
| Canvas background | `#1e1e2e` (Base) |

---

## Latte (Light — Alternative)

### Shape Colors (Semantic)

| Semantic Purpose | Fill | Stroke |
|---|---|---|
| Primary/Neutral | `#1e66f5` (Blue) | `#dce0e8` (Crust) |
| Secondary | `#209fb5` (Sapphire) | `#dce0e8` (Crust) |
| Tertiary | `#7287fd` (Lavender) | `#dce0e8` (Crust) |
| Start/Trigger | `#fe640b` (Peach) | `#dce0e8` (Crust) |
| End/Success | `#40a02b` (Green) | `#dce0e8` (Crust) |
| Warning/Reset | `#d20f39` (Red) | `#dce0e8` (Crust) |
| Decision | `#df8e1d` (Yellow) | `#dce0e8` (Crust) |
| AI/LLM | `#8839ef` (Mauve) | `#dce0e8` (Crust) |
| Inactive/Disabled | `#acb0be` (Surface 2) | `#ccd0da` (Surface 0, dashed) |
| Error | `#e64553` (Maroon) | `#dce0e8` (Crust) |

### Text Colors (Hierarchy)

| Level | Color | Use For |
|---|---|---|
| Title | `#1e66f5` | Section headings, major labels |
| Subtitle | `#209fb5` | Subheadings, secondary labels |
| Body/Detail | `#6c6f85` | Descriptions, annotations, metadata |
| On light fills | `#4c4f69` | Text inside light-colored shapes |
| On dark fills | `#eff1f5` | Text inside dark-colored shapes |

### Evidence Artifact Colors

| Artifact | Background | Text Color |
|---|---|---|
| Code snippet | `#e6e9ef` (Mantle) | Syntax-colored (language-appropriate) |
| JSON/data example | `#e6e9ef` (Mantle) | `#40a02b` (Green) |

### Default Stroke & Line Colors

| Element | Color |
|---|---|
| Arrows | `#4c4f69` (Text) — must contrast against the light canvas, never use Crust |
| Structural lines (dividers, trees, timelines) | `#9ca0b0` (Overlay 0) |
| Marker dots (fill + stroke) | `#1e66f5` (Blue) |

### Background

| Property | Value |
|---|---|
| Canvas background | `#eff1f5` (Base) |
