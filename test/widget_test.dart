import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:subsetu/core/routes/app_routes.dart';
import 'package:subsetu/main.dart';

void main() {
  testWidgets('Smoke test for Order Details Screen (Page 19)', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(804, 1748);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const SubSetuApp());
    expect(find.text('Login to Account'), findsOneWidget);
    expect(find.text('Supplier'), findsOneWidget);
    expect(find.text('Business'), findsOneWidget);

    // Tap Business role
    await tester.tap(find.text('Business'));
    await tester.pumpAndSettle();

    // Tap Login -> navigates to Business Home
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('Business Home'), findsOneWidget);

    // Tap Notification in footer on Business Home to verify footer navigation works
    await tester.tap(find.text('Notification'));
    await tester.pumpAndSettle();
    expect(find.text('Notifications'), findsOneWidget);

    // Navigate back to Business Home
    final BuildContext notifTestContext = tester.element(find.byType(Scaffold));
    Navigator.of(notifTestContext).pop();
    await tester.pumpAndSettle();

    // Navigate to Order Details Screen
    final BuildContext context = tester.element(find.byType(Scaffold));
    Navigator.pushNamed(context, AppRoutes.orderDetails);
    await tester.pumpAndSettle();

    // Verify Order Details elements
    expect(find.text('Order #1 Details'), findsOneWidget);
    expect(find.text('Client Information'), findsOneWidget);
    expect(find.text('Tech Corp Inc.'), findsOneWidget);
    expect(find.text('PENDING'), findsOneWidget);
    expect(find.text('18 Feb 2026'), findsOneWidget);

    expect(find.text('Dimensions & Specs'), findsOneWidget);
    expect(find.text('Material Grade: Mild Steel (EN8)'), findsOneWidget);
    expect(find.text('Tolerances: ±0.05 mm'), findsOneWidget);
    expect(find.text('Heat Treatment: Required'), findsOneWidget);

    // Verify Buttons
    expect(find.text('Accept Work Order'), findsOneWidget);
    expect(find.text('Decline Work Order'), findsOneWidget);

    // Tap Accept Work Order -> navigates to Update Status Screen (Page 20)
    await tester.ensureVisible(find.text('Accept Work Order'));
    await tester.tap(find.text('Accept Work Order'));
    await tester.pumpAndSettle();

    // Verify Update Status elements
    expect(find.text('Update Status'), findsOneWidget);
    expect(find.text('Order #1 - 4-Stage Sync'), findsOneWidget);
    expect(find.text('Material Dispatched'), findsOneWidget);
    expect(find.text('By Supplier: 18 Feb, 10:00 AM'), findsOneWidget);
    expect(find.text('Material Received'), findsOneWidget);
    expect(find.text('Acknowledged via PoD'), findsOneWidget);
    expect(find.text('Cutting In Progress'), findsOneWidget);
    expect(find.text('Currently active stage'), findsOneWidget);
    expect(find.text('Ready for Quality Assembly'), findsOneWidget);
    expect(find.text('1-Tap: Mark as Ready'), findsOneWidget);

    // Tap Mark as Ready
    await tester.tap(find.text('1-Tap: Mark as Ready'));
    await tester.pumpAndSettle();

    expect(find.text('Marked as Ready'), findsOneWidget);

    // Test manually clicking checkboxes for all stages
    await tester.tap(find.text('Material Dispatched'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Material Received'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cutting In Progress'));
    await tester.pumpAndSettle();

    // Manually tap to toggle back
    await tester.tap(find.text('Material Dispatched'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Material Received'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cutting In Progress'));
    await tester.pumpAndSettle();

    // Navigate to Log Material Yield Screen (Page 21)
    final BuildContext updateContext = tester.element(find.byType(Scaffold));
    Navigator.pushNamed(updateContext, AppRoutes.logMaterialYield);
    await tester.pumpAndSettle();

    // Verify Log Material Yield elements
    expect(find.text('Log Material Yield'), findsOneWidget);
    expect(find.text('Total Raw Material Issued'), findsOneWidget);
    expect(find.text('250.00 kg'), findsOneWidget);
    expect(find.text('Usable Offcut Weight (kg)'), findsOneWidget);
    expect(find.text('15.5'), findsOneWidget);
    expect(find.text('Scrap / Metal Shavings (kg)'), findsOneWidget);
    expect(find.text('8.2'), findsOneWidget);
    expect(find.text('Yield Balancing Preview'), findsOneWidget);
    expect(find.text('Finished Units: 226.3 kg'), findsOneWidget);
    expect(find.text('Reconciliation match: 100%'), findsOneWidget);
    expect(find.text('Submit Ledger Record'), findsOneWidget);

    // Tap Submit Ledger Record
    await tester.ensureVisible(find.text('Submit Ledger Record'));
    await tester.tap(find.text('Submit Ledger Record'));
    await tester.pumpAndSettle();

    // Navigate to Notifications Screen (Page 22)
    final BuildContext yieldContext = tester.element(find.byType(Scaffold));
    Navigator.pushNamed(yieldContext, AppRoutes.notifications);
    await tester.pumpAndSettle();

    // Verify Notifications elements
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Mark all as read'), findsOneWidget);
    expect(find.text('New Order Received'), findsOneWidget);
    expect(find.text('Tech Corp Inc. placed Order #12'), findsOneWidget);
    expect(find.text('2 mins ago'), findsOneWidget);
    expect(find.text('Vendor Verified'), findsOneWidget);
    expect(find.text('Global Logistics is now active.'), findsOneWidget);
    expect(find.text('1 hour ago'), findsOneWidget);
    expect(find.text('PoD Approved'), findsOneWidget);
    expect(find.text('Alpha Industries verified materials.'), findsOneWidget);
    expect(find.text('Yesterday, 4:30 PM'), findsOneWidget);

    // Tap Mark all as read
    await tester.tap(find.text('Mark all as read'));
    await tester.pumpAndSettle();

    // Navigate to Business Profile Screen (Page 23)
    final BuildContext notifContext = tester.element(find.byType(Scaffold));
    Navigator.pushNamed(notifContext, AppRoutes.businessProfile);
    await tester.pumpAndSettle();

    // Verify Business Profile elements and registered details below Edit Profile
    expect(find.text('Business Profile'), findsOneWidget);
    expect(find.text('EM'), findsOneWidget);
    expect(find.text('Edit Profile'), findsOneWidget);
    expect(find.text('Workshop / Company Name'), findsOneWidget);
    expect(find.text('Owner Full Name'), findsOneWidget);
    expect(find.text('Phone Number'), findsOneWidget);
    expect(find.text('Machine Capabilities'), findsOneWidget);
    expect(find.text('App Settings & Language'), findsOneWidget);
    expect(find.text('On-Time Delivery Rate'), findsNothing);
    expect(find.text('Switch Role (Supplier / Workshop)'), findsNothing);

    // Tap Edit Profile to open sheet
    await tester.tap(find.text('Edit Profile'));
    await tester.pumpAndSettle();

    expect(find.text('Edit Business Profile'), findsOneWidget);
    expect(find.text('Save Changes'), findsOneWidget);

    // Tap Save Changes
    await tester.tap(find.text('Save Changes'));
    await tester.pumpAndSettle();

    // Test Business Announcements screen
    final BuildContext bAnnContext = tester.element(find.byType(Scaffold));
    Navigator.pushNamed(bAnnContext, AppRoutes.businessAnnouncements);
    await tester.pumpAndSettle();

    expect(find.text('Announcements'), findsOneWidget);
    expect(find.text('Post Requirement to Suppliers'), findsOneWidget);
    expect(find.text('Broadcast to Suppliers'), findsOneWidget);
    expect(find.text('Recent Supplier Broadcasts'), findsOneWidget);

    // Broadcast a job requirement
    await tester.enterText(find.byType(TextField).at(0), 'Urgent: Lathe Turning RFQ');
    await tester.enterText(find.byType(TextField).at(1), 'Mild Steel EN8 • ±0.05 mm');
    await tester.enterText(find.byType(TextField).at(2), 'Immediate requirement for 300 pcs.');
    await tester.ensureVisible(find.text('Broadcast to Suppliers'));
    await tester.tap(find.text('Broadcast to Suppliers'));
    await tester.pumpAndSettle();

    expect(find.text('Urgent: Lathe Turning RFQ'), findsOneWidget);

    // Navigate to Help & Support Screen (Page 24)
    final BuildContext bpContext = tester.element(find.byType(Scaffold));
    Navigator.pushNamed(bpContext, AppRoutes.helpSupport);
    await tester.pumpAndSettle();

    // Verify Help & Support elements
    expect(find.text('Help & Support'), findsOneWidget);
    expect(find.text('Search FAQs or articles...'), findsOneWidget);
    expect(find.text('Frequently Asked Questions'), findsOneWidget);
    expect(find.text('How do I log scrap materials?'), findsOneWidget);
    expect(find.text('How is the machining fee calculated?'), findsOneWidget);
    expect(find.text('Fees are auto-calculated based on per-piece cutting dimensions and pre-agreed labor rates with your supplier.'), findsOneWidget);
    expect(find.text('Why is my PoD rejected?'), findsOneWidget);
    expect(find.text('Contact SubSetu Support'), findsOneWidget);

    // Tap FAQ Item 1 to toggle accordion
    await tester.tap(find.text('How do I log scrap materials?'));
    await tester.pumpAndSettle();

    // Navigate to Contact Us Screen (Page 25)
    final BuildContext hsContext = tester.element(find.byType(Scaffold));
    Navigator.pushNamed(hsContext, AppRoutes.contactUs);
    await tester.pumpAndSettle();

    // Verify Contact Us elements (Page 25)
    expect(find.text('Contact Us'), findsOneWidget);
    expect(find.text('Need help with a Work Order or PoD?'), findsOneWidget);
    expect(find.text('Call Helpdesk'), findsOneWidget);
    expect(find.text('+91 1234567890 • Mon-Sat'), findsOneWidget);
    expect(find.text('Email Support'), findsOneWidget);
    expect(find.text('support@subsetu.com • 24/7'), findsOneWidget);
    expect(find.text('Submit a Ticket'), findsOneWidget);
    expect(find.text('Issue Category'), findsOneWidget);
    expect(find.text('Proof of Delivery (PoD) Verification'), findsOneWidget);
    expect(find.text('Message Details'), findsOneWidget);
    expect(find.text('Send Message'), findsOneWidget);

    // Tap Send Message
    await tester.ensureVisible(find.text('Send Message'));
    await tester.tap(find.text('Send Message'), warnIfMissed: false);
    await tester.pumpAndSettle();
  });

  testWidgets('Test Register to Profile connection, updating profile, and Supplier Dashboard', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(804, 1748);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const SubSetuApp());

    // Navigate to Register Screen
    final BuildContext context = tester.element(find.byType(Scaffold));
    Navigator.pushNamed(context, AppRoutes.register);
    await tester.pumpAndSettle();

    expect(find.text('Create Your Account'), findsOneWidget);

    // Enter details in Register screen
    await tester.enterText(find.byType(TextField).at(0), 'Rajesh Sharma');
    await tester.enterText(find.byType(TextField).at(1), 'rajesh@example.com');
    await tester.enterText(find.byType(TextField).at(4), '9876543210');
    await tester.enterText(find.byType(TextField).at(5), 'Apex Engineering Works');

    // Tap Submit
    await tester.ensureVisible(find.text('Submit'));
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    // Now navigate to Profile Screen
    final BuildContext regContext = tester.element(find.byType(Scaffold));
    Navigator.pushNamed(regContext, AppRoutes.profile);
    await tester.pumpAndSettle();

    // Verify Profile shows all registered details!
    expect(find.text('Rajesh Sharma'), findsOneWidget);
    expect(find.text('rajesh@example.com'), findsOneWidget);
    expect(find.text('9876543210'), findsOneWidget);
    expect(find.text('Apex Engineering Works'), findsOneWidget);

    // Tap Update button
    await tester.ensureVisible(find.text('Update'));
    await tester.tap(find.text('Update'));
    await tester.pumpAndSettle();

    // Now navigate to Announcements Screen
    final BuildContext profContext = tester.element(find.byType(Scaffold));
    Navigator.pushNamed(profContext, AppRoutes.announcements);
    await tester.pumpAndSettle();

    // Verify Announcements elements
    expect(find.text('Announcements'), findsOneWidget);
    expect(find.text('Post New Announcement'), findsOneWidget);
    expect(find.text('Broadcast to Businesses'), findsOneWidget);
    expect(find.text('Recent Broadcasts'), findsOneWidget);

    // Broadcast an announcement
    await tester.enterText(find.byType(TextField).at(0), 'Urgent: Lathe Slots Open');
    await tester.enterText(find.byType(TextField).at(1), 'Available for 3 batches this week.');
    await tester.ensureVisible(find.text('Broadcast to Businesses'));
    await tester.tap(find.text('Broadcast to Businesses'));
    await tester.pumpAndSettle();

    expect(find.text('Urgent: Lathe Slots Open'), findsOneWidget);

    // Now navigate to Supplier Dashboard and test View More
    final BuildContext annContext = tester.element(find.byType(Scaffold));
    Navigator.pushNamed(annContext, AppRoutes.supplierDashboard);
    await tester.pumpAndSettle();

    // Verify initial "View More" links for both CNC and Cutting
    expect(find.text('View More'), findsNWidgets(2));
    expect(find.textContaining('Best CNC Technology'), findsOneWidget);
    expect(find.textContaining('Best Cutting Technology'), findsOneWidget);

    // Tap first "View More" (CNC Technology)
    await tester.tap(find.text('View More').first);
    await tester.pumpAndSettle();

    // Now CNC card is expanded: shows View Less and 2-3 line description!
    expect(find.text('View Less'), findsOneWidget);
    expect(find.textContaining('High precision 5-axis CNC machining'), findsOneWidget);

    // Tap "View Less" to collapse
    await tester.tap(find.text('View Less'));
    await tester.pumpAndSettle();

    // Back to both having "View More"
    expect(find.text('View More'), findsNWidgets(2));
  });

  testWidgets('Test Supplier Menu (no stock), Announcements Screen, and Settings -> About Us Screen', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(804, 1748);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const SubSetuApp());

    // 1. Navigate to Supplier Menu
    final BuildContext context = tester.element(find.byType(Scaffold));
    Navigator.pushNamed(context, AppRoutes.menu);
    await tester.pumpAndSettle();

    expect(find.text('Menu'), findsOneWidget);
    expect(find.text('Announcements'), findsOneWidget);
    // Verify Stock is completely removed!
    expect(find.text('Stock'), findsNothing);

    // Tap on Announcements in Supplier Menu
    await tester.tap(find.text('Announcements'));
    await tester.pumpAndSettle();

    // Verify Announcements Screen elements
    expect(find.text('Announcements'), findsOneWidget);
    expect(find.text('Post New Announcement'), findsOneWidget);
    expect(find.text('Broadcast to Businesses'), findsOneWidget);
    expect(find.text('Recent Broadcasts'), findsOneWidget);

    // Test filter chips
    await tester.ensureVisible(find.text('Material Stock'));
    await tester.tap(find.text('Material Stock'), warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(find.text('Fresh Mild Steel EN8 Stock Received'), findsOneWidget);

    await tester.ensureVisible(find.text('All'));
    await tester.tap(find.text('All'), warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(find.text('CNC Lathe Slot Open for Next Week'), findsOneWidget);

    // Test broadcasting new announcement
    await tester.enterText(find.byType(TextField).at(0), 'Laser Cutting 6kW Available');
    await tester.enterText(find.byType(TextField).at(1), 'Ready for SS and MS sheet jobs with 24hr dispatch.');
    await tester.ensureVisible(find.text('Broadcast to Businesses'));
    await tester.tap(find.text('Broadcast to Businesses'));
    await tester.pumpAndSettle();

    expect(find.text('Laser Cutting 6kW Available'), findsOneWidget);

    // 2. Navigate to Business Announcements Screen
    final BuildContext annContext = tester.element(find.byType(Scaffold));
    Navigator.pushNamed(annContext, AppRoutes.businessAnnouncements);
    await tester.pumpAndSettle();

    expect(find.text('Post Requirement to Suppliers'), findsOneWidget);
    expect(find.text('Broadcast to Suppliers'), findsOneWidget);
    expect(find.text('Recent Supplier Broadcasts'), findsOneWidget);

    // 3. Navigate to Settings Screen
    final BuildContext bizAnnContext = tester.element(find.byType(Scaffold));
    Navigator.pushNamed(bizAnnContext, AppRoutes.settings);
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('About Us ?'), findsOneWidget);

    // Tap on 'About Us ?'
    await tester.tap(find.text('About Us ?'));
    await tester.pumpAndSettle();

    // Verify About Us screen elements
    expect(find.text('About Us'), findsOneWidget);
    expect(find.textContaining('SubSetu'), findsWidgets);
    expect(find.textContaining('1.0.0'), findsOneWidget);
    expect(find.text('Our Mission'), findsOneWidget);
    expect(find.text('4-Stage Supply Chain Sync'), findsOneWidget);
    expect(find.text('Contact Us'), findsOneWidget);
    expect(find.text('FAQs & Help'), findsOneWidget);
  });
}

