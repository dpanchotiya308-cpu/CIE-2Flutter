# SubSetu Project Resources

Welcome to the **SubSetu** project resources directory. This folder contains all the official documentation, design specifications, mock datasets, and graphic assets utilized during the development of this B2B Industrial Machining platform.

## Directory Structure

```text
resources/
├── docs/                      # Academic Project Reports & Architecture Diagrams
│   ├── PROJECT_OVERVIEW.md    # Problem statement, solution architecture, and modules
│   └── ARCHITECTURE_AND_FLOW.md # Flowcharts, 4-stage sync diagram & navigation sitemap
│
├── designs/                   # Figma UI Specifications & Design System
│   └── FIGMA_DESIGN_SYSTEM.md # Color tokens, typography, component specs & 25 screens
│
├── data/                      # Sample Mock Datasets (JSON)
│   ├── sample_orders.json     # Work orders, tolerances, and 4-stage tracking status
│   ├── sample_yield_ledger.json # Raw material yield, scrap & 100% balancing ledger
│   ├── sample_announcements.json# Bilateral broadcasts (Supplier & Business)
│   └── sample_users.json      # User session profiles and machine capabilities
│
└── assets/                    # Project Image Catalog & Emblems
    ├── ASSET_CATALOG.md       # Asset catalog describing each graphic asset
    ├── subsetu_logo.png       # Circular main brand logo
    ├── cnc_tech_logo.png      # CNC 5-axis technology emblem
    ├── cutting_tech_logo.png  # 6kW fiber laser cutting emblem
    ├── business_icon.png      # Workshop role icon
    ├── enterprise_supplier_icon.png # Supplier role icon
    └── user_avatar.png        # User profile avatar
```

> **Note for Professors / Examiners:** All code implementation resides in `lib/`. The application can be built and run using standard Flutter tooling (`flutter run`, `flutter test`).
