import 'package:flutter/material.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/utils/utils.dart';
import 'package:flutter_cab/view_model/raiseIssue_view_model.dart';
import 'package:flutter_cab/view_model/user_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RaiseIssueDialog extends StatefulWidget {
  final String bookingId;
  final String bookingType;
  // final String raisedById;
  const RaiseIssueDialog({
    super.key,
    required this.bookingId,
    required this.bookingType,
    // required this.raisedById
  });

  @override
  // ignore: library_private_types_in_public_api
  _RaiseIssueDialogState createState() => _RaiseIssueDialogState();
}

class _RaiseIssueDialogState extends State<RaiseIssueDialog> {
  UserViewModel userViewModel = UserViewModel();

  String? _selectedIssue;
  TextEditingController _descriptionController = TextEditingController();
  final List<String> _issueOptions = [
    'Expected a shorter wait time',
    'Unable to contact driver',
    'Driver denied duty',
    'Cab is not moving in my direction',
    'My reason is not listed',
  ];
  String? userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      userViewModel.getUserId().then((value) async {
        setState(() {
          if (value.userId != null && value.userId != '') {
            userId = value.userId.toString();
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      surfaceTintColor: background,
      backgroundColor: background,
      contentPadding: const EdgeInsets.all(10),
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Raise Issue', style: pageHeadingTextStyle),
          CustomButtonSmall(
              width: 30,
              height: 30,
              btnHeading: 'X',
              onTap: () {
                context.pop();
              }),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: _issueOptions.map((issue) {
                return RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  activeColor: btnColor,
                  title: Text(issue),
                  value: issue,
                  groupValue: _selectedIssue,
                  onChanged: (value) {
                    setState(() {
                      _selectedIssue = value;
                    });
                  },
                );
              }).toList(),
            ),
            if (_selectedIssue == 'My reason is not listed')
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _descriptionController,
                      maxLength: 120,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: "Description For Issue",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: Text(
                    //     '(${_descriptionController.text.length}/120)',
                    //     style: TextStyle(fontSize: 12),
                    //   ),
                    // ),
                  ],
                ),
              ),
          ],
        ),
      ),
      actions: [
        CustomButtonSmall(
            width: 120,
            height: 40,
            btnHeading: 'Submit',
            onTap: () {
              if (_selectedIssue != null) {
                // Handle submit action
                print('Issue Selected: $_selectedIssue');
                if (_selectedIssue == 'My reason is not listed') {
                  print('Description: ${_descriptionController.text}');
                }

                Provider.of<RaiseissueViewModel>(context, listen: false)
                    .requestRaiseIssue(
                        context: context,
                        bookingId: widget.bookingId,
                        bookingType: widget.bookingType,
                        raisedById: userId.toString(),
                        issueDescription:
                            _selectedIssue == 'My reason is not listed'
                                ? _descriptionController.text
                                : _selectedIssue ?? '');
                Utils.toastSuccessMessage(
                  'Raise Request Successfully',
                );
                Navigator.of(context).pop();
              }
            }),
      ],
    );
  }
}
