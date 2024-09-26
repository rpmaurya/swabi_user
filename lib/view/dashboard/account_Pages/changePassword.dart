import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:flutter_cab/view_model/userProfile_view_model.dart';
import 'package:flutter_cab/view_model/user_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../res/customAppBar_widget.dart';
import '../../../utils/color.dart';

class ChangePassword extends StatefulWidget {
  final String userId;
  const ChangePassword({super.key, required this.userId});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  UserViewModel userViewModel = UserViewModel();
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _focasNode1 = FocusNode();
  final _focasNode2 = FocusNode();
  final _focasNode3 = FocusNode();

  String? _oldPasswordError;
  String? _newPasswordError;
  String? _confirmPasswordError;

  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  @override
  void initState() {
    super.initState();

    _focasNode1.addListener(() {
      if (!_focasNode1.hasFocus) {
        setState(() {
          _oldPasswordError = _validatePassword(_oldPasswordController.text);
        });
      }
    });

    _focasNode2.addListener(() {
      if (!_focasNode2.hasFocus) {
        setState(() {
          _newPasswordError = _validatePassword(_newPasswordController.text);
        });
      }
    });

    _focasNode3.addListener(() {
      if (!_focasNode3.hasFocus) {
        setState(() {
          if (_confirmPasswordController.text != _newPasswordController.text) {
            _confirmPasswordError = "Passwords do not match";
          } else {
            _confirmPasswordError =
                _validatePassword(_confirmPasswordController.text);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _focasNode1.dispose();
    _focasNode2.dispose();
    _focasNode3.dispose();
    super.dispose();
  }

  void _toggleOldPasswordVisibility() {
    setState(() {
      _obscureOldPassword = !_obscureOldPassword;
    });
  }

  void _toggleNewPasswordVisibility() {
    setState(() {
      _obscureNewPassword = !_obscureNewPassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (_confirmPasswordController.text.isEmpty) {
      return 'Please enter confirm password';
    } else if (value != _newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _updatePassword() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> query = {
        "userId": widget.userId,
        "oldPassword": _oldPasswordController.text,
        "newPassword": _newPasswordController.text
      };

      // Proceed with password update logic
      try {
        Provider.of<ChangePasswordViewModel>(context, listen: false)
            .changePasswordViewModelApi(context: context, query: query)
            .then((onValue) {
          if (onValue?.status.httpCode == '200') {
            Utils.flushBarSuccessMessage(
                'Password changed successfully', context);
            context.pop();
          }
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGreyColor,
      appBar: const CustomAppBar(
        heading: "Change Password",
      ),
      body: PageLayout_Page(
          child: SingleChildScrollView(
        child: Form(
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Center(child: Image.asset(appLogo1)),
                // child: Center(child: Image.asset(appLogo1)),
              ),
              customtextformfield(
                  focusNode: _focasNode1,
                  controller: _oldPasswordController,
                  obscureText: _obscureOldPassword,
                  hinttext: 'Old Password',
                  errorText: _oldPasswordError,
                  onIconPress: _toggleOldPasswordVisibility,
                  validator: _validatePassword),
              const SizedBox(height: 16.0),
              customtextformfield(
                  focusNode: _focasNode2,
                  controller: _newPasswordController,
                  obscureText: _obscureNewPassword,
                  hinttext: 'New Password',
                  errorText: _newPasswordError,
                  onIconPress: _toggleNewPasswordVisibility,
                  validator: _validatePassword),

              const SizedBox(height: 16.0),
              customtextformfield(
                  focusNode: _focasNode3,
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  hinttext: 'Confirm New Password',
                  errorText: _confirmPasswordError,
                  onIconPress: _toggleConfirmPasswordVisibility,
                  validator: _validateConfirmPassword),
              const SizedBox(height: 20),

              // LoginTextFeild(
              //   headingReq: true,
              //   controller: TextEditingController(),
              //   hint: "Enter your old password",
              //   suffixIcon: true,
              //   obscure: true,
              //   prefixIcon: true,
              //   img: pass,
              //   heading: "Old Password",
              // ),
              // const SizedBox(height: 10),
              // LoginTextFeild(
              //   headingReq: true,
              //   controller: TextEditingController(),
              //   hint: "Enter your new password",
              //   suffixIcon: true,
              //   obscure: true,
              //   prefixIcon: true,
              //   img: pass,
              //   heading: "New Password",
              // ),
              // const SizedBox(height: 10),
              // LoginTextFeild(
              //   headingReq: true,
              //   controller: TextEditingController(),
              //   hint: "Enter your confirm password",
              //   suffixIcon: true,
              //   obscure: true,
              //   prefixIcon: true,
              //   img: pass,
              //   heading: "Confirm New Password",
              // ),
              // const Spacer(),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Container(
              //       child: TextButton(
              //         onPressed: () {
              //           // userViewModel.remove(context);
              //           context.push('/forgotPassword');
              //           // Navigator.push(
              //           //     context,
              //           //     MaterialPageRoute(
              //           //         builder: (context) => ForgotPassword()));
              //         },
              //         child: Text('Forgot your password?',
              //             style: GoogleFonts.lato(
              //                 fontWeight: FontWeight.w700,
              //                 color: Colors.green)),
              //       ),
              //     ),
              //   ],
              // ),
              CustomButtonBig(
                btnHeading: "Change Password",
                onTap: () => _updatePassword(),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      )),
    );
  }

  Widget customtextformfield(
      {TextEditingController? controller,
      required bool obscureText,
      required String hinttext,
      required void Function()? onIconPress,
      String? Function(String?)? validator,
      FocusNode? focusNode,
      String? errorText}) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        // labelText: 'Old Password',
        fillColor: Colors.white,
        filled: true,
        errorText: errorText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        // border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Color(0xFFCDCDCD),
            // width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Color(0xFFCDCDCD),
            // width: 2.0,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Color(0xFFCDCDCD),
            // width: 2.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Color(0xFFCDCDCD),
            // width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: Color(0xFFCDCDCD),
            // width: 2.0,
          ),
        ),

        hintText: hinttext,
        // prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: onIconPress,
        ),
      ),
      validator: validator,
    );
  }
}
