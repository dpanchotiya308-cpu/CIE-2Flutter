# SubSetu - B2B Industrial Machining & Supplier Workflow Platform
## Academic Project Documentation

### 1. Project Abstract
**SubSetu** is a dedicated B2B manufacturing orchestration and communication platform designed for precision machining suppliers (e.g., CNC milling, lathe turning, fiber laser cutting units) and industrial business workshops. 

The application bridges the transparency gap between raw material suppliers and machine shops by providing:
- Real-time **4-Stage Order Lifecycle Tracking** backed by Proof of Delivery (PoD).
- Automated **Material Yield Ledger Balancing** ensuring zero unexplained scrap loss.
- Peer-to-peer **Broadcast & RFQ Announcements** between Suppliers and Businesses.
- Role-specific dashboards and synchronized profile management.

---

### 2. Problem Statement
In traditional industrial subcontracting:
1. **Lack of Material Traceability:** Raw material issued by businesses often leads to disputes regarding usable offcuts and scrap metal weight.
2. **Disconnected Communication:** Requirements for open machine capacities (e.g., idle 5-axis CNC slots) are communicated informally via phone calls without standardized specifications or tolerances.
3. **Multi-Role Friction:** Suppliers and workshop buyers require completely distinct workflows but must share a unified operational ledger.

---

### 3. Solution Architecture
SubSetu implements a reactive, decoupled Flutter architecture:
- **Presentation Layer:** 25 responsive screens strictly conforming to pixel-perfect Figma specifications (`#2D3F63` dark industrial theme).
- **Session & State Management Layer:** Singleton `UserSessionService` inheriting `ChangeNotifier` providing reactive real-time state synchronization across Registration, Supplier Profile, and Business Profile without third-party bloat.
- **Data Validation & Business Logic:** 
  - Dynamic material yield balance validation ($Total Raw = Usable Offcut + Scrap + Finished Units$).
  - 4-Stage state transition logic with electronic PoD verification.

---

### 4. Key Modules & Features

#### Module 1: Dual Role Authentication & Onboarding
- Role Selection between **Enterprise Supplier** and **Business Workshop Buyer**.
- Unified login with customized home landing depending on role.
- Dynamic credential persistence via `UserSessionService`.

#### Module 2: Supplier Dashboard & Technology Showcase
- High-visibility circular emblems for CNC and Cutting equipment.
- Concise, interactive 2-3 line expandable accordion cards with tolerance specs.
- Quick navigation to Work Order creation.

#### Module 3: 4-Stage Supply Chain Order Sync
- **Stage 1 (Material Dispatched):** Supplier dispatches raw material.
- **Stage 2 (Material Received):** Business acknowledges reception with electronic PoD.
- **Stage 3 (Cutting In Progress):** Active workshop stage.
- **Stage 4 (Ready for Quality Assembly):** 1-tap quality approval.

#### Module 4: Material Yield & Scrap Ledger Audit
- Logs raw material issued (kg), offcut weight, and scrap metal shavings.
- Visual reconciliation meter confirming 100% balancing compliance.

#### Module 5: Bilateral Announcements System
- **Supplier Announcements:** Broadcast machine capacity slots and raw material stock.
- **Business Announcements:** Broadcast urgent job requirements, technical drawings, and batch RFQs.
- Categorized dropdowns, timestamps, and one-tap broadcast dispatch.

#### Module 6: Business Profile with Registered Details
- Displays all registered company, owner, email, phone, and machine capabilities below the "Edit Profile" button.
- Live Bottom Sheet editor with immediate state persistence.

---

### 5. Tech Stack & Implementation Details
- **Framework:** Flutter SDK 3.x (Dart 3.x)
- **UI Architecture:** Custom Material 3 Widgets with Inter Typography
- **State Architecture:** Clean Architecture with `ChangeNotifier` singleton
- **Design System:** Pixel-accurate Figma Dark Theme tokens
- **Test Suite:** Automated Flutter widget tests with 100% pass rate (`flutter test`)
- **Static Analysis:** Flutter Lints enabled with 0 warnings (`flutter analyze`)
