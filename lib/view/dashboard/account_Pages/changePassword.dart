import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/login/login_customTextFeild.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:flutter_cab/view_model/userProfile_view_model.dart';
import 'package:go_router/go_router.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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
    if (value != _newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _updatePassword() {
    if (_formKey.currentState?.validate() ?? false) {
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
          child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          children: [
            customtextformfield(
                controller: _oldPasswordController,
                obscureText: _obscureOldPassword,
                hinttext: 'Old Password',
                onIconPress: _toggleOldPasswordVisibility,
                validator: _validatePassword),
            const SizedBox(height: 16.0),
            customtextformfield(
                controller: _newPasswordController,
                obscureText: _obscureNewPassword,
                hinttext: 'New Password',
                onIconPress: _toggleNewPasswordVisibility,
                validator: _validatePassword),

            const SizedBox(height: 16.0),
            customtextformfield(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                hinttext: 'Confirm New Password',
                onIconPress: _toggleConfirmPasswordVisibility,
                validator: _validateConfirmPassword),

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
            const Spacer(),
            CustomButtonBig(
              btnHeading: "Update",
              onTap: () => _updatePassword(),
            ),
            const SizedBox(height: 10),
          ],
        ),
      )),
    );
  }

  Widget customtextformfield(
      {TextEditingController? controller,
      required bool obscureText,
      required String hinttext,
      required void Function()? onIconPress,
      String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        // labelText: 'Old Password',
        fillColor: Colors.white,
        filled: true,

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
        prefixIcon: Icon(Icons.lock),
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
