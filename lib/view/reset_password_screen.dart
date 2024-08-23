import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cab/view/registration/login_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(234, 233, 226, 1),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child:
                Center(child: Image.asset('assets/images/Asset 233000 1.png')),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Reset Password',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter new password',
                      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      child:
                      TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(8),
                        ],
                        controller: password,
                        decoration: InputDecoration(

                            // hintText: 'Enter your password',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            filled: true,
                            fillColor: const Color.fromRGBO(255, 255, 255, 1),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none)),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        obscuringCharacter: '*',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter valid password';
                          } //else if (!regexPassword.hasMatch(value)) {
                          //   return "hggvvn";
                          // }
                          return null;
                        },
                      ),
                    ),
                    const Text(
                      'Confirm password',
                      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(8),
                        ],
                        controller: confirmpass,
                        decoration: InputDecoration(

                            // hintText: 'Enter your password',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            filled: true,
                            fillColor: const Color.fromRGBO(255, 255, 255, 1),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none)),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        obscuringCharacter: '*',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter valid Confirm password';
                          } else if (value != password.text) {
                            return "password not matched";
                          }
                          return null;
                        },
                      ),
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
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Reset password secusess')));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
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
      ),
    );
  }
}
