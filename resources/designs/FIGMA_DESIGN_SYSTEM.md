# SubSetu Figma Design System & UI Specifications

This document outlines the Figma design system, tokens, typography, and screen architecture used throughout the SubSetu mobile application.

## 1. Color Palette & Design Tokens

| Token Name | Hex Code | Usage | Role Context |
|---|---|---|---|
| `AppColors.background` | `#2D3F63` | Primary Screen Background, App Headers, Footers | Dark Industrial Theme |
| `AppColors.primaryYellow` | `#FAB115` / `#F5B800` | Primary CTAs, Active Tab Icons, Card Accents | High-Visibility Action Indicator |
| `AppColors.cardDark` | `#222B3F` | Form Cards, Order Cards, Detail Containers | Secondary Surface |
| `AppColors.borderSlate` | `#334155` | 1.5px Card Outlines, Input Field Borders | Structural Separator |
| `AppColors.accentBlue` | `#1D9BF0` | Profile Avatar Border, Category Tags, Links | Technological Highlighting |
| `AppColors.accentGreen` | `#10B981` | Success Indicators, Reconciled Badges | Status Confirmation |
| `AppColors.textWhite` | `#FFFFFF` | Primary Headings, Title Labels, White Text | Maximum Readability |
| `AppColors.textMuted` | `#94A3B8` | Field Labels, Timestamps, Secondary Descriptions | Subtle Secondary Information |

## 2. Typography Specification

- **Primary Font Family:** `Inter` (Google Fonts)
- **Hierarchy:**
  - **Screen Titles:** 24px - 27px, Bold (FontWeight 700), Line Height 29px
  - **Section Headers:** 18px - 20px, Bold (FontWeight 700), Line Height 24px
  - **Card Titles:** 15px - 16px, Semi-Bold / Bold (FontWeight 600 - 700)
  - **Body / Subtitles:** 13px - 14px, Regular (FontWeight 400), Line Height 17px
  - **Micro-labels / Badges:** 11px - 12px, Medium / Bold (FontWeight 500 - 700)

## 3. UI Component Standards

- **Pill Action Buttons:** Height 48px - 60px, `borderRadius: BorderRadius.circular(100)` or `62px`, Yellow `#FAB115` with black text.
- **Form Input Fields:** Height 52px - 60px, Background `#222B3F` or `#1A2234`, Border `1.5px solid #334155`, Inter typography.
- **Top Modular Header (`AppHeader`):** Background `#2D3F63`, Yellow Back Button / Profile Avatar on Left, Yellow Hamburger Menu on Right.
- **Persistent Bottom Navigation (`AppFooter`):** Height 72px, Background `#2D3F63`, 4 core icons (Home, Orders, Settings, Notification).

## 4. Screen Architecture Inventory

1. **Authentication Flow:**
   - `LoginScreen` (`/`) - Dual role login (Supplier / Business Workshop) with circular SubSetu emblem.
   - `RegisterScreen` (`/register`) - Account creation with user & company details.
   - `ForgotPasswordScreen` (`/forgot-password`)
   - `VerificationScreen` (`/verification`)
   - `NewPasswordScreen` (`/new-password`)
   - `RoleSelectionScreen` (`/role-selection`) - Interactive Supplier vs Workshop selection.

2. **Supplier Workflow:**
   - `SupplierDashboardScreen` (`/supplier-dashboard`) - CNC & Laser Cutting technology cards with 2-3 line interactive expansion.
   - `ProfileScreen` (`/profile`) - Supplier profile synced with registration details.
   - `MenuScreen` (`/menu`) - Supplier drawer with Announcements, Orders, Settings.
   - `AnnouncementsScreen` (`/announcements`) - Supplier broadcasts to business clients.

3. **Business Workshop Workflow:**
   - `BusinessHomeScreen` (`/business-home`) - Active orders, workshop statistics, live sync.
   - `BusinessProfileScreen` (`/business-profile`) - Business details, owner information, machine capabilities, live edit bottom sheet.
   - `BusinessMenuScreen` (`/business-menu`) - Workshop drawer navigation.
   - `BusinessAnnouncementsScreen` (`/business-announcements`) - RFQ & job requirement broadcasting to suppliers.

4. **Order & Material Sync Flow:**
   - `CurrentOrderScreen` (`/current-order`)
   - `OrderDetailsScreen` (`/order-details`) - Technical drawings, tolerances, work order specs.
   - `UpdateStatusScreen` (`/update-status`) - 4-stage supply chain synchronization.
   - `LogMaterialYieldScreen` (`/log-material-yield`) - Material yield ledger balancing & scrap audit.

5. **Support & Utilities:**
   - `CalculatorScreen` (`/calculator`) - Industrial machining & scrap fee calculations.
   - `HelpSupportScreen` (`/help-support`) - Searchable accordion FAQs.
   - `ContactUsScreen` (`/contact-us`) - Helpdesk & support ticket dispatch.
   - `NotificationsScreen` (`/notifications`) - Real-time activity feed.
   - `SettingsScreen` (`/settings`)
