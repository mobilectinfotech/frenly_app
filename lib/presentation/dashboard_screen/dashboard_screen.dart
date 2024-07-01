import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import '../chat/Pages/chats/chats_screen.dart';
import '../home_screen/home_screen.dart';
import '../search/new.dart';
import '../post/post_blogs/post_blog_screen.dart';
import '../post/post_photo_screen/post_blog_screen.dart';
import '../post/post_video_screen/post_video_screen.dart';
import '../auth/my_profile_view/my_profile_screen.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:get/get.dart';
import 'dashboardcontroller.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    ApiRepository.isOnline();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    ApiRepository.isOffline();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // if (localAuthVerified.value != true && state == AppLifecycleState.resumed) {
    //   try {
    //     getIt.get<BottomNavBarProvider>().callLocalAuthenticateFunction();
    //   } catch (e, s) {}
    // }
    switch (state) {
      case AppLifecycleState.detached:
        print("AppLifecycleState.resumed");
        ApiRepository.isOffline();

      // TODO: Handle this case.
      case AppLifecycleState.resumed:
        print("AppLifecycleState.resumed");
        ApiRepository.isOnline();

      // TODO: Handle this case.
      case AppLifecycleState.inactive:
        print("AppLifecycleState.inactive");
        ApiRepository.isOffline();

      // TODO: Handle this case.
      case AppLifecycleState.hidden:
        print("AppLifecycleState.hidden");
        ApiRepository.isOffline();

      // TODO: Handle this case.
      case AppLifecycleState.paused:
        print("AppLifecycleState.paused");
        ApiRepository.isOffline();

      // TODO: Handle this case.
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  DashBoardController controller = Get.put(DashBoardController());
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List _items = [
    const HomeScreen(),
    const New(),
    const SizedBox(),
    ChatsScreen(chatmodels: [],),
    const MyProfileScreen(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CircularMenu(
          toggleButtonColor: Colors.transparent,
          toggleButtonIconColor: Colors.transparent,
          items: [
            CircularMenuItem(color: Colors.transparent, onTap: () {}),
            CircularMenuItem(
                boxShadow: [],
                icon: Icons.image_outlined,
                color: const Color(0xffE52C42),
                onTap: () {
                  Get.to(() => const PostPostScreen());
                }),
            CircularMenuItem(
                boxShadow: [],
                icon: Icons.video_camera_back_outlined,
                color: const Color(0xffE52C42),
                onTap: () {
                  Get.to(() => const PostVideoScreen());
                }),
            CircularMenuItem(
                boxShadow: [],
                icon: Icons.edit_note_outlined,
                color: const Color(0xffE52C42),
                onTap: () {
                  Get.to(() => const PostBlogScreen());
                }),
            CircularMenuItem(color: Colors.transparent, onTap: () {})
          ],
          backgroundWidget: Stack(
            children: [
              Center(child: _items[_selectedIndex]),
              Obx(() => controller.bottomBarShow.value
                  ? Positioned(
                      bottom: 20.ah,
                      left: 10.aw,
                      right: 10.aw,
                      child: Container(
                        width: 390.aw,
                        height: 61.ah,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.5,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(80),
                          color: const Color(0xff001649),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _selectedIndex == 0 ?
                            Container(
                              height: 38.adaptSize,
                              width: 38.adaptSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: IconButton(
                                icon: Image.asset(
                                  'assets/image/ichome.png',
                                ),
                                onPressed: () => _onItemTapped(1),
                              ),
                            ) :
                            Container(
                              height: 38.adaptSize,
                              width: 38.adaptSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                              ),
                              child: IconButton(
                                icon: Image.asset(
                                  'assets/image/icoohome.png',
                                ),
                                onPressed: () => _onItemTapped(0),
                              ),
                            ),


                            // Container(
                            //   height: 38.adaptSize,
                            //   width: 38.adaptSize,
                            //   child: IconButton(
                            //     icon: const Icon(
                            //       Icons.home,
                            //       color: Colors.white,
                            //     ),
                            //     onPressed: () => _onItemTapped(0),
                            //   ),
                            // ),
                            // This is necessary to create space in the center
                            _selectedIndex == 1 ?
                            Container(
                              height: 38.adaptSize,
                              width: 38.adaptSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: IconButton(
                                icon: Image.asset(
                                  'assets/image/serch.png',

                                ),
                                onPressed: () => _onItemTapped(1),
                              ),
                            ) :
                            Container(
                              height: 38.adaptSize,
                              width: 38.adaptSize,
                              child: IconButton(
                                icon: Image.asset(
                                  'assets/image/Icon.png',

                                ),
                                // Icon(Icons.notifications),
                                onPressed: () => _onItemTapped(1),
                              ),
                            ),

                            _selectedIndex == 2 ?
                            Container(
                              height: 38.adaptSize,
                              width: 38.adaptSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: IconButton(
                                icon: Image.asset(
                                  'assets/image/ichome.png',

                                ),

                                onPressed: () => _onItemTapped(1),
                              ),
                            ) :
                            IconButton(
                              icon: Container(
                                height: 43.ah,
                                width: 43.aw,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                    child: Image.asset(
                                  'assets/image/Union (1).png',
                                  height: 19.ah,
                                  width: 19.aw,
                                )),
                              ),
                              onPressed: () {},
                            ),

                            _selectedIndex == 3 ?
                            Container(
                              height: 38.adaptSize,
                              width: 38.adaptSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: IconButton(
                                icon: Image.asset('assets/image/proIcon.png',
                                ),

                                onPressed: () => _onItemTapped(1),
                              ),
                            ) :
                            Container(
                              height: 38.adaptSize,
                              width: 38.adaptSize,
                              child: IconButton(
                                icon: Image.asset(
                                  'assets/image/message_icon.png',
                                  color: Colors.white,
                                ),
                                onPressed: () => _onItemTapped(3),
                              ),
                            ),

                            _selectedIndex == 4 ?
                            Container(
                              height: 38.adaptSize,
                              width: 38.adaptSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: IconButton(
                                icon: Image.asset(
                                  'assets/image/personVector.png',
                                ),

                                onPressed: () => _onItemTapped(1),
                              ),
                            ) :

                            Container(
                              height: 38.adaptSize,
                              width: 38.adaptSize,
                              child: IconButton(
                                icon: Image.asset(
                                  'assets/image/Vector.png',
                                  color: Colors.white,
                                ),
                                onPressed: () => _onItemTapped(4),
                              ),
                            ),

                            // Image.asset('assets/image/Vector.png',height: 21.ah,width: 21.aw,color: Colors.white,)
                          ],
                        ),
                      ))
                  : const SizedBox()),
            ],
          )),
    );
  }
}
