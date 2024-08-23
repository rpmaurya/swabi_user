import 'package:flutter/material.dart';
import 'package:flutter_cab/view/reset_password_screen.dart';


// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(234, 233, 226, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 120),
                  child: Center(
                      child: Image.asset('assets/images/Asset 233000 1.png')),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Verify OTP',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Enter the OTP sent to your email',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: PinCodeTextField(
                    keyboardType: TextInputType.number,
                    enableActiveFill: true,
                    cursorColor: Colors.black,
                    appContext: context,
                    length: 6,
                    onChanged: (value) {
                      // Handle changes in the OTP input
                      print(value);
                    },
                    onCompleted: (value) {
                      // Handle when the user completes entering the OTP
                      print("Completed: $value");
                    },
                    // You can customize the appearance of the input field
                    pinTheme: PinTheme(
                        borderWidth: 1,
                        activeBorderWidth: 1,
                        inactiveBorderWidth: 1,
                        selectedFillColor: Colors.white,
                        shape: PinCodeFieldShape.box,
                        inactiveFillColor: Colors.white,
                        activeFillColor: Colors.white,
                        inactiveColor: Colors.grey,
                        activeColor: const Color.fromRGBO(0, 0, 0, 0.5),
                        borderRadius: BorderRadius.circular(10)),
                    controller: _otpController,
                    // Validator function for OTP
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the OTP';
                      }
                      if (value.length != 6) {
                        return 'OTP must be 6 digits long';
                      }
                      // You can add more custom validation here if needed
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll(
                            Color.fromRGBO(123, 30, 52, 1)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11)))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ResetPasswordScreen()));
                      }
                    },
                    child: const Text(
                      'Verify Otp',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Didn't receive the code?",
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 10),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(onPressed: () {}, child: const Text('Resend Otp'))
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
