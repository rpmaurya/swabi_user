import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/res/custom_Textfeild.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/view/registration/login_screen.dart';
import 'package:flutter_cab/view/registration/otp_verification_screen.dart';

// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  TextEditingController forgetPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return PageLayout_Page(
        child: SingleChildScrollView(
          child: Column(children: [
                Padding(
          padding: EdgeInsets.only(top: AppDimension.getHeight(context)/6 ),
          child:
          Center(child: Image.asset('assets/images/Asset 233000 1.png')),
                ),
                const SizedBox(
          height: 30,
                ),
                const Text(
          'Forgot Password',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text('Enter your email to reset your password'),
                Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    content: 'Enter your Email',
                    // style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                    child: ValidationForm()
                    // TextFormField(
                    //   controller: email,
                    //   decoration: InputDecoration(
                    //     // hintText: 'Enter your phone',
                    //       contentPadding: const EdgeInsets.symmetric(
                    //           vertical: 10.0, horizontal: 10.0),
                    //       filled: true,
                    //       fillColor: const Color.fromRGBO(255, 255, 255, 1),
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(5),
                    //           borderSide: BorderSide.none)),
                    //   keyboardType: TextInputType.emailAddress,
                    //   validator: (value) {
                    //     const pattern =
                    //         r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                    //         r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                    //         r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                    //         r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                    //         r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                    //         r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                    //         r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                    //     final regex = RegExp(pattern);
                    //     if (value == null || value.isEmpty) {
                    //       return 'Enter valid email';
                    //     } else if (!regex.hasMatch(value)) {
                    //       return 'Enter a valid email address';
                    //     }
                    //     return null;
                    //   },
                    // ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 56,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: const MaterialStatePropertyAll(
                              Color.fromRGBO(123, 30, 52, 1)),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11)))),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Otp sent your email')));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const OtpVerificationScreen()));
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Remember your password?'),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: Text(
                            'Login',
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.w700,
                                color: const Color.fromRGBO(69, 30, 243, 1)),
                          ))
                    ],
                  )
                ],
              )),
                ),
              ]),
        ));
  }
}
