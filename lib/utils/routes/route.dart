// routes.dart

import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/booking.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/cardPage.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/changePassword.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/contact.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/faqPage.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/help&support.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/notification.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/profilePage.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/raiseIssueDetails.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/term_condition.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/transaction.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/verifyPassword.dart';
import 'package:flutter_cab/view/dashboard/home_screen.dart';
import 'package:flutter_cab/view/dashboard/menuList.dart';
import 'package:flutter_cab/view/dashboard/raiseIssue_pages/issueViewDetails.dart';
import 'package:flutter_cab/view/dashboard/rental/bookYourCab.dart';
import 'package:flutter_cab/view/dashboard/rental/carBooking.dart';
import 'package:flutter_cab/view/dashboard/rental/carsDetails.dart';
import 'package:flutter_cab/view/dashboard/rental/guestRentalBookingForm.dart';
import 'package:flutter_cab/view/dashboard/rental/happyBookingScreen.dart';
import 'package:flutter_cab/view/dashboard/rental/history/rentalBookedPageView.dart';
import 'package:flutter_cab/view/dashboard/rental/history/rentalCancelPageView.dart';
import 'package:flutter_cab/view/dashboard/rental/history/rentalHistoryManagment.dart';
import 'package:flutter_cab/view/dashboard/rental/rentalForm.dart';
import 'package:flutter_cab/view/dashboard/tourPackage/addMemberDesign.dart';
import 'package:flutter_cab/view/dashboard/tourPackage/package.dart';
import 'package:flutter_cab/view/dashboard/tourPackage/packageBookingMember.dart';
import 'package:flutter_cab/view/dashboard/tourPackage/packageDetails.dart';
import 'package:flutter_cab/view/dashboard/tourPackage/packageHistory/packageHistoryManagment.dart';
import 'package:flutter_cab/view/dashboard/tourPackage/tourPackageForm.dart';
import 'package:flutter_cab/view/one_way_trip.dart';
import 'package:flutter_cab/view/dashboard/account_Pages/editProfile.dart';
import 'package:flutter_cab/view/registration/login_screen.dart';
import 'package:flutter_cab/view/registration/registration_screen.dart';
import 'package:flutter_cab/view/registration/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../../view/dashboard/tourPackage/packageHistory/package_PageViewDetails.dart';

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
    GoRoute(
      path: '/oneWayTrip',
      builder: (BuildContext context, GoRouterState state) {
        return const one_way_trip();
      },
    ),
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
          child: MenuList(userId: data['id']),
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
      path: '/myTransaction',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const MyTransaction();
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
          GoRoute(
            path: 'tourPackage',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              return const TourPackage();
            },
          ),
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
          GoRoute(
            path: 'packageMember',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              // final pkgId = state.extra as Map<String, dynamic>;
              // final usrId = state.extra as Map<String, dynamic>;
              // final amt = state.extra as Map<String, dynamic>;
              // final bookingDate = state.extra as Map<String, dynamic>;
              return const PackageBooking();
            },
          ),

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
              return PackagePageViewDetails(
                userId: userID['user'],
                packageBookID: bookID['book'],
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
              // var amt = state.extra as Map<String, dynamic>;
              return BookYourCab(
                carType: data['carType'],
                userId: userId['userId'],
                bookingDate: bookDate['bookdate'],
                // totalAmt: amt['totalAmt'],
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
              return RentalBookedPageView(
                bookedId: data["bookedId"].toString(),
                useriD: uid['useriD'],
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
