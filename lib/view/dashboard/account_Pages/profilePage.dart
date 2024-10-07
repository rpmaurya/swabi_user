import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cab/data/network/network_apiservice.dart';
import 'package:flutter_cab/model/user_profile_model.dart';
import 'package:flutter_cab/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_cab/res/Custom%20Page%20Layout/commonPage_Layout.dart';
import 'package:flutter_cab/res/customAppBar_widget.dart';
import 'package:flutter_cab/res/custom_ListTile.dart';
import 'package:flutter_cab/res/login/login_customTextFeild.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';
import 'package:flutter_cab/utils/dimensions.dart';
import 'package:flutter_cab/utils/string_extenstion.dart';
import 'package:flutter_cab/utils/text_styles.dart';
import 'package:flutter_cab/view_model/userProfile_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as img;

class ProfilePage extends StatefulWidget {
  final String user;

  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? imgFile;
  final profileImg = ImagePicker();

  UserProfileViewModel userProfileViewModel = UserProfileViewModel();

  NetworkApiService networkApiService = NetworkApiService();

  String dataUser = '';

  // void openGallery() async {
  //   try {
  //     var imgGallery = await profileImg.pickImage(source: ImageSource.gallery);
  //
  //     if (imgGallery != null) {
  //       setState(() {
  //         imgFile = File(imgGallery.path);
  //       });
  //     }
  //     Navigator.of(context).pop();
  //   } catch (e) {
  //     print('Error opening gallery: $e');
  //     // Handle the error appropriately
  //   }
  // }
  //
  // void openCamera() async {
  //   try {
  //     var imgCamera = await profileImg.pickImage(
  //         source: ImageSource.camera, imageQuality: 50);
  //
  //     if (imgCamera != null) {
  //       setState(() {
  //         imgFile = File(imgCamera.path);
  //       });
  //       Navigator.of(context).pop();
  //     } else {
  //       Utils.flushBarSuccessMessage("Something went wrong", context);
  //     }
  //   } catch (e) {
  //     print('Error opening camera: $e');
  //     // Handle the error appropriately
  //   }
  // }
  ///Old Code
  void openGallery() async {
    var imgGallery = await profileImg.pickImage(source: ImageSource.gallery);

    ///Call api
    setState(() {
      imgFile = File(imgGallery!.path);
      debugPrint("${imgFile!.path}Gallery");
    });
    File resizedFile = await resizeImage(imgFile!);
    debugPrint("${resizedFile.path}Gallery.....,.,,,");
    if (imgFile != null) {
      // debugPrint("chli");
      await Provider.of<ProfileImageViewModel>(context, listen: false)
          .postProfileImageApi(context, {
        "userId": widget.user,
        "image": resizedFile,
      });
    }
    Navigator.of(context).pop();
  }

