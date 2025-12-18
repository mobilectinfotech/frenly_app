import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:frenly_app/data/models/loginWithBankIDCheckModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../Widgets/bottom_sheet_widgets.dart';
import '../../core/constants/app_dialogs.dart';
import '../../core/utils/pref_utils.dart';
import '../../presentation/Blog/blogListModel.dart';
import '../../presentation/Blog/blog_model.dart';
import '../../presentation/Vlog/VlogsListModel.dart';
import '../../presentation/all_saved/MySavedBlogs.dart';
import '../../presentation/all_saved/MySavedPosts.dart';
import '../../presentation/all_saved/MySavedVlogs.dart';
import '../../presentation/chat/Pages/all_frined/AllFriendsModel.dart';
import '../../presentation/chat/Pages/all_frined/CreateChatModel.dart';
import '../../presentation/my_block_list/BlockedUserListModel.dart';
import '../../presentation/my_following/FollowingsModel.dart';
import '../../presentation/my_follwers/FollowersModel.dart';
import '../../presentation/notification_screen/NotificationsModel.dart';
import '../../presentation/post/post_list_model.dart';
import '../../presentation/request_users/ReqModel.dart';
import '../../presentation/settings_screen/MySettingModel.dart';
import '../../presentation/user_follwers/UserFollowersModel.dart';
import '../../presentation/user_follwings_page/UserFollowersModel.dart';
import '../../presentation/user_profile_screen/user_profile_model.dart';
import '../data_sources/remote/api_client.dart';
import '../models/DiscoverUsersModel.dart';
import '../models/GetCommentsModel.dart';
import '../models/HomePageModel.dart';
import '../models/LastSeenModel.dart';
import '../models/LiveUserModel.dart';
import '../models/LoginWithEmailModel.dart';
import '../models/PostSingleViewModel.dart';
import '../models/SertchUserModel.dart';
import '../models/UserByCityModel.dart';
import '../models/cateogry_model.dart';
import '../models/vlog_by_id_model.dart';

class ApiRepository {
  //get fcm token
  static Future<String> getFCMToken() async {
    try {
      var fcmToken = await FirebaseMessaging.instance.getToken();
      return "$fcmToken";
    } catch (e) {
      print('Failed to get fcm token: $e');
      return 'Failed to get fcm token';
    }
  }

  static Future<bool> loginWithEmailPassword({required String email, required String password, String? fcmToken}) async {
    print("line_no_59");
    List<String> location = await getLocation();
    String fcm = await getFCMToken();
    var data = json.encode({"email": email, "password": password, "lat": location[0], "lng": location[1], "fcm_token": fcm});
    final response = await ApiClient().postRequest(endPoint: "user/login", body: data);
    if (response != null) {
      PrefUtils().setAuthToken("${LoginWithEmailModel.fromJson(response).token}");
      PrefUtils().setUserFirstName("${LoginWithEmailModel.fromJson(response).user!.fullName}");
      PrefUtils().setUserProfileUrl("${LoginWithEmailModel.fromJson(response).user!.avatarUrl}");
      PrefUtils().setUserId("${LoginWithEmailModel.fromJson(response).user!.id}");
      PrefUtils().setUserCoverUrl("${LoginWithEmailModel.fromJson(response).user!.coverPhotoUrl}");
      PrefUtils().setUserCity("${LoginWithEmailModel.fromJson(response).user!.city}");
      PrefUtils().setUserCountry("${LoginWithEmailModel.fromJson(response).user!.country}");
      return true;
    }
    return false;
  }

  static Future<bool> loginWithBankID({String? fcmToken, required namestr, required personalNumberstr}) async {
    print("line_no_59");
    List<String> location = await getLocation();
    String fcm = await getFCMToken();
    var data = json.encode({"personalNumber": personalNumberstr, "full_name": namestr, "lat": location[0], "lng": location[1], "fcm_token": fcm});
    final response = await ApiClient().postRequest(endPoint: "user/bankIdLogin", body: data);
    if (response != null) {
      PrefUtils().setAuthToken("${LoginWithEmailModel.fromJson(response).token}");
      PrefUtils().setUserFirstName("${LoginWithEmailModel.fromJson(response).user!.fullName}");
      PrefUtils().setUserProfileUrl("${LoginWithEmailModel.fromJson(response).user!.avatarUrl}");
      PrefUtils().setUserId("${LoginWithEmailModel.fromJson(response).user!.id}");
      PrefUtils().setUserCoverUrl("${LoginWithEmailModel.fromJson(response).user!.coverPhotoUrl}");
      PrefUtils().setUserCity("${LoginWithEmailModel.fromJson(response).user!.city}");
      PrefUtils().setUserCountry("${LoginWithEmailModel.fromJson(response).user!.country}");
      return true;
    }
    return false;
  }

