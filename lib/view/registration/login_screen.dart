import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/res/login/login_customTextFeild.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:flutter_cab/view_model/auth_view_model.dart';
// import 'package:flutter_cab/viewpages/dashboard_sreen.dart';

import 'package:go_router/go_router.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String usr = '';
  String pass = '';
  bool value = false;
  bool _rememberMe = false;
  List<TextEditingController> controller =
      List.generate(2, (index) => TextEditingController());
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    savecredential();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   controller[0].dispose();
  //   controller[1].dispose();
  // }
  savecredential() async {
    final prefsData = await SharedPreferences.getInstance();
    List<String>? items = prefsData.getStringList('saveCredential');
    if (items != null && items.length >= 2) {
      setState(() {
        usr = items[0].toString();
        pass = items[1].toString();
      });
    } else {
      // Handle the case where 'saveCredential' is not set or doesn't have enough data
      print("No credentials found or incomplete data");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller[0].dispose();
    controller[1].dispose();
    focusNode1.dispose();
    focusNode2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);
    // String message = Provider.of<AuthViewModel>();
    return Scaffold(
      backgroundColor: bgGreyColor,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Center(child: Image.asset(appLogo1)),
                    // child: Center(child: Image.asset(appLogo1)),
                  ),
                  const CustomTextWidget(
                      content: "WELCOME!\nPlease sign in to your account",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      maxline: 2,
                      align: TextAlign.start,
                      textColor: textColor),
                  const SizedBox(height: 4),

                  ///Login Field
                  LoginTextFeild(
                    focusNode: focusNode1,
                    headingReq: true,
                    controller: controller[0]..text = usr.toString(),
                    img: email,
                    hint: "Enter your email",
                    heading: "Enter your Email",
                  ),
                  const SizedBox(height: 8),
                  LoginTextFeild(
                    focusNode: focusNode2,
                    headingReq: true,
                    controller: controller[1]..text = pass.toString(),
                    obscure: true,
                    suffixIcon: true,
                    img: email,
                    hint: "Enter your password",
                    heading: "Enter your Password",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (bool? value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                      ),
                      Expanded(
                          child: Text('Remember Me',
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black))),
                      Container(
                        child: TextButton(
                          onPressed: () {
                            context.push('/forgotPassword');
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ForgotPassword()));
                          },
                          child: Text('Forgot your password?',
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green)),
                        ),
                      ),
                    ],
                  ),
                  CustomButtonBig(
                    btnHeading: "Sign in",
                    loading: authViewMode.loading,
                    onTap: () {
                      if (controller[0].text.isEmpty) {
                        Utils.flushBarErrorMessage(
                            "Enter valid Email Id", context);
                      } else if (controller[1].text.isEmpty) {
                        Utils.flushBarErrorMessage(
                            "Enter valid Password", context);
                      } else {
                        Map<String, String> data = {
                          'email': controller[0].text.toString(),
                          'password': controller[1].text.toString(),
                          'userType': 'USER'
                        };
                        authViewMode.loginApi(data, context);
                      }
                      // context.push('/');
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Login_SignUpBtn(
                    onTap: () => context.push("/signup"),
                    btnHeading: 'Signup',
                    sideHeading: " Don't have an account ? ",
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
