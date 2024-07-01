import 'package:flutter/material.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:get/get.dart';
import '../core/utils/calculateTimeDifference.dart';
import '../core/utils/pref_utils.dart';
import '../data/repositories/api_repository.dart';
import '../presentation/dashboard_screen/dashboardcontroller.dart';
import 'custom_image_view.dart';

class CustomBottomSheets {
  static void commentsBottomSheet(
      {required BuildContext context001, required String id}) {
    DashBoardController dashBoardController = Get.find();
    dashBoardController.getComments(vlogId: id, post: true);

    showBottomSheet(
        context: context001,
        builder: (BuildContext context) {
          return FractionallySizedBox(
              heightFactor: .55,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0.aw, right: 20.aw),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.ah,
                        ),
                        const Center(
                          child: Text(
                            'Comments',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.98,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.ah),
                        Obx(
                          () => dashBoardController.isLoadingONComments.value
                              ? const Center(child: CircularProgressIndicator(strokeWidth: 1,),)
                              : Expanded(
                                  child: Obx(
                                    () => dashBoardController.getCommentsModel.comments?.length == 0
                                            ? const Center(
                                                child: Text(
                                                  "No comments yet",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              )
                                            : ListView.builder(
                                                reverse: true,
                                                itemCount: dashBoardController
                                                    .getCommentsModel
                                                    .comments
                                                    ?.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10.0.ah),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            CustomImageView(
                                                              width: 40.adaptSize,
                                                              height: 40.adaptSize,
                                                              imagePath: dashBoardController.getCommentsModel.comments?[index]
                                                                  .user
                                                                  ?.avatarUrl,
                                                              fit: BoxFit.cover,
                                                              radius: BorderRadius
                                                                  .circular(45
                                                                      .adaptSize),
                                                            ),
                                                            SizedBox(
                                                              width: 18.aw,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text("${dashBoardController.getCommentsModel.comments?[index].user?.fullName}  ",
                                                                      style: TextStyle(
                                                                        color: Colors.black,
                                                                        fontSize:
                                                                            14.adaptSize,
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      calculateTimeDifference("${dashBoardController.getCommentsModel.comments?[index].createdAt}"),
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(.50),
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      width: 230.aw,
                                                                      child:
                                                                          Text(
                                                                        "${dashBoardController.getCommentsModel.comments?[index].content}",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black.withOpacity(.50),
                                                                          fontSize:
                                                                              14,
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    if ("${dashBoardController.getCommentsModel.comments?[index].user?.id}" == PrefUtils().getUserId())
                                                                      InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          await ApiRepository.deletePostComment(
                                                                              postId: id,
                                                                              commentId: "${dashBoardController.getCommentsModel.comments?[index].id}");
                                                                          dashBoardController.getComments(vlogId: id,post: true);
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          "Delete",
                                                                          style:
                                                                              TextStyle(
                                                                            color: Colors.black.withOpacity(.50),
                                                                            fontSize: 14,
                                                                            fontFamily: 'Roboto',
                                                                            fontWeight: FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 10.v,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 290.aw,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 15),
                                      disabledBorder: InputBorder.none,
                                      hintText: "Add a comment ..."),
                                  onTap: () {},
                                  onEditingComplete: () {
                                    FocusScope.of(context).unfocus();
                                    dashBoardController.postCommnetOnVlog(
                                        vlogId: id, post: true);
                                  },
                                  controller:
                                      dashBoardController.commentController,
                                  textInputAction: TextInputAction.send,
                                ),
                              ),
                              SizedBox(
                                width: 10.v,
                              ),
                              InkWell(
                                onTap: () {
                                  dashBoardController.postCommnetOnVlog(
                                      vlogId: id, post: true);
                                },
                                child: const Text(
                                  'Post',
                                  style: TextStyle(
                                    color: Color(0xFF001649),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ]),
                ),
              ));
        }).closed.then((value) {
      dashBoardController.bottomBarShow.value = true;
    });
  }
}
