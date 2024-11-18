// routes.dart

import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/booking.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/cardPage.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/change_password.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/contact.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/faq_page_screen.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/help&support_screen.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/notification.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/profile_page_screen.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/raiseissue_details_screen.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/term_condition_screen.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/transaction.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/verify_password_screen.dart';
import 'package:flutter_cab/view/dashboard/home_screen.dart';
import 'package:flutter_cab/view/dashboard/account_screen.dart';
import 'package:flutter_cab/view/dashboard/offers_pages/all_offers_screen.dart';
import 'package:flutter_cab/view/dashboard/offers_pages/offer_details_screen.dart';
import 'package:flutter_cab/view/dashboard/raiseIssue_pages/issue_view_details_screen.dart';
import 'package:flutter_cab/view/dashboard/rental/book_your_ride_screen_.dart';
import 'package:flutter_cab/view/dashboard/rental/cancel_booking.dart';
import 'package:flutter_cab/view/dashboard/rental/cars_available_screen.dart';
import 'package:flutter_cab/view/dashboard/rental/guestdetails_bookingform_screen.dart';
import 'package:flutter_cab/view/dashboard/rental/happy_booking_screen.dart';
import 'package:flutter_cab/view/dashboard/rental/history/rental_bookedpage_view.dart';
import 'package:flutter_cab/view/dashboard/rental/history/rental_cancel_page_view.dart';
import 'package:flutter_cab/view/dashboard/rental/history/rental_history_managment_screen.dart';
import 'package:flutter_cab/view/dashboard/rental/rental_form.dart';
// import 'package:flutter_cab/view/dashboard/tourPackage/addMemberDesign.dart';
import 'package:flutter_cab/view/dashboard/tourPackage/package_screen.dart';
import 'package:flutter_cab/view/dashboard/tourPackage/package_booking_member_screen.dart';
import 'package:flutter_cab/view/dashboard/tourPackage/package_viewdetails_screen.dart';
import 'package:flutter_cab/view/dashboard/tourPackage/packageHistory/mypackage_history_screen.dart';
import 'package:flutter_cab/view/dashboard/tourPackage/tourPackageForm.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/edit_profile_screen.dart';
import 'package:flutter_cab/view/dashboard/wallet_pages/wallet_history_screen.dart';
import 'package:flutter_cab/view/dashboard/wallet_pages/wallet_screen.dart';
import 'package:flutter_cab/view/registration/forgot_screen.dart';
import 'package:flutter_cab/view/registration/login_screen.dart';
import 'package:flutter_cab/view/registration/otp_verification_screen.dart';
import 'package:flutter_cab/view/registration/registration_screen.dart';
import 'package:flutter_cab/view/registration/splash_screen.dart';
import 'package:flutter_cab/view/reset_password_screen.dart';
import 'package:go_router/go_router.dart';

import '../../view/dashboard/tourPackage/packageHistory/package_booking_details.dart';

