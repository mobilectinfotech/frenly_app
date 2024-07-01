import 'package:flutter/material.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/core/constants/my_assets.dart';
import 'package:frenly_app/core/constants/my_colour.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
// ignore: unused_import
import 'package:frenly_app/presentation/Blog/blog_edit/blogs_edit_screen.dart';
import 'package:get/get.dart';

import '../presentation/auth/my_profile_view/my_profile_controller.dart';
import '../presentation/chat/Pages/all_frined/all_friends_page.dart';

PreferredSizeWidget customAppbar(
    {required BuildContext context,
    String? title,
    String? imagepath,
    bool? showImage,
    bool? back,
    Function()? onTap,
    bool? editBlogIcon,
    Widget? rightSideWidget}) {

  return PreferredSize(
      preferredSize:
          Size.fromHeight(200.ah), // preferred height for the app bar
      child: SizedBox(
        height: 70.ah,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 10.aw,
            ),
            back == false
                ? Container()
                : InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                        height: 36.ah,
                        width: 40.ah,
                        child: const Icon(Icons.arrow_back_outlined)),
                  ),
            SizedBox(
              width: 16.aw,
            ),
            Text(
              title ?? "caption",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF111111),
                fontSize: 32.adaptSize,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
              ),
            ),
            Spacer(),
            if (showImage ?? false)
              Obx(
                () => CustomImageView(
                  width: 38.adaptSize,
                  height: 38.adaptSize,
                  radius: BorderRadius.circular(36),
                  fit: BoxFit.cover,
                  imagePath:null,
                ),
              ),
            if (rightSideWidget != null) rightSideWidget,
            SizedBox(
              width: 16.aw,
            ),
          ],
        ),
      ));
}

PreferredSizeWidget messageAppbar(
    {required BuildContext context,
    String? title,
    String? imagepath,
    bool? showImage,
    bool? back}) {
  return PreferredSize(
      preferredSize:
          Size.fromHeight(200.ah), // preferred height for the app bar
      child: SizedBox(
        height: 70.ah,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 10.aw,
            ),
            back == false
                ? Container()
                : InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                        height: 36.ah,
                        width: 40.ah,
                        child: const Icon(Icons.arrow_back_outlined)),
                  ),
            SizedBox(
              width: 16.aw,
            ),
            Text(
              title ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF111111),
                fontSize: 32.adaptSize,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
              ),
            ),
            Spacer(),
            if (showImage ?? false)
              Container(
                child: IconButton(
                  onPressed: () {
                    Get.to(() => const AllFriendsScreen());
                  },
                  icon: Icon(
                    Icons.person_search_sharp,
                    color: MyColor.primaryColor,
                    size: 35,
                  ),
                ),
              ),
            SizedBox(
              width: 16.aw,
            ),
          ],
        ),
      ));
}

PreferredSizeWidget customAppbarForChat(
    {required BuildContext context,
    String? name,
    String? handle,
    String? imagepath,
    bool? showImage,
    bool? editBlogIcon,
    Function()? onTap}) {
  return PreferredSize(
      preferredSize:
          Size.fromHeight(200.ah), // preferred height for the app bar
      child: Container(
        height: 70.ah,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 10.aw,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                  height: 36.ah,
                  width: 40.ah,
                  child: const Icon(Icons.arrow_back_outlined)),
            ),
            SizedBox(
              width: 6.aw,
            ),
            CustomImageView(
              width: 42.adaptSize,
              height: 42.adaptSize,
              radius: BorderRadius.circular(36),
              fit: BoxFit.cover,
              imagePath: imagepath,
            ),
            SizedBox(
              width: 10.aw,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF111111),
                    fontSize: 18.adaptSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  handle ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF111111).withOpacity(.60),
                    fontSize: 14.adaptSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (editBlogIcon ?? false)
              InkWell(
                  onTap: onTap,
                  child: const Icon(
                    Icons.more_vert_outlined,
                    size: 30,
                  )),
            if (showImage ?? false)
              CustomImageView(
                width: 38.adaptSize,
                height: 38.adaptSize,
                radius: BorderRadius.circular(38.adaptSize),
                fit: BoxFit.cover,
                imagePath: imagepath,
              ),
            SizedBox(
              width: 16.aw,
            ),
          ],
        ),
      ));
}

PreferredSizeWidget customAppbarHomepage({
  required BuildContext context,
  String? title,
  Function()? onTap,
}) {
  return PreferredSize(
      preferredSize:
          Size.fromHeight(200.ah), // preferred height for the app bar
      child: SizedBox(
        height: 70.ah,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 10.aw,
            ),
            SizedBox(
              width: 16.aw,
            ),
            Text(
              title ?? "caption",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF111111),
                fontSize: 32.adaptSize,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
              ),
            ),
            Spacer(),
            CustomImageView(
              onTap: onTap,
              width: 30.adaptSize,
              height: 30.adaptSize,
              radius: BorderRadius.circular(36),
              fit: BoxFit.cover,
              imagePath: "assets/image/notification.svg",
            ),
            SizedBox(
              width: 16.aw,
            ),
          ],
        ),
      ));
}
