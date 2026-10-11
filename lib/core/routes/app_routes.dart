import 'package:flutter/material.dart';
import '../../screens/auth/business_register_screen.dart';
import '../../screens/auth/forgot_password_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/new_password_screen.dart';
import '../../screens/auth/register_screen.dart';
import '../../screens/auth/verification_screen.dart';
import '../../screens/calculator/calculator_screen.dart';
import '../../screens/dashboard/business_home_screen.dart';
import '../../screens/dashboard/supplier_dashboard_screen.dart';
import '../../screens/menu/business_menu_screen.dart';
import '../../screens/menu/menu_screen.dart';
import '../../screens/notifications/notifications_screen.dart';
import '../../screens/orders/conform_order_screen.dart';
import '../../screens/orders/current_order_screen.dart';
import '../../screens/orders/log_material_yield_screen.dart';
import '../../screens/orders/order_details_screen.dart';
import '../../screens/orders/send_order_screen.dart';
import '../../screens/orders/update_status_screen.dart';
import '../../screens/announcements/announcements_screen.dart';
import '../../screens/announcements/business_announcements_screen.dart';
import '../../screens/profile/business_profile_screen.dart';
import '../../screens/profile/change_password_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/role/role_selection_screen.dart';
import '../../screens/settings/settings_screen.dart';
import '../../screens/support/about_us_screen.dart';
import '../../screens/support/contact_us_screen.dart';
import '../../screens/support/help_support_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String verification = '/verification';
  static const String newPassword = '/new-password';
  static const String changePassword = '/change-password';
  static const String profile = '/profile';
  static const String menu = '/menu';
  static const String businessMenu = '/business-menu';
  static const String currentOrder = '/current-order';
  static const String conformOrder = '/conform-order';
  static const String sendOrder = '/send-order';
  static const String calculator = '/calculator';
  static const String settings = '/settings';
  static const String roleSelection = '/role-selection';
  static const String supplierDashboard = '/supplier-dashboard';
  static const String businessRegister = '/business-register';
  static const String businessHome = '/business-home';
  static const String orderDetails = '/order-details';
  static const String updateStatus = '/update-status';
  static const String logMaterialYield = '/log-material-yield';
  static const String notifications = '/notifications';
  static const String businessProfile = '/business-profile';
  static const String helpSupport = '/help-support';
  static const String aboutUs = '/about-us';
  static const String contactUs = '/contact-us';
  static const String announcements = '/announcements';
  static const String businessAnnouncements = '/business-announcements';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(
            onRoleLogin: (role) {
              if (role == 'Supplier') {
                Navigator.pushNamed(context, supplierDashboard);
              } else {
                Navigator.pushNamed(context, businessHome);
              }
            },
            onLoginSuccess: () {
              Navigator.pushNamed(context, supplierDashboard);
            },
            onSignUpTap: () {
              Navigator.pushNamed(context, register);
            },
            onForgotPasswordTap: () {
              Navigator.pushNamed(context, forgotPassword);
            },
          ),
        );
      case register:
        return MaterialPageRoute(
          builder: (context) => RegisterScreen(
            onBackTap: () => Navigator.of(context).pop(),
            onSignInTap: () => Navigator.of(context).pop(),
            onSubmit: () {
              Navigator.pushNamed(context, roleSelection);
            },
          ),
        );
      case forgotPassword:
        return MaterialPageRoute(
          builder: (context) => ForgotPasswordScreen(
            onBackTap: () => Navigator.of(context).pop(),
            onBackToSignIn: () => Navigator.of(context).pop(),
            onSignUpTap: () {
              Navigator.pushReplacementNamed(context, register);
            },
            onSend: () {
              Navigator.pushNamed(context, verification);
            },
          ),
        );
      case verification:
        return MaterialPageRoute(
          builder: (context) => VerificationScreen(
            onBackTap: () => Navigator.of(context).pop(),
            onVerify: () {
              Navigator.pushNamed(context, newPassword);
            },
          ),
        );
      case newPassword:
        return MaterialPageRoute(
          builder: (context) => NewPasswordScreen(
            onBackTap: () => Navigator.of(context).pop(),
            onSubmit: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password updated successfully! Please login.')),
              );
              Navigator.pushNamedAndRemoveUntil(context, login, (route) => false);
            },
          ),
        );
      case changePassword:
        return MaterialPageRoute(
          builder: (context) => ChangePasswordScreen(
            onBackTap: () => Navigator.of(context).pop(),
            onUpdate: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password changed successfully!')),
              );
              Navigator.of(context).pop();
            },
          ),
        );
      case profile:
        return MaterialPageRoute(
          builder: (context) => ProfileScreen(
            onBackTap: () => Navigator.of(context).pop(),
            onUpdate: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully!')),
              );
              Navigator.of(context).pop();
            },
          ),
        );
      case menu:
        return MaterialPageRoute(
          builder: (context) => MenuScreen(
            onBackTap: () => Navigator.of(context).pop(),
            onMenuItemTap: (route) {
              Navigator.pushNamed(context, route);
            },
          ),
        );
      case businessMenu:
        return MaterialPageRoute(
          builder: (context) => BusinessMenuScreen(
            onBackTap: () => Navigator.of(context).pop(),
            onMenuItemTap: (route) {
              Navigator.pushNamed(context, route);
            },
          ),
        );
      case currentOrder:
        return MaterialPageRoute(
          builder: (context) => CurrentOrderScreen(
            onBackTap: () => Navigator.of(context).pop(),
          ),
        );
      case conformOrder:
        return MaterialPageRoute(
          builder: (context) => ConformOrderScreen(
            onBackTap: () => Navigator.of(context).pop(),
          ),
        );
      case sendOrder:
        return MaterialPageRoute(
          builder: (context) => SendOrderScreen(
            onBackTap: () => Navigator.of(context).pop(),
            onSend: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Order sent successfully!')),
              );
              Navigator.of(context).pop();
            },
          ),
        );
      case calculator:
        return MaterialPageRoute(
          builder: (context) => CalculatorScreen(
            onBackTap: () => Navigator.of(context).pop(),
          ),
        );
      case AppRoutes.settings:
        return MaterialPageRoute(
          builder: (context) => SettingsScreen(
            onBackTap: () => Navigator.of(context).pop(),
          ),
        );
      case roleSelection:
        return MaterialPageRoute(
          builder: (context) => RoleSelectionScreen(
            onRoleSelected: (role) {
              // Track role
            },
            onContinue: () {
              Navigator.pushNamed(context, supplierDashboard);
            },
          ),
        );
      case businessRegister:
        return MaterialPageRoute(
          builder: (context) => BusinessRegisterScreen(
            onBackTap: () => Navigator.of(context).pop(),
            onCreateProfile: () {
              Navigator.pushNamed(context, businessHome);
            },
          ),
        );
      case businessHome:
        return MaterialPageRoute(
          builder: (context) => BusinessHomeScreen(
            onProfileTap: () {
              Navigator.pushNamed(context, businessProfile);
            },
            onMenuTap: () {
              Navigator.pushNamed(context, businessMenu);
            },
            onOrderTap: () {
              Navigator.pushNamed(context, orderDetails);
            },
            onNavTap: (index) {
              if (index == 1) {
                Navigator.pushNamed(context, currentOrder);
              } else if (index == 2) {
                Navigator.pushNamed(context, AppRoutes.settings);
              } else if (index == 3) {
                Navigator.pushNamed(context, notifications);
              }
            },
          ),
        );
      case orderDetails:
        return MaterialPageRoute(
          builder: (context) => OrderDetailsScreen(
            onBackTap: () => Navigator.of(context).pop(),
            onMenuTap: () {
              Navigator.pushNamed(context, businessMenu);
            },
            onAccept: () {
              Navigator.pushNamed(context, updateStatus);
            },
            onNavTap: (index) {
              if (index == 0) {
                Navigator.pushNamed(context, businessHome);
              } else if (index == 1) {
                Navigator.pushNamed(context, currentOrder);
              } else if (index == 2) {
                Navigator.pushNamed(context, AppRoutes.settings);
              } else if (index == 3) {
                Navigator.pushNamed(context, notifications);
              }
            },
          ),
        );
      case updateStatus:
        return MaterialPageRoute(
          builder: (context) => UpdateStatusScreen(
            onBackTap: () => Navigator.of(context).pop(),
            onMenuTap: () {
              Navigator.pushNamed(context, businessMenu);
            },
            onNavTap: (index) {
              if (index == 0) {
                Navigator.pushNamed(context, businessHome);
              } else if (index == 1) {
                Navigator.pushNamed(context, currentOrder);
              } else if (index == 2) {
                Navigator.pushNamed(context, AppRoutes.settings);
              } else if (index == 3) {
                Navigator.pushNamed(context, notifications);
              }
            },
          ),
        );
      case logMaterialYield:
        return MaterialPageRoute(
          builder: (context) => LogMaterialYieldScreen(
            onBackTap: () => Navigator.of(context).pop(),
            onMenuTap: () {
              Navigator.pushNamed(context, businessMenu);
            },
            onNavTap: (index) {
              if (index == 0) {
                Navigator.pushNamed(context, businessHome);
              } else if (index == 1) {
                Navigator.pushNamed(context, currentOrder);
              } else if (index == 2) {
                Navigator.pushNamed(context, AppRoutes.settings);
              } else if (index == 3) {
                Navigator.pushNamed(context, notifications);
              }
            },
          ),
        );
      case notifications:
        return MaterialPageRoute(
          builder: (context) => NotificationsScreen(
            onBackTap: () => Navigator.of(context).pop(),
            onMenuTap: () {
              Navigator.pushNamed(context, businessMenu);
            },
            onNavTap: (index) {
              if (index == 0) {
                Navigator.pushNamed(context, businessHome);
              } else if (index == 1) {
                Navigator.pushNamed(context, currentOrder);
              } else if (index == 2) {
                Navigator.pushNamed(context, AppRoutes.settings);
              }
            },
          ),
        );
      case businessProfile:
        return MaterialPageRoute(
          builder: (context) => BusinessProfileScreen(
            onBackTap: () => Navigator.of(context).pop(),
            onMenuTap: () {
              Navigator.pushNamed(context, businessMenu);
            },
            onNavTap: (index) {
              if (index == 0) {
                Navigator.pushNamed(context, businessHome);
              } else if (index == 1) {
                Navigator.pushNamed(context, currentOrder);
              } else if (index == 2) {
                Navigator.pushNamed(context, AppRoutes.settings);
              } else if (index == 3) {
                Navigator.pushNamed(context, notifications);
              }
            },
          ),
        );
      case helpSupport:
        return MaterialPageRoute(
          builder: (context) => HelpSupportScreen(
            onBackTap: () => Navigator.of(context).pop(),
            onMenuTap: () {
              Navigator.pushNamed(context, businessMenu);
            },
            onNavTap: (index) {
              if (index == 0) {
                Navigator.pushNamed(context, businessHome);
              } else if (index == 1) {
                Navigator.pushNamed(context, currentOrder);
              } else if (index == 2) {
                Navigator.pushNamed(context, AppRoutes.settings);
              } else if (index == 3) {
                Navigator.pushNamed(context, notifications);
              }
            },
          ),
        );
      case aboutUs:
        return MaterialPageRoute(
          builder: (context) => AboutUsScreen(
            onBackTap: () => Navigator.of(context).pop(),
            onMenuTap: () {
              Navigator.pushNamed(context, menu);
            },
            onContactUsTap: () {
              Navigator.pushNamed(context, contactUs);
            },
            onHelpSupportTap: () {
              Navigator.pushNamed(context, helpSupport);
            },
            onNavTap: (index) {
              if (index == 0) {
                Navigator.pushNamed(context, businessHome);
              } else if (index == 1) {
                Navigator.pushNamed(context, currentOrder);
              } else if (index == 2) {
                Navigator.pushNamed(context, AppRoutes.settings);
              } else if (index == 3) {
                Navigator.pushNamed(context, notifications);
              }
            },
          ),
        );
      case contactUs:
        return MaterialPageRoute(
          builder: (context) => ContactUsScreen(
            onBackTap: () => Navigator.of(context).pop(),
            onMenuTap: () {
              Navigator.pushNamed(context, businessMenu);
            },
            onNavTap: (index) {
              if (index == 0) {
                Navigator.pushNamed(context, businessHome);
              } else if (index == 1) {
                Navigator.pushNamed(context, currentOrder);
              } else if (index == 2) {
                Navigator.pushNamed(context, AppRoutes.settings);
              } else if (index == 3) {
                Navigator.pushNamed(context, notifications);
              }
            },
          ),
        );
      case announcements:
        return MaterialPageRoute(
          builder: (context) => AnnouncementsScreen(
            onBackTap: () => Navigator.of(context).pop(),
            onMenuTap: () {
              Navigator.pushNamed(context, menu);
            },
            onNavTap: (index) {
              if (index == 1) {
                Navigator.pushNamed(context, currentOrder);
              } else if (index == 2) {
                Navigator.pushNamed(context, AppRoutes.settings);
              } else if (index == 3) {
                Navigator.pushNamed(context, notifications);
              }
            },
          ),
        );
      case businessAnnouncements:
        return MaterialPageRoute(
          builder: (context) => BusinessAnnouncementsScreen(
            onBackTap: () => Navigator.of(context).pop(),
            onMenuTap: () {
              Navigator.pushNamed(context, businessMenu);
            },
            onNavTap: (index) {
              if (index == 0) {
                Navigator.pushNamed(context, businessHome);
              } else if (index == 1) {
                Navigator.pushNamed(context, currentOrder);
              } else if (index == 2) {
                Navigator.pushNamed(context, AppRoutes.settings);
              } else if (index == 3) {
                Navigator.pushNamed(context, notifications);
              }
            },
          ),
        );
      case supplierDashboard:
        return MaterialPageRoute(
          builder: (context) => SupplierDashboardScreen(
            onProfileTap: () {
              Navigator.pushNamed(context, profile);
            },
            onMenuTap: () {
              Navigator.pushNamed(context, menu);
            },
            onNavTap: (index) {
              if (index == 1) {
                Navigator.pushNamed(context, currentOrder);
              } else if (index == 2) {
                Navigator.pushNamed(context, AppRoutes.settings);
              } else if (index == 3) {
                Navigator.pushNamed(context, notifications);
              }
            },
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
    }
  }
}