final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter myRouter = GoRouter(
  // initialLocation: '/profilePage/editProfilePage',
  initialLocation: '/splash',
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    ///For Bottom Navigation Regarding
    // ShellRoute(
    //   navigatorKey: _shellNavigatorKey,
    //   builder: (BuildContext context, GoRouterState state, Widget child) {
    //     return CustomBottomNavigationBar(
    //         child: child, currentRoute: state.uri.toString());
    //   },
    //   routes: [
    //     GoRoute(
    //       path: '/',
    //       parentNavigatorKey: _shellNavigatorKey,
    //       pageBuilder: (context, state) {
    //         return const NoTransitionPage(child:
    //         VendorProfileScreen()
    //         );
    //       },
    //     ),
    //     GoRoute(
    //         path: '/vendor',
    //         parentNavigatorKey: _shellNavigatorKey,
    //         pageBuilder: (context, state) {
    //           return const NoTransitionPage(child: VendorProfileScreen());
    //         },
    //         routes: [
    //           GoRoute(
    //             path: 'vendor',
    //             parentNavigatorKey: _rootNavigatorKey,
    //             pageBuilder: (context, state) {
    //               return const NoTransitionPage(child: VendorProfileScreen());
    //             },
    //           ),
    //           GoRoute(
    //             path: 'vendor',
    //             parentNavigatorKey: _rootNavigatorKey,
    //             pageBuilder: (context, state) {
    //               final title = state.extra as Map<String, dynamic>;
    //               final color = state.extra as Map<String, dynamic>;
    //               return NoTransitionPage(
    //                   child:VendorProfileScreen());
    //             },
    //           ),
    //         ]),
    //     GoRoute(
    //         path: '/vendor',
    //         parentNavigatorKey: _shellNavigatorKey,
    //         pageBuilder: (context, state) {
    //           return const NoTransitionPage(child: VendorProfileScreen());
    //         },
    //         routes: []),
    //     GoRoute(
    //       path: '/vendor',
    //       parentNavigatorKey: _shellNavigatorKey,
    //       pageBuilder: (context, state) {
    //         return const NoTransitionPage(child: VendorProfileScreen());
    //       },
    //     ),
    //   ],
    // ),
    GoRoute(
        path: '/splash',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashSreen();
        }),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/signup',
      builder: (BuildContext context, GoRouterState state) {
        return const registration_screen();
      },
    ),
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        // var data = state.extra as Map<String, dynamic>;
        return const home_screen();
      },
    ),
    // GoRoute(
    //   path: '/oneWayTrip',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const one_way_trip();
    //   },
    // ),
    GoRoute(
      path: '/notification',
      builder: (BuildContext context, GoRouterState state) {
        return const NotificationPage();
      },
    ),
    GoRoute(
      path: '/menuPage',
      pageBuilder: (BuildContext context, GoRouterState state) {
        var data = state.extra as Map<String, dynamic>;
        return CustomTransitionPage(
          key: state.pageKey,
          child: AccountScreen(userId: data['id']),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(-1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      },
    ),
    // GoRoute(
    //   path: '/menuPage',
    //   builder: (BuildContext context, GoRouterState state) {
    //     var data = state.extra as Map<String, dynamic>;
    //     return MenuList(userId: data['id'],);
    //   },
    // ),
    GoRoute(
        path: '/profilePage',
        builder: (BuildContext context, GoRouterState state) {
          var data = state.extra as Map<String, dynamic>;
          // return ProfilePage(user:'1001',);
          return ProfilePage(
            user: data['userId'],
          );
        },
        routes: [
          GoRoute(
            path: 'editProfilePage',
            builder: (BuildContext context, GoRouterState state) {
              var data = state.extra as Map<String, dynamic>;
              return EditProfiePage(
                usrId: data['uId'],
              );
            },
          ),
        ]),
    GoRoute(
      path: '/booking',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return const NoTransitionPage(child: MyBooking());
      },
    ),
    GoRoute(
      path: '/changePassword',
      // parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        var data = state.extra as Map<String, dynamic>;
        return ChangePassword(
          userId: data['userId'],
        );
      },
    ),
    GoRoute(
      path: '/verifyPassword',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const VerifyPassword();
      },
    ),
    GoRoute(
      path: '/forgotPassword',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const ForgotPassword();
      },
    ),
    GoRoute(
      path: '/verifyOtp',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        var data = state.extra as Map<String, dynamic>;
        return OtpVerificationScreen(
          email: data["email"],
        );
      },
    ),
    GoRoute(
      path: '/resetPassword',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        var data = state.extra as Map<String, dynamic>;

        return ResetPasswordScreen(
          email: data["email"],
        );
      },
    ),
    GoRoute(
      path: '/faqPage',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const FAQPage();
      },
    ),
    GoRoute(
      path: '/termCondition',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const TermCondition();
      },
    ),
    GoRoute(
      path: '/contact',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const ContactPage();
      },
    ),
    GoRoute(
      path: '/help&support',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const HelpAndSupport();
      },
    ),
    GoRoute(
      path: '/raiseIssueDetail',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const Raiseissuedetails();
      },
    ),
    GoRoute(
      path: '/issueDetailsbyId',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const Issueviewdetails();
      },
    ),
    GoRoute(
      path: '/myCards',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const CardPage();
      },
    ),
    GoRoute(
      path: '/allOffer',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        var data = state.extra as Map<String, dynamic>;
        return AlloffersScreen(
          initialIndex: data["initialIndex"],
        );
      },
    ),
    GoRoute(
      path: '/OfferDetails',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const OfferdetailsScreen();
      },
    ),
    GoRoute(
      path: '/myTransaction',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        var userId = state.extra as Map<String, dynamic>;

        return MyTransaction(
          userId: userId["userId"],
        );
      },
    ),
    GoRoute(
      path: '/myWallet',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        var userId = state.extra as Map<String, dynamic>;

        return WalletScreen(
          userId: userId["userId"],
        );
      },
    ),
    GoRoute(
      path: '/walletHistory',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        var userId = state.extra as Map<String, dynamic>;

        return WalletHistoryScreen(
          userId: userId["userId"],
        );
      },
    ),
    GoRoute(
      path: '/setting',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const Scaffold(
          body: PageLayout_Page(
            appHeading: "Setting Page",
            child: Center(
              child: Text("Setting Page"),
            ),
          ),
        );
      },
    ),
    GoRoute(
        path: '/package',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) {
          final uid = state.extra as Map<String, dynamic>;
          return Packages(
            ursID: uid['user'],
          );
        },
        routes: [
          // GoRoute(
          //   path: 'tourPackage',
          //   parentNavigatorKey: _rootNavigatorKey,
          //   builder: (BuildContext context, GoRouterState state) {
          //     return const TourPackage();
          //   },
          // ),
          GoRoute(
            path: 'packageDetails',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              final pkgId = state.extra as Map<String, dynamic>;
              final usrId = state.extra as Map<String, dynamic>;
              final bookingDate = state.extra as Map<String, dynamic>;
              // return  const PackageDetailsOld();
              return PackageDetails(
                packageId: pkgId['packageID'],
                userId: usrId['userId'],
                bookDate: bookingDate['bookDate'],
              );
            },
          ),
          GoRoute(
            path: 'packageBookingMember',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              final pkgId = state.extra as Map<String, dynamic>;
              final usrId = state.extra as Map<String, dynamic>;
              final amt = state.extra as Map<String, dynamic>;
              final bookingDate = state.extra as Map<String, dynamic>;
              return PackageBookingMemberPage(
                packageID: pkgId["pkgID"],
                userID: usrId['usrID'],
                amt: amt['amt'],
                bookingDate: bookingDate['bookDate'],
              );
            },
          ),
          /////Test Member design
          // GoRoute(
          //   path: 'packageMember',
          //   parentNavigatorKey: _rootNavigatorKey,
          //   builder: (BuildContext context, GoRouterState state) {
          //     // final pkgId = state.extra as Map<String, dynamic>;
          //     // final usrId = state.extra as Map<String, dynamic>;
          //     // final amt = state.extra as Map<String, dynamic>;
          //     // final bookingDate = state.extra as Map<String, dynamic>;
          //     return const PackageBooking();
          //   },
          // ),

          ///History Pages
          GoRoute(
            path: 'packageHistoryManagement',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              final data = state.extra as Map<String, dynamic>;
              return PackageHistoryManagement(userID: data['userID']);
            },
          ),
          GoRoute(
            path: 'packageDetailsPageView',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              final userID = state.extra as Map<String, dynamic>;
              final bookID = state.extra as Map<String, dynamic>;
              final paymentId = state.extra as Map<String, dynamic>;
              return PackagePageViewDetails(
                userId: userID['user'],
                packageBookID: bookID['book'],
                paymentId: paymentId['paymentId'],
              );
            },
          ),
        ]),
    GoRoute(
        path: '/rentalForm',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) {
          final data = state.extra as Map<String, dynamic>;
          return RentalForm(userId: data['userId']);
        },
        routes: [
          GoRoute(
            path: 'happyScreen',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              var data = state.extra as Map<String, dynamic>;
              return HappyBookingScreen(
                userId: data['userId'],
              );
            },
          ),
          GoRoute(
            path: 'carsDetails',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              var data = state.extra as Map<String, dynamic>;
              var logi = state.extra as Map<String, dynamic>;
              var lati = state.extra as Map<String, dynamic>;
              return CarsDetailsAvailable(
                id: data['id'],
                longitude: logi['logitude'],
                latitude: lati['latitude'],
              );
            },
          ),
          GoRoute(
            path: 'bookYourCab',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              var data = state.extra as Map<String, dynamic>;
              var userId = state.extra as Map<String, dynamic>;
              var bookDate = state.extra as Map<String, dynamic>;
              var logi = state.extra as Map<String, dynamic>;
              var lati = state.extra as Map<String, dynamic>;
              var totalAmt = state.extra as Map<String, dynamic>;
              return BookYourCab(
                carType: data['carType'],
                userId: userId['userId'],
                bookingDate: bookDate['bookdate'],
                totalAmt: totalAmt['totalAmt'],
                latitude: logi['longitude'],
                logitude: lati['latitude'],
              );
            },
          ),
          GoRoute(
            path: 'guestBooking',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              var date = state.extra as Map<String, dynamic>;
              var pickUpLocation = state.extra as Map<String, dynamic>;
              var price = state.extra as Map<String, dynamic>;
              var hour = state.extra as Map<String, dynamic>;
              var carType = state.extra as Map<String, dynamic>;
              var bookerId = state.extra as Map<String, dynamic>;
              var kilometer = state.extra as Map<String, dynamic>;
              var pickUpTime = state.extra as Map<String, dynamic>;
              var longitude = state.extra as Map<String, dynamic>;
              var latitude = state.extra as Map<String, dynamic>;
              var offerCode = state.extra as Map<String, dynamic>;
              var discountAmount = state.extra as Map<String, dynamic>;
              var taxAmount = state.extra as Map<String, dynamic>;
              var taxPercentage = state.extra as Map<String, dynamic>;

              var payableAmount = state.extra as Map<String, dynamic>;
              // final List guestData = data[''] ?? [];
              return GuestRentalBookingForm(
                // data: {},
                date: date['date'],
                pickUpLocation: pickUpLocation['pickUpLocation'],
                price: price['price'],
                hour: hour['hour'],
                carType: carType['carType'],
                bookerId: bookerId['bookerId'],
                kilometer: kilometer['kilometer'],
                pickUpTime: pickUpTime['pickUpTime'],
                longi: longitude['longi'],
                lati: latitude['lati'],
                offerCode: offerCode['offerCode'],
                discountAmount: discountAmount['discountAmount'],
                taxAmount: taxAmount["taxAmount"],
                taxPercentage: taxPercentage["taxPercentage"],
                payableAmount: payableAmount['payableAmount'],
              );
            },
          ),
          GoRoute(
            path: 'rentalCarBooking',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              var data = state.extra as Map<String, dynamic>;
              // var longitude = state.extra as Map<String, dynamic>;
              // var latitude = state.extra as Map<String, dynamic>;
              return RentalCarBooking(
                data: data['myId'],
                // lati: latitude['lati'],logi: longitude['logi'],
              );
            },
          ),
          GoRoute(
            path: 'rentalHistory',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              var data = state.extra as Map<String, dynamic>;
              return RentalHistoryManagment(
                myId: data['myIdNo'],
              );
            },
          ),
          GoRoute(
            path: 'rentalBookedPageView',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              var data = state.extra as Map<String, dynamic>;
              var uid = state.extra as Map<String, dynamic>;
              var paymentId = state.extra as Map<String, dynamic>;
              return RentalBookedPageView(
                bookedId: data["bookedId"].toString(),
                useriD: uid['useriD'],
                paymentId: paymentId['paymentId'],
              );
            },
          ),
          GoRoute(
            path: 'rentalCancelledPageView',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              var data = state.extra as Map<String, dynamic>;
              return RentalCancelledPageView(
                cancelledId: data["cancelledId"].toString(),
              );
            },
          ),
        ]),

    //       GoRoute(
    //           path: 'selectItem',
    //           parentNavigatorKey: _rootNavigatorKey,
    //           pageBuilder: (context, state) {
    //             var data = state.extra as Map<String, dynamic>;
    //             return NoTransitionPage(
    //                 child: SelectItem(
    //               selectedItems: data["notifier"],
    //               customer: data["customer"],
    //             ));
    //           }),
  ],
);
//
// extension GoRouterEx on GoRouter {
//   void popUntilPath(BuildContext context, String routePath) {
//     final router = GoRouterState.of(context);
//     while (router.uri.toString() != routePath) {
//       if (!router.canPop()) {
//         return;
//       }
//       debugPrint('Popping ${router.location}');
//       router.pop();
//     }
//   }
// }