  void openCamera() async {
    var imgCamera = await profileImg.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      imgFile = File(imgCamera!.path);
      debugPrint(imgFile!.path.toString());
    });
    File resizedFile = await resizeImage(imgFile!);
    debugPrint("${resizedFile.path}Gallery.....,.,,,");
    if (imgFile != null) {
      // debugPrint("chli");
      await Provider.of<ProfileImageViewModel>(context, listen: false)
          .postProfileImageApi(
              context, {"userId": widget.user, "image": resizedFile});
    }
    Navigator.of(context).pop();
  }

  /// Helper function to resize the image
  Future<File> resizeImage(File imageFile) async {
    final img.Image? image = img.decodeImage(imageFile.readAsBytesSync());

    // Resize the image to a smaller size (e.g., 300px width)
    final resizedImage = img.copyResize(image!, width: 300);

    // Save the resized image to a file
    final resizedFile = File(imageFile.path)
      ..writeAsBytesSync(img.encodeJpg(resizedImage, quality: 85));

    return resizedFile;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataUser = widget.user;
    print({'dfaghjhjh': dataUser});
  }

  var userId;

  ProfileData userdata = ProfileData();
  var userImg;

  @override
  Widget build(BuildContext context) {
    // debugPrint(dataUser);
    var status =
        context.watch<UserProfileViewModel>().DataList.status.toString();
    // if(status == "Status.completed"){
    userdata = context.watch<UserProfileViewModel>().DataList.data?.data ??
        ProfileData();
    // userdata = context.watch<UserProfileViewModel>().DataList.data?.data ?? ProfileData();
    // print(userdata.address);
    userImg = context
            .watch<UserProfileViewModel>()
            .DataList
            .data
            ?.data
            .profileImageUrl ??
        '';
    return Scaffold(
      backgroundColor: bgGreyColor,
      appBar: CustomAppBar(
        heading: "Profile",
        rightIconOnTapReq: true,
        rightIconImage: edit,
        trailingIcon: true,
        rightIconOnTapOnTap: () => context
            .push("/profilePage/editProfilePage", extra: {'uId': dataUser}),
      ),
      body: PageLayout_Page(
          bgColor: bgGreyColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProfileContainer(
                  onTap: () => showCameraOption(),
                  imgPath: imgFile ??
                      (userImg.toString().isNotEmpty ? userImg : profile),
                ),
                CommonTextFeild(
                  heading: "Customer Id",
                  headingReq: true,
                  initiValueReq: false,
                  controller: TextEditingController(text: widget.user),
                  initialValueText: widget.user ?? '',
                  prefixIcon: true,
                  readOnly: true,
                  img: profile,
                ),
                const SizedBox(height: 10),
                CommonTextFeild(
                  heading: "Full Name",
                  headingReq: true,
                  initiValueReq: false,
                  controller: TextEditingController(
                      text:
                          "${userdata.firstName ?? ''} ${userdata.lastName ?? ''}"
                              .toString()
                              .capitalizeFirstOfEach),
                  initialValueText:
                      "${userdata.firstName ?? ''} ${userdata.lastName ?? ''}",
                  prefixIcon: true,
                  readOnly: true,
                  img: profile,
                ),
                const SizedBox(height: 10),
                CommonTextFeild(
                  heading: "Email",
                  headingReq: true,
                  initiValueReq: false,
                  controller: TextEditingController(text: userdata.email),
                  initialValueText: userdata.email ?? '',
                  prefixIcon: true,
                  readOnly: true,
                  img: email,
                ),
                const SizedBox(height: 10),
                CommonTextFeild(
                  heading: "Gender",
                  headingReq: true,
                  prefixIcon: true,
                  initiValueReq: false,
                  controller: TextEditingController(text: userdata.gender),
                  initialValueText: userdata.gender ?? '',
                  readOnly: true,
                  img: genderImg,
                ),
                const SizedBox(height: 10),
                CommonTextFeild(
                  heading: "Address",
                  headingReq: true,
                  prefixIcon: true,
                  initiValueReq: false,
                  controller: TextEditingController(text: userdata.address),
                  initialValueText: userdata.address ?? '',
                  readOnly: true,
                  img: address,
                ),
                const SizedBox(height: 10),
                CommonTextFeild(
                  heading: "Contact No",
                  headingReq: true,
                  prefixIcon: true,
                  initiValueReq: false,
                  controller: TextEditingController(
                      text: "+${userdata.countryCode} ${userdata.mobile}"),
                  initialValueText: userdata.mobile ?? '',
                  readOnly: true,
                  img: phone,
                ),
                const SizedBox(height: 10),
                Custom_ListTile(
                  headingTitleReq: true,
                  headingTitle: "Change Password",
                  onTap: () => context
                      .push("/changePassword", extra: {"userId": dataUser}),
                  heading: "**********",
                  img: pass,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: CustomButtonSmall(
                //       btnHeading: 'CHANGE PASSWORD', onTap: () {}),
                // )
              ],
            ),
          )),
    );
  }

  showCameraOption() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Container(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 200,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          height: 3,
                          width: 50,
                          color: Colors.grey[400],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Profile Picture',
                            style: titleTextStyle,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(color: Colors.grey),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          onPressed: openCamera,
                          // () => getImage(ImageSource.camera),
                          child: Text(
                            'Camera',
                            style: titleTextStyle,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          onPressed: openGallery,
                          // () => getImage(ImageSource.gallery),
                          child: Text(
                            'Gallery',
                            style: titleTextStyle,
                            // style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProfileContainer extends StatelessWidget {
  final dynamic imgPath;
  final VoidCallback onTap;
  final String name;

  const ProfileContainer(
      {required this.onTap, this.imgPath = profile, this.name = "", super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: AppDimension.getWidth(context) * .3,
          height: AppDimension.getHeight(context) * .2,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: curvePageColor,
          ),
          child: imgPath.runtimeType != String
              ? Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: FileImage(imgPath), fit: BoxFit.cover)),
                )
              : imgPath.toString().contains("http")
                  ? Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  // AppUrl.userProfileUpdate +
                                  imgPath),
                              // image: AssetImage(imgPath),
                              fit: BoxFit.fill)))
                  : Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                                  // AppUrl.userProfileUpdate +
                                  imgPath),
                              // image: AssetImage(imgPath),
                              fit: BoxFit.cover))),
        ),
        Positioned(
          bottom: 20,
          right: 0,
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: onTap,
            child: const Card(
              elevation: 0,
              shape: CircleBorder(),
              color: btnColor,
              child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: background,
                  )),
            ),
          ),
        )
      ],
    );
  }
}