  static Future<bool> loginWithBankIDCheck({required String personalNumberstr}) async {

    var data = json.encode({"personalNumber": personalNumberstr});
    final response = await ApiClient().postRequest(endPoint: "user/checkBankId", body: data);

    if (response != null) {
      final parsedResponse = LoginWithBankIdCheckModel.fromJson(response);

     // return parsedResponse.success == true;
      if (parsedResponse.success == true) {
        return true;
      } else {
        AppDialog.taostMessage(parsedResponse.message ?? "Something went wrong");
      }
    }

    return false;
  }



  static Future<bool> signUpWithEmailPassword({
    required String email,
    required String password,
    required String username,
    required String fullname,
  }) async {
    var data = {
      'email': email,
      'password': password,
      'full_name': "$fullname",
      'username': "$username",
    };
    Map<String, dynamic>? response = await ApiClient().postRequest(endPoint: "user/signup", body: data);

    if (response != null) {
      AppDialog.taostMessage(
        "${response["message"]}",
      );
      return true;
    }
    return false;
  }


  static Future<bool> signUpWithEmailBankid({
    required String email,
    required String password,
    required String username,
    required String fullname,
    required String personalNumber,
  }) async {
    var data = {
      "personalNumber": personalNumber,
      'email': email,
      'password': password,
      'full_name': "$fullname",
      'username': "$username",
    };
    Map<String, dynamic>? response = await ApiClient().postRequest(endPoint: "user/bankIdLogin", body: data);

    if (response != null) {
      AppDialog.taostMessage(
        "${response["message"]}",
      );
      return true;
    }
    return false;
  }

  Future<void> forgetPassword() async {}

