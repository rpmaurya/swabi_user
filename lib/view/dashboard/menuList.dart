import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/custom_ListTile.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/view_model/userProfile_view_model.dart';
import 'package:flutter_cab/view_model/user_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuList extends StatefulWidget {
  final String userId;

  const MenuList({super.key, required this.userId});

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  bool noti = false;

  UserViewModel userViewModel = UserViewModel();

  @override
  void initState() {
    super.initState();
    _loadNotiValue();
  }

  // Load the saved noti value from SharedPreferences
  Future<void> _loadNotiValue() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      noti = prefs.getBool('noti') ?? false;
    });
  }

  // Save the noti value to SharedPreferences
  Future<void> _saveNotiValue(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('noti', value);
  }
  @override
  Widget build(BuildContext context) {
    debugPrint("${noti}Data of Notification");
    debugPrint("${widget.userId}Data of UserId");

    return Scaffold(
      backgroundColor: bgGreyColor,
      appBar: const CustomAppBar(
        heading: "Account",
      ),
      body: PageLayout_Page(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
          // padding: EdgeInsets.only(bottom: 20),
          children: [
            // const SizedBox(height: 5),
            Custom_ListTile(
              img: profile,
              heading: "Profile",
              // onTap: () => context.push("/profilePage",extra: {"userId":widget.userId}),
              onTap: () {
                Provider.of<UserProfileViewModel>(context, listen: false)
                    .fetchUserProfileViewModelApi(
                    context, {"userId": widget.userId});
                context.push("/profilePage",extra: {"userId":widget.userId});
              },
            ),
            Custom_ListTile(
              img: distance,
              heading: "My Trip",
              onTap: () => context.push("/rentalForm/rentalHistory",extra: {"myIdNo": widget.userId}),
              // context.push("/booking")
            ),
            Custom_ListTile(
              img: package,
              heading: "My Package",
              onTap: () => context.push("/package/packageHistoryManagement",extra: {"userID":widget.userId}),                // context.push("/booking")
            ),
            // Custom_ListTile(
            //   img: card,
            //   heading: "Cards Details",
            //   onTap: () => context.push("/myCards"),
            // ),
            // Custom_ListTile(
            //   img: transaction,
            //   heading: "Transaction",
            //   onTap: () => context.push("/myTransaction"),
            // ),
            // Custom_ListTile(
            //   img: settingimg,
            //   heading: "Settings",
            //   onTap: () => context.push("/setting"),
            // ),
            // Custom_ListTileSwitch(
            //   img: notification,
            //   heading: "Notification",
            //   notification: FlutterSwitch(
            //     width: 60,
            //     height: 32,
            //     activeColor: Colors.green,
            //     toggleSize: 22,
            //     // switchBorder: Border.all(color: naturalGreyColor.withOpacity(0.3)),
            //     inactiveColor: naturalGreyColor.withOpacity(0.3),
            //     value: noti,
            //     onToggle: (value) {
            //       setState(() {
            //         noti = value;
            //       });
            //       _saveNotiValue(value);
            //     },
            //   ),
            // ),
            Custom_ListTile(
              img: tnc,
              heading: "Terms & Condition",
              onTap: () => context.push("/termCondition"),
            ),
            Custom_ListTile(
              img: contact,
              heading: "Contact",
              onTap: () => context.push("/contact"),
            ),
            Custom_ListTile(
              img: faq,
              heading: "FAQ",
              onTap: () => context.push("/faqPage"),
            ),
            const Spacer(),
            CustomButtonLogout(
                img: logout,
                btnHeading: "Logout",
                loading: userViewModel.loading,
                onTap: () {
                  userViewModel.remove(context);
                  context.go("/login");
                }),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 10),
            //   child: SizedBox(
            //    height: 40,
            //    child: Image.asset(appLogo),
            //                 ),
            // )
          ],
        ),
      )
    );
  }
}
