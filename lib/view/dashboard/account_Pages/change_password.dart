import 'package:flutter/material.dart';
import 'package:flutter_cab/data/validatorclass.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/Custom%20Widgets/custom_textformfield.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/text_styles.dart';
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

    // _focasNode1.addListener(() {
    //   if (!_focasNode1.hasFocus) {
    //     setState(() {
    //       _oldPasswordError = _validatePassword(_oldPasswordController.text);
    //     });
    //   }
    // });

    // _focasNode2.addListener(() {
    //   if (!_focasNode2.hasFocus) {
    //     setState(() {
    //       _newPasswordError = _validatePassword(_newPasswordController.text);
    //     });
    //   }
    // });

    // _focasNode3.addListener(() {
    //   if (!_focasNode3.hasFocus) {
    //     setState(() {
    //       if (_confirmPasswordController.text != _newPasswordController.text) {
    //         _confirmPasswordError = "Passwords do not match";
    //       } else {
    //         _confirmPasswordError =
    //             _validatePassword(_confirmPasswordController.text);
    //       }
    //     });
    //   }
    // });
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
            Utils.toastSuccessMessage(
              'Password changed successfully',
            );
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
    // return Scaffold(
    //   backgroundColor: bgGreyColor,
    //   appBar: const CustomAppBar(
    //     heading: "Change Password",
    //   ),
    //   body: PageLayout_Page(
    //       child: SingleChildScrollView(
    //     child:

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Change password',
                  style: buttonText,
                ),
                InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: SizedBox(
                    height: 35,
                    width: 35,
                    child: Text(
                      'X',
                      textAlign: TextAlign.end,
                      style: buttonText,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 50),
            //   child: Center(child: Image.asset(appLogo1)),
            //   // child: Center(child: Image.asset(appLogo1)),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 5),
            //   child: Text.rich(TextSpan(children: [
            //     TextSpan(text: 'Current Password', style: titleTextStyle),
            //     const TextSpan(text: ' *', style: TextStyle(color: redColor))
            //   ])),
            // ),
            Customtextformfield(
              fillColor: background,
              obscureText: !_obscureOldPassword,
              // obscuringCharacter: '*',
              controller: _oldPasswordController,
              enableInteractiveSelection: _obscureOldPassword,
              hintText: 'Enter current password',
              suffixIcons: IconButton(
                icon: Icon(
                  _obscureOldPassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureOldPassword = !_obscureOldPassword;
                  });
                },
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter current password';
                }
                return null;
              },
            ),
            const SizedBox(height: 10.0),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 5),
            //   child: Text.rich(TextSpan(children: [
            //     TextSpan(text: 'New Password', style: titleTextStyle),
            //     const TextSpan(text: ' *', style: TextStyle(color: redColor))
            //   ])),
            // ),
            Customtextformfield(
              fillColor: background,
              obscureText: !_obscureNewPassword,
              // obscuringCharacter: '*',
              enableInteractiveSelection: _obscureNewPassword,
              controller: _newPasswordController,
              hintText: 'Enter new password',
              suffixIcons: IconButton(
                icon: Icon(
                  _obscureNewPassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureNewPassword = !_obscureNewPassword;
                  });
                },
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter new password';
                } else {
                  return Validatorclass.validatePassword(value);
                }
              },
            ),
            const SizedBox(height: 10.0),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 5),
            //   child: Text.rich(TextSpan(children: [
            //     TextSpan(text: 'Confirm Password', style: titleTextStyle),
            //     const TextSpan(text: ' *', style: TextStyle(color: redColor))
            //   ])),
            // ),
            Customtextformfield(
              fillColor: background,
              obscureText: !_obscureConfirmPassword,
              // obscuringCharacter: '*',
              enableInteractiveSelection: _obscureConfirmPassword,
              controller: _confirmPasswordController,
              hintText: 'Enter confirm new password',
              suffixIcons: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter confirm new password';
                } else if (value != _newPasswordController.text) {
                  return "Password do not match";
                } else {
                  return Validatorclass.validatePassword(value);
                }
              },
            ),
            const SizedBox(height: 20),
            // Spacer(),
            CustomButtonBig(
              btnHeading: "Submit",
              onTap: () => _updatePassword(),
            ),
            // const SizedBox(height: 10),
          ],
        ),
      ),
    );
    // )),
    // );
  }
}