  static Future<List<String>> getLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled.');
        return ["37.785834", "-122.406417"];
      }

      // Check and request location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permission denied.');
          return ["37.785834", "-122.406417"];
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print('Location permission permanently denied.');
        return ["37.785834", "-122.406417"];
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      print("latitude ==> ${position.latitude}");
      print("longitude ==> ${position.longitude}");

      return [
        position.latitude.toString(),
        position.longitude.toString(),
      ];
    } catch (e) {
      print('Failed to get location: $e');
      return ["37.785834", "-122.406417"];
    }
  }

  static Future<HomeModel> homePage() async {
    final response = await ApiClient().getRequest(
      endPoint: "home",
    );
    try {
      return HomeModel.fromJson(response);
    } catch (e, log) {
      print(e.toString());
      return HomeModel();
    }
  }

  //
  // static Future<void> checkIn() async {
  //   final response = await ApiClient().getRequest(
  //     endPoint: "checkIn",
  //   );
  //   try {
  //     return HomeModel.fromJson(response);
  //   } catch (e, log) {
  //     print(e.toString());
  //     return HomeModel();
  //   }
  // }

  static Future<DiscoverUsersModel> discoverUser({int? limit}) async {
    final response = await ApiClient().getRequest(
      endPoint: "home/discover?page=1&limit=${limit ?? 1000000}",
    );
    try {
      return DiscoverUsersModel.fromJson(response);
    } catch (e, log) {
      print(e.toString());
      return DiscoverUsersModel();
    }
  }

  static Future<GetUserByIdModel> myProfile({bool checkUserBlock = true}) async {
    Map<String, dynamic>? response = await ApiClient().getRequest(endPoint: "user/myProfile", checkUserBlock: checkUserBlock);
    if (response != null) {
      PrefUtils().setUserCity("${GetUserByIdModel.fromJson(response).user!.city}");
      PrefUtils().setUserCountry("${GetUserByIdModel.fromJson(response).user!.country}");
      return GetUserByIdModel.fromJson(response);
    }
    return GetUserByIdModel();
  }

  static Future<bool> editProfile({String? fullName, String? bio, String? handle, String? coverPhotoPath, String? profilePhotoPath}) async {
    FormData data;
    if (profilePhotoPath != null && coverPhotoPath != null) {
      data = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(profilePhotoPath, filename: 'avtar.svg'),
        'cover': await MultipartFile.fromFile(coverPhotoPath, filename: 'avtar.svg'),
        'full_name': '$fullName',
        'bio': '${bio}',
        'handle': handle
      });
    } else if (profilePhotoPath != null) {
      data = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(profilePhotoPath, filename: 'avtar.svg'),
        'full_name': '$fullName',
        'bio': '$bio',
        'handle': handle
      });
    } else if (coverPhotoPath != null) {
      data = FormData.fromMap(
          {'cover': await MultipartFile.fromFile(coverPhotoPath, filename: 'avtar.svg'), 'full_name': '$fullName', 'bio': '$bio', 'handle': handle});
    } else {
      data = FormData.fromMap({'full_name': '$fullName', 'bio': '$bio', 'handle': handle});
    }

    //
    Map<String, dynamic>? response = await ApiClient().postRequest(
      endPoint: "user/editProfile",
      body: data,
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");
      return true;
    }
    return false;
  }

  static Future<GetUserByIdModel> getUserById({required String userId}) async {
    Map<String, dynamic>? response = await ApiClient().getRequest(
      endPoint: "user/$userId",
    );
    if (response != null) {
      return GetUserByIdModel.fromJson(response);
    }
    return GetUserByIdModel();
  }

  static Future<bool> follow({required String userId}) async {
    Map<String, dynamic>? response = await ApiClient().postRequest(
      endPoint: "user/follow/$userId",
      body: {},
    );
    if (response != null) {
      return true;
    }
    return false;
  }

  static Future<bool> checkIn() async {
    List<String> location = await getLocation();
    String fcm = await getFCMToken();
    var data = json.encode({
      "lat": location[0],
      "lng": location[1],
    });

    Map<String, dynamic>? response = await ApiClient().postRequest(
      endPoint: "user/checkIn",
      body: data,
    );
    if (response != null) {
      myProfile();
      return true;
    }
    return false;
  }

  static Future<bool> unfollow({required String userId}) async {
    Map<String, dynamic>? response = await ApiClient().postRequest(
      endPoint: "user/unFollow/$userId",
      body: {},
    );
    if (response != null) {
      return true;
    }
    return false;
  }

  static Future<LiveUserModel> liveUser() async {
    Map<String, dynamic>? response = await ApiClient().getRequest(
      endPoint: "home/active",
    );
    if (response != null) {
      return LiveUserModel.fromJson(response);
    }
    return LiveUserModel();
  }

  static Future<GetUserByCityModel> getUserByCity({required String city}) async {
    Map<String, dynamic>? response = await ApiClient().getRequest(
      endPoint: "home/active/$city",
    );
    if (response != null) {
      return GetUserByCityModel.fromJson(response);
    }
    return GetUserByCityModel();
  }

  //vlog  comments
  static Future<VlogsListModel> searchVlog({String? searchText}) async {
    Map<String, dynamic>? response = await ApiClient().getRequest(
      endPoint: "vlog?page=1&limit=10&search=$searchText",
    );
    if (response != null) {
      return VlogsListModel.fromJson(response);
    }
    return VlogsListModel();
  }

  static Future<VlogsListModel> getVlog({int? limit}) async {
    Map<String, dynamic>? response = await ApiClient().getRequest(
      endPoint: "vlog?page=1&limit=${limit ?? 1000000}",
    );
    if (response != null) {
      return VlogsListModel.fromJson(response);
    }
    return VlogsListModel();
  }

  static Future<VlogByIdModel> getVlogById({required String userId}) async {
    Map<String, dynamic>? response = await ApiClient().getRequest(
      endPoint: "vlog/$userId",
    );
    if (response != null) {
      viewVlog(id: '$userId');
      return VlogByIdModel.fromJson(response);
    }
    return VlogByIdModel();
  }

  static Future<bool> vlogLike({required String userId}) async {
    Map<String, dynamic>? response = await ApiClient().postRequest(
      endPoint: "vlog/react/$userId",
      body: {},
    );
    if (response != null) {
      return true;
    }
    return false;
  }

  static Future<bool> vlogSave({required String userId}) async {
    Map<String, dynamic>? response = await ApiClient().postRequest(
      endPoint: "vlog/save/$userId",
      body: {},
    );
    if (response != null) {
      return true;
    }
    return false;
  }

  static Future<bool> checkUsername({required String checkUsername}) async {
    Map<String, dynamic>? response = await ApiClient().postRequest(
      endPoint: "user/checkUsername",
      body: {
        "username": checkUsername,
      },
    );
    if (response != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> postVlog({required String photoPath, required String title,
    required String des,required String location,required Function(int, int) onProgress,
  }) async {
    var data;
    data = FormData.fromMap({
      'video': await MultipartFile.fromFile(
        photoPath,
      ),
      'title': title,
      'description': des,
      'location': location,
    });
    Map<String, dynamic>? response = await ApiClient().postRequest(
      endPoint: "vlog",
      body: data,
      onSendProgress: onProgress, // 👈 add this
    );
    if (response != null) {
      //AppDialog.taostMessage("${response["message"]}");
      AppDialog.taostMessage("vlog_created_successfully".tr);
      return true;
    }
    return false;
  }

  //post
  static Future<PostListsModel> searchPosts({required String searchText}) async {
    Map<String, dynamic>? response = await ApiClient().getRequest(
      endPoint: "post?page=1&limit=1000&search=$searchText",
    );
    if (response != null) {
      return PostListsModel.fromJson(response);
    }
    return PostListsModel();
  }

  static Future<PostListsModel> getPosts() async {
    Map<String, dynamic>? response = await ApiClient().getRequest(
      endPoint: "post?page=1&limit=10000",
    );
    if (response != null) {
      return PostListsModel.fromJson(response);
    }
    return PostListsModel();
  }

  static Future<PostSingleViewModel> getPostsByID({required String id}) async {
    Map<String, dynamic>? response = await ApiClient().getRequest(
      endPoint: "post/$id",
    );
    if (response != null) {
      return PostSingleViewModel.fromJson(response);
    }
    return PostSingleViewModel();
  }

  //1234567890
  static Future<AllFriendsModel> getFriends() async {
    Map<String, dynamic>? response = await ApiClient().getRequest(
      endPoint: "home/friends",
    );
    print("🔥 FRIEND API RESPONSE: $response"); // ADD THIS

    if (response != null) {
      return AllFriendsModel.fromJson(response);
    }
    return AllFriendsModel();
  }

  static Future<CreateChatModel> createChat({required String userId}) async {
    Map<String, dynamic>? response = await ApiClient().postRequest(
        endPoint: "chat/$userId", body: {});
    if (response != null) {
      return CreateChatModel.fromJson(response);
    }
    return CreateChatModel();
  }

  //static Future<bool> postPost({required String photoPath, required String title}) async {
  static Future<bool> postPost({required String photoPath, required String title,required String location}) async {
    print("sjdsfkjfdskjdfs${photoPath}");
    var data;
    data = FormData.fromMap({
      'image': await MultipartFile.fromFile(photoPath),
      'caption': title,
      'location': location,
    });

    Map<String, dynamic>? response = await ApiClient().postRequest(
      endPoint: "post",
      body: data,
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");
      return true;
    }
    return false;
  }

  //blog

  static Future<bool> blogLike({required String userId}) async {
    Map<String, dynamic>? response = await ApiClient().postRequest(
      endPoint: "blog/react/$userId",
      body: {},
    );
    if (response != null) {
      return true;
    }
    return false;
  }

  static Future<bool> commnetLikeONvlog({required String volgId, required PostType postType}) async {
    print("comment like $volgId");
    Map<String, dynamic>? response = await ApiClient().postRequest(
      endPoint: "/${(postType.name)}/react/comment/$volgId",
      body: {},
    );
    if (response != null) {
      return true;
    }
    return false;
  }

  static Future<bool> postLike({required String userId}) async {
    Map<String, dynamic>? response = await ApiClient().postRequest(
      endPoint: "post/react/$userId",
      body: {},
    );
    if (response != null) {
      return true;
    }
    return false;
  }

  static Future<bool> blogSave({required String userId}) async {
    Map<String, dynamic>? response = await ApiClient().postRequest(
      endPoint: "blog/save/$userId",
      body: {},
    );
    if (response != null) {
      return true;
    }
    return false;
  }

  static Future<bool> postSave({required String userId}) async {
    Map<String, dynamic>? response = await ApiClient().postRequest(
      endPoint: "post/save/$userId",
      body: {},
    );
    if (response != null) {
      return true;
    }
    return false;
  }

  static Future<bool> isOnline() async {
    Map<String, dynamic>? response = await ApiClient().postRequest(
      endPoint: "user/online",
      body: {},
    );
    if (response != null) {
      return true;
    }
    return false;
  }

  static Future<bool> isOffline() async {
    Map<String, dynamic>? response = await ApiClient().postRequest(
      endPoint: "user/offline",
      body: {},
    );
    if (response != null) {
      return true;
    }
    return false;
  }

  static Future<MySavedBlogs> savedBlog() async {
    Map<String, dynamic>? response = await ApiClient().getRequest(
      endPoint: "blog/saved?page=1&limit=10000",
    );
    if (response != null) {
      return MySavedBlogs.fromJson(response);
    }
    return MySavedBlogs();
  }

  static Future<MySavedPosts> savePosts() async {
    Map<String, dynamic>? response = await ApiClient().getRequest(
      endPoint: "post/saved?page=1&limit=100000",
    );
    if (response != null) {
      return MySavedPosts.fromJson(response);
    }
    return MySavedPosts();
  }

  static Future<MySavedVlogs> saveVlogs() async {
    Map<String, dynamic>? response = await ApiClient().getRequest(
      endPoint: "vlog/saved?page=1&limit=100000",
    );
    if (response != null) {
      return MySavedVlogs.fromJson(response);
    }
    return MySavedVlogs();
  }

  static Future<BlogListModel> searchBlog({required String searchText}) async {
    Map<String, dynamic>? response = await ApiClient().getRequest(
      endPoint: "blog?page=1&limit=10&search=$searchText",
    );
    if (response != null) {
      return BlogListModel.fromJson(response);
    }
    return BlogListModel();
  }

  static Future<BlogListModel> blog() async {
    Map<String, dynamic>? response = await ApiClient().getRequest(
      endPoint: "blog",
    );
    if (response != null) {
      return BlogListModel.fromJson(response);
    }
    return BlogListModel();
  }

  static Future<bool> postBlog({
    String? blogPic,
    required String title,
    required String body,
    required List<String>? tag,
  }) async {
    print("dsfdsf${blogPic}");
    var data;
    if (blogPic != null) {
      data = FormData.fromMap({
        'image': await MultipartFile.fromFile(blogPic, filename: 'avtar.svg'),
        'title': title,
        'body': body,
        'tags[]': tag,
      });
    } else {
      data = FormData.fromMap({
        'title': title,
        'body': body,
        'tags[]': tag,
      });
    }
    Map<String, dynamic>? response = await ApiClient().postRequest(
      endPoint: "blog",
      body: data,
    );
    if (response != null) {
      return true;
    }
    return false;
  }

  static Future<bool> updateBlog({
    String? blogPic,
    required String title,
    required String body,
    required String id,
    required List<String>? tag,
  }) async {
    print("dsfdsf${blogPic}");
    var data;
    if (blogPic != null) {
      data = FormData.fromMap(
          {'image': await MultipartFile.fromFile(blogPic, filename: 'avtar.svg'), 'title': title, 'body': body, 'tags[]': tag, "id": id});
    } else {
      data = FormData.fromMap({'title': title, 'body': body, 'tags[]': tag, "id": id});
    }

    Map<String, dynamic>? response = await ApiClient().patchRequest(
      endPoint: "blog",
      body: data,
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");
      return true;
    }
    return false;
  }

  static Future<bool> updateVlog({
    String? blogPic,
    required String title,
    required String body,
    required String id,
  }) async {
    print("dsfdsf${blogPic}");
    var data;
    if (blogPic != null) {
      data = FormData.fromMap({'video': await MultipartFile.fromFile(blogPic, filename: 'avtar.svg'), 'title': title, 'description': body, "id": id});
    } else {
      data = FormData.fromMap({'title': title, 'description': body, "id": id});
    }

    Map<String, dynamic>? response = await ApiClient().patchRequest(
      endPoint: "vlog",
      body: data,
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");
      return true;
    }
    return false;
  }

  static Future<BlogModel> getBlogBYId({required String blogId}) async {
    Map<String, dynamic>? response = await ApiClient().getRequest(
      endPoint: "/blog/$blogId",
    );
    if (response != null) {
      return BlogModel.fromJson(response);
    }
    return BlogModel();
  }

//////////////////////comments//////////////////////////////////////////////////////////////////////////

  static Future<GetCommentsModel> getCommentsAll({required String id, required PostType postType}) async {
    Map<String, dynamic>? response = await ApiClient().getRequest(
      endPoint: "${(postType.name)}/comment/$id?page=1&limit=1000",
    );
    if (response != null) {
      return GetCommentsModel.fromJson(response);
    }
    return GetCommentsModel();
  }

  static Future<bool> postCommentAll({
    required String id,
    required PostType postType,
    required String comment,
  }) async {
    Map<String, dynamic>? response = await ApiClient().postRequest(endPoint: "${postType.name}/comment/$id", body: {"content": comment});
    if (response != null) {
      return true;
    }
    return false;
  }

  static Future<bool> deleteCommentAll({required String id, required PostType postType, required String commentId}) async {
    Map<String, dynamic>? response = await ApiClient().deleteRequest(
      endPoint: "${postType.name}/$id/comment/$commentId",
      body: {},
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> likeVlogBlogPost({required String userId, required PostType postType}) async {
    Map<String, dynamic>? response = await ApiClient().postRequest(
      endPoint: "${postType.name}/react/$userId",
      body: {},
    );
    if (response != null) {
      return true;
    }
    return false;
  }

//////////////////////comments//////////////////////////////////////////////////////////////////////////

  static Future<bool> shareAllBlogPostVlog({required String shareId, required PostType postType}) async {
    final response = await ApiClient().postRequest(
      endPoint: "${postType.name}/share/${shareId}",
      body: {},
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> sendMessageWithShare({
    required String message,
    required String chatId,
    required String isLinkId,
    required String isUrl,
    required PostType postType,
  }) async {
    var isLinkIdd = 0;
    if (postType.name == "post") {
      isLinkIdd = 1;
    }
    if (postType.name == "vlog") {
      isLinkIdd = 3;
    }
    if (postType.name == "blog") {
      isLinkIdd = 2;
    }
    final response = await ApiClient()
        .postRequest(endPoint: "message/${chatId}", body: {"content": message, "isLink": isLinkIdd, "isLinkId": isLinkId, "isUrl": isUrl});
    if (response != null) {
      shareAllBlogPostVlog(shareId: isLinkId, postType: postType);
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> saveAllById({required String id, required String categoryId, required PostType postType}) async {
    print("postType ${postType}");
    final response = await ApiClient().postRequest(
      endPoint: "/${postType.name}/save/$id",
      body: {"categoryId": int.parse(categoryId)},
      // endPoint: "/vlog/save/$vlogId",
      // body: {"categoryId": categoryId},
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");
      return true;
    } else {
      return false;
    }
  }

///////////////////////////////////////////////////////////////////////////////////

  static Future<bool> postCommentOnVlog({
    required String vlogId,
    required String comment,
  }) async {
    Map<String, dynamic>? response = await ApiClient().postRequest(endPoint: "vlog/comment/$vlogId", body: {"content": comment});
    if (response != null) {
      return true;
    }
    return false;
  }

  static Future<bool> postCommentOnBlog({
    required String vlogId,
    required String comment,
  }) async {
    Map<String, dynamic>? response = await ApiClient().postRequest(endPoint: "blog/comment/$vlogId", body: {"content": comment});
    if (response != null) {
      return true;
    }
    return false;
  }

  static Future<bool> postCommentOnPost({
    required String vlogId,
    required String comment,
  }) async {
    Map<String, dynamic>? response = await ApiClient().postRequest(endPoint: "post/comment/$vlogId", body: {"content": comment});
    if (response != null) {
      return true;
    }
    return false;
  }

  //getall user search

  static Future<SertchUserModel> searchUser({required String searchText}) async {
    Map<String, dynamic>? response = await ApiClient().getRequest(
      endPoint: "user?page=1&limit=10000&search=$searchText",
    );
    if (response != null) {
      return SertchUserModel.fromJson(response);
    }
    return SertchUserModel();
  }

  //my followers

  static Future<FollowersModel> myFollowers() async {
    final response = await ApiClient().getRequest(
      endPoint: "user/followers?page=1&limit=1000",
    );
    try {
      return FollowersModel.fromJson(response);
    } catch (e, log) {
      print(e.toString());
      return FollowersModel();
    }
  }

  static Future<UserFollowersModel> userFollowers({required String userId}) async {
    final response = await ApiClient().getRequest(
      endPoint: "user/getUserFollowers/$userId",
    );
    try {
      return UserFollowersModel.fromJson(response);
    } catch (e, log) {
      print(e.toString());
      return UserFollowersModel();
    }
  }

  static Future<UserFollowingModel> userFollwings({required String userId}) async {
    final response = await ApiClient().getRequest(
      endPoint: "user/getUserFollowings/$userId",
    );
    try {
      return UserFollowingModel.fromJson(response);
    } catch (e, log) {
      print(e.toString());
      return UserFollowingModel();
    }
  }

  static Future<FollowingsModel> myFollowings() async {
    final response = await ApiClient().getRequest(
      endPoint: "user/followings?page=1&limit=1000",
    );
    try {
      return FollowingsModel.fromJson(response);
    } catch (e, log) {
      print(e.toString());
      return FollowingsModel();
    }
  }

  static Future<MySettingModel> mySettings() async {
    final response = await ApiClient().getRequest(
      endPoint: "user/settings",
    );
    try {
      return MySettingModel.fromJson(response);
    } catch (e, log) {
      print(e.toString());
      return MySettingModel.fromJson(response);
    }
  }

  static Future<MySettingModel> chatChatStatus() async {
    final response = await ApiClient().getRequest(
      endPoint: "chat/chatStatus",
    );
    try {
      return MySettingModel.fromJson(response);
    } catch (e, log) {
      print(e.toString());
      return MySettingModel.fromJson(response);
    }
  }

  static Future<LastSeenModel> lastSeen({required String id}) async {
    final response = await ApiClient().getRequest(
      endPoint: "user/getLastSeen/$id",
    );
    try {
      return LastSeenModel.fromJson(response);
    } catch (e, log) {
      print(e.toString());
      return LastSeenModel.fromJson(response);
    }
  }

  static Future<bool> mySettingsUpdate(
      {required bool lastSeen,
        required bool commentsAllowed,
        required bool chatNotification,
        required bool feedNotification,
        required bool hideLikes,
        required String language}) async {
    final response = await ApiClient().patchRequest(
        endPoint: "user/settings",
        body: {
      "lastSeen": lastSeen,
      "commentsAllowed": commentsAllowed,
      "chatNotification": chatNotification,
      "feedNotification": feedNotification,
      "language": language,
      "hideLikes": hideLikes
    });
    if (response != null) {
      return true;
    } else {
      return false;
    }
  }


  static Future<ReqModel> getUserFollowingReqest() async {
    Map<String, dynamic>? response = await ApiClient().getRequest(
      endPoint: "notification/followRequests",
    );
    if (response != null) {
      return ReqModel.fromJson(response);
    }
    return ReqModel();
  }

  static Future<bool> updateAccountPrivate({
    required bool isPrivate,
  }) async {
    final response = await ApiClient().patchRequest(endPoint: "user/updateProfileVisibilty",
        body: {
      "isPrivate": isPrivate,
    });
    if (response != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteAccount() async {
    Map<String, dynamic>? response = await ApiClient().deleteRequest(
      endPoint: "user",
      body: {},
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> forgotPassword({required String email}) async {
    Map<String, dynamic>? response = await ApiClient().postRequest(
      endPoint: "user/forgotPassword",
      body: {
        "email": email,
      },
    );
    if (response != null) {
      var msg = "password_reset_link_sent_successfully_please_check_your_email".tr;
      AppDialog.taostMessage(msg);
      return true;
    } else {
      return false;
    }
  }





  static Future<bool> viewVlog({required String id}) async {
    print("sdfghjhgfdsdfghjhgfdsdfghjhgfdfghj");
    Map<String, dynamic>? response = await ApiClient().postRequest(
      endPoint: "vlog/view/$id",
      body: {},
    );
    if (response != null) {
      // AppDialog.taostMessage("${response["message"]}");

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteChat({required String chatId}) async {
    Map<String, dynamic>? response = await ApiClient().deleteRequest(
      endPoint: "chat/$chatId",
      body: {},
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteVlogComment({
    required String vlogId,
    required String commentId,
  }) async {
    Map<String, dynamic>? response = await ApiClient().deleteRequest(
      endPoint: "vlog/$vlogId/comment/$commentId",
      body: {},
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteNotification({
    required String notificationID,
  }) async {
    Map<String, dynamic>? response = await ApiClient().deleteRequest(
      endPoint: "notification/${notificationID}",
      body: {},
    );
    if (response != null) {
      //  AppDialog.taostMessage("${response["message"]}");
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deletePostComment({
    required String postId,
    required String commentId,
  }) async {
    Map<String, dynamic>? response = await ApiClient().deleteRequest(
      endPoint: "post/$postId/comment/$commentId",
      body: {},
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteVlog({required String postId}) async {
    Map<String, dynamic>? response = await ApiClient().deleteRequest(
      endPoint: "vlog/$postId",
      body: {},
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");

      return true;
    } else {
      return false;
    }
  }

  // delete post vlog blog

  static Future<bool> deletePostBolgVlog({required String id, required PostType postType}) async {
    Map<String, dynamic>? response = await ApiClient().deleteRequest(
      endPoint: "${postType.name}/$id",
      body: {},
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");

      return true;
    } else {
      return false;
    }
  }

  // report post vlog blog

  static Future<bool> reportPostVlogBlog({
    required String id,
    required String reason,
    required PostType postType,
  }) async {
    var endPointt = "notfound";
    if (postType.name == "vlog") {
      endPointt = "vlog/reportVlog";
    }
    if (postType.name == "blog") {
      endPointt = "blog/reportBlog";
    }
    if (postType.name == "post") {
      endPointt = "post/reportPost";
    }

    var data = {
      postType.name == "vlog"
          ? "VlogId"
          : postType.name == "blog"
              ? "blogId"
              : "PostId": id,
      'reason': reason,
    };

    Map<String, dynamic>? response = await ApiClient().postRequest(
      endPoint: endPointt,
      body: data,
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");

      return true;
    } else {
      return false;
    }
  }

  // static Future<bool> deletePost({
  //   required String postId,
  // }) async {
  //   Map<String, dynamic>? response = await ApiClient().deleteRequest(
  //     endPoint: "post/$postId",
  //     body: {},
  //   );
  //   if (response != null) {
  //     AppDialog.taostMessage("${response["message"]}");
  //
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  static Future<bool> deleteNotificationAll({
    required String postId,
  }) async {
    Map<String, dynamic>? response = await ApiClient().deleteRequest(
      endPoint: "notification/deleteAll",
      body: {},
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteBlog({
    required String blogId,
  }) async {
    Map<String, dynamic>? response = await ApiClient().deleteRequest(
      endPoint: "blog/$blogId",
      body: {},
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteBlogComment({
    required String postId,
    required String commentId,
  }) async {
    Map<String, dynamic>? response = await ApiClient().deleteRequest(
      endPoint: "blog/$postId/comment/$commentId",
      body: {},
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");
      return true;
    } else {
      return false;
    }
  }

  static Future<BlockedUserListModel> myBlockList() async {
    final response = await ApiClient().getRequest(
      endPoint: "user/blocked?page=1&limit=4000",
    );
    try {
      return BlockedUserListModel.fromJson(response);
    } catch (e, log) {
      print(e.toString());
      return BlockedUserListModel();
    }
  }

  static Future<bool> blockUser({required String userId}) async {
    final response = await ApiClient().postRequest(
      endPoint: "user/block/$userId",
      body: {},
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> reportUser({required String userId, required String reason}) async {
    var data = {'userId': userId, 'reason': reason};
    final response = await ApiClient().postRequest(
      endPoint: "user/reportProfile",
      body: data,
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> unblockUser({required String userId}) async {
    final response = await ApiClient().deleteRequest(
      endPoint: "user/unblock/$userId",
      body: {},
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");
      return true;
    } else {
      return false;
    }
  }

  static Future<CategoryModel> getCategories() async {
    final response = await ApiClient().getRequest(
      endPoint: "user/getCategories",
    );
    if (response != null) {
      return CategoryModel.fromJson(response);
      AppDialog.taostMessage("${response["message"]}");
    } else {
      return CategoryModel();
    }
  }

  static Future<bool> saveVlogBYId({required String vlogId, required String categoryId}) async {
    final response = await ApiClient().postRequest(
      endPoint: "/vlog/save/$vlogId",
      body: {"categoryId": categoryId},
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> saveBlogBYid({required String vlogId, required String categoryId}) async {
    final response = await ApiClient().postRequest(
      endPoint: "/blog/save/$vlogId",
      body: {"categoryId": categoryId},
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> savePostBYid({required String vlogId, required String categoryId}) async {
    final response = await ApiClient().postRequest(
      endPoint: "/post/save/$vlogId",
      body: {"categoryId": categoryId},
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> addCategory({required String categoryName}) async {
    final response = await ApiClient().postRequest(
      endPoint: "user/addCategory",
      body: {"name": categoryName},
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteCategory({required int categoryId}) async {
    final response = await ApiClient().deleteRequest(
      endPoint: "/user/category/$categoryId",
      body: null,
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");
      return true;
    } else {
      return false;
    }
  }

  static Future<NotificationsModel> notification() async {
    final response = await ApiClient().getRequest(
      endPoint: "notification",
    );
    try {
      return NotificationsModel.fromJson(response);
    } catch (e, log) {
      print(e.toString());
      return NotificationsModel();
    }
  }

  static Future<bool> acepedReqest({required int byUserId, required int toUserId, required int notificationId}) async {
    var data = {'followerId': '${byUserId}', 'notificationId': '${notificationId}', 'userId': '${toUserId}'};
    final response = await ApiClient().postRequest(
      endPoint: "user/acceptFollowRequest",
      body: data,
    );
    if (response != null) {
      AppDialog.taostMessage("${response["message"]}");
      return true;
    } else {
      return false;
    }
  }
}




