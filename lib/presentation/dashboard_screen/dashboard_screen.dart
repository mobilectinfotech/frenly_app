// import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
// import 'package:frenly_app/core/utils/size_utils.dart';
// import 'package:frenly_app/presentation/Blog/upload_blog/upload_blog_screen.dart';
// import '../../core/utils/pref_utils.dart';
// import '../../data/data_sources/remote/api_client.dart';
// import '../chat/Pages/chats/chats_screen.dart';
// import '../home_screen/home_screen.dart';
// import '../post/upload_post/upload_post_screen.dart';
// import '../search/search_page.dart';
// import '../auth/my_profile_view/my_profile_screen.dart';
// import 'package:circular_menu/circular_menu.dart';
// import 'package:get/get.dart';
// import '../Vlog/upload_vlog/upload_vlog_screen.dart';
// import 'dashboardcontroller.dart';
//
// class DashBoardScreen extends StatefulWidget {
//   const DashBoardScreen({super.key});
//
//   @override
//   State<DashBoardScreen> createState() => _DashBoardScreenState();
// }
//
// class _DashBoardScreenState extends State<DashBoardScreen> {
//   DashBoardController controller = Get.put(DashBoardController());
//
//
//   int _selectedIndex = 0;
//
//   final List _items = [
//     const HomeScreen(),
//      SearchScreen(),
//     const SizedBox(),
//      ChatsScreen(),
//     const MyProfileScreen(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       key.currentState?.reverseAnimation();
//       _selectedIndex = index;
//     });
//   }
//
//   GlobalKey<CircularMenuState> key = GlobalKey<CircularMenuState>();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: CircularMenu(
//         key: key,
//         // toggleButtonPadding: 40,
//         alignment: Alignment.bottomCenter,
//         toggleButtonSize: 50,
//         toggleButtonColor: Colors.transparent,
//         toggleButtonIconColor: Colors.transparent,
//         toggleButtonMargin: 20,
//         radius: 120,
//         items: [
//           CircularMenuItem(color: Colors.transparent, onTap: () {}),
//           CircularMenuItem(
//               boxShadow: [],
//               iconSize: 20,
//               icon: Icons.image_outlined,
//               color: Color(0xFF001649),
//               onTap: () {
//                 print("Circular menu item");
//                 key.currentState?.reverseAnimation();
//                 Get.to(() => const PostPostScreen());
//               }),
//           CircularMenuItem(
//               boxShadow: [],
//               iconSize: 20,
//               icon: Icons.video_camera_back_outlined,
//               color: Color(0xFF001649),
//               onTap: () {
//                 key.currentState?.reverseAnimation();
//                 print("Circular menu item");
//                 Get.to(() => const UploadVlogScreen());
//               }),
//           CircularMenuItem(
//               boxShadow: [],
//               iconSize: 18,
//               icon: Icons.edit_note_outlined,
//               color: Color(0xFF001649),
//               onTap: () {
//                 print("Circular menu item");
//                 key.currentState?.reverseAnimation();
//                 Get.to(() => const UploadBlogScreen());
//               }),
//           CircularMenuItem(color: Colors.transparent, onTap: () {})
//         ],
//         backgroundWidget: Stack(
//           children: [
//             Scaffold(
//               bottomNavigationBar: Container(
//                   width: double.infinity,
//                   height: 75.0.adaptSize,
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 16, vertical: 0),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF001649),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20.0),
//                       topRight: Radius.circular(20.0),
//                     )
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 8.0,right: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         _selectedIndex == 0
//                             ? Container(
//                                 height: 38.adaptSize,
//                                 width: 38.adaptSize,
//                                 decoration: const BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.white,
//                                 ),
//                                 child: IconButton(
//                                   icon: Image.asset(
//                                     'assets/image/ichome.png',
//                                   ),
//                                   onPressed: () => _onItemTapped(0),
//                                 ),
//                               )
//                             : Container(
//                                 height: 38.adaptSize,
//                                 width: 38.adaptSize,
//                                 decoration: const BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.transparent,
//                                 ),
//                                 child: IconButton(
//                                   icon: Image.asset(
//                                     'assets/image/icoohome.png',
//                                   ),
//                                   onPressed: () => _onItemTapped(0),
//                                 ),
//                               ),
//                         _selectedIndex == 1
//                             ? Container(
//                                 height: 38.adaptSize,
//                                 width: 38.adaptSize,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.white,
//                                 ),
//                                 child: IconButton(
//                                   icon: Image.asset(
//                                     'assets/image/serch.png',
//                                   ),
//                                   onPressed: () => _onItemTapped(1),
//                                 ),
//                               )
//                             : Container(
//                                 height: 38.adaptSize,
//                                 width: 38.adaptSize,
//                                 child: IconButton(
//                                   icon: Image.asset(
//                                     'assets/image/Icon.png',
//                                   ),
//                                   // Icon(Icons.notifications),
//                                   onPressed: () => _onItemTapped(1),
//                                 ),
//                               ),
//                         SizedBox(
//                           height: 70.adaptSize,
//                           width: 70.adaptSize,
//                           child: Stack(
//                             children: [
//                               Positioned.fill(
//                                   child: Center(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(200),
//                                     color: Colors.white,
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(6.adaptSize),
//                                     child: Icon(
//                                       Icons.add,
//                                       color: Color(0xFF001649),
//                                       size: 35,
//                                     ),
//                                   ),
//                                 ),
//                               )),
//                             ],
//                           ),
//                         ),
//                         _selectedIndex == 3
//                             ? Container(
//                                 height: 38.adaptSize,
//                                 width: 38.adaptSize,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.white,
//                                 ),
//                                 child: IconButton(
//                                   icon: Image.asset(
//                                     'assets/image/proIcon.png',
//                                   ),
//                                   onPressed: () => _onItemTapped(3),
//                                 ),
//                               )
//                             : Container(
//                                 height: 38.adaptSize,
//                                 width: 38.adaptSize,
//                                 child: IconButton(
//                                   icon: Image.asset(
//                                     'assets/image/message_icon.png',
//                                     color: Colors.white,
//                                   ),
//                                   onPressed: () => _onItemTapped(3),
//                                 ),
//                               ),
//                         _selectedIndex == 4
//                             ? Container(
//                                 height: 38.adaptSize,
//                                 width: 38.adaptSize,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.white,
//                                 ),
//                                 child: IconButton(
//                                   icon: Image.asset(
//                                     'assets/image/personVector.png',
//                                   ),
//                                   onPressed: () => _onItemTapped(4),
//                                 ),
//                               )
//                             : Container(
//                                 height: 38.adaptSize,
//                                 width: 38.adaptSize,
//                                 child: IconButton(
//                                   icon: Image.asset(
//                                     'assets/image/Vector.png',
//                                     color: Colors.white,
//                                   ),
//                                   onPressed: () => _onItemTapped(4),
//                                 ),
//                               ),
//                       ],
//                     ),
//                   )),
//               body: Center(child: _items[_selectedIndex]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frenly_app/presentation/auth/my_profile_view/my_profile_controller.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/Blog/upload_blog/upload_blog_screen.dart';
import '../../core/utils/pref_utils.dart';
import '../../data/data_sources/remote/api_client.dart';
import '../chat/Pages/chats/chats_screen.dart';
import '../home_screen/home_screen.dart';
import '../post/upload_post/upload_post_screen.dart';
import '../search/search_page.dart';
import '../auth/my_profile_view/my_profile_screen.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:get/get.dart';
import '../Vlog/upload_vlog/upload_vlog_screen.dart';
import 'dashboardcontroller.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  DashBoardController controller = Get.put(DashBoardController());

  int _selectedIndex = 0;

  final List _items = [
    const HomeScreen(),
    SearchScreen(),
    const SizedBox(),
    ChatsScreen(),
    const MyProfileScreen(userId: '',),
  ];

  void _onItemTapped(int index) {

    setState(() {
      key.currentState?.reverseAnimation();
      _selectedIndex = index;
    });
  }

  GlobalKey<CircularMenuState> key = GlobalKey<CircularMenuState>();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onWillPop() async {
    // If not on the first index, navigate to the first index instead of exiting
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return false; // prevent exiting
    }
    // If on the first index, allow the exit
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Material(
        child: CircularMenu(
          key: key,
          // toggleButtonPadding: 40,
          alignment: Alignment.bottomCenter,
          toggleButtonSize: 50,
          toggleButtonColor: Colors.transparent,
          toggleButtonIconColor: Colors.transparent,
          toggleButtonMargin: 20,
          //radius: 120,
          radius: 130,

          /// Required parameters 🔥🔥🔥
          // startingAngleInRadian: -1.5,
          // endingAngleInRadian: 1.5,
          /// FINAL FIXED RADIAN VALUES 🔥
          // startingAngleInRadian: 3.14 / 2,     // 1.57 → 90° clockwise
          // endingAngleInRadian: 3.14 * 1.5,     // 4.71 → 270° clockwise
          // startingAngleInRadian: 3.6,    // ~200° (thoda left side se shuru)
          // endingAngleInRadian: 5.9,      // 360° right
          startingAngleInRadian: 3.2,    // ~200° (thoda left side se shuru)
          endingAngleInRadian: 6.2,      // 360° right
          curve: Curves.easeOutBack,
          reverseCurve: Curves.easeInBack,
          items: [

            CircularMenuItem(color: Colors.transparent, onTap: () {}),

            CircularMenuItem(
                boxShadow: [],
                iconSize: 20,
                icon: Icons.image_outlined,
                color: Color(0xFF001649),
                onTap: () {
                  print("Circular menu item");
                  key.currentState?.reverseAnimation();
                  Get.to(() => PostPostScreen());
                }
                ),

            // CircularMenuItem(
            //   padding: 100,
            //   iconSize: 20,
            //   margin: 20,
            //   //badgeRadius: 20,
            //   color: const Color(0xFF001649),
            //   onTap: () {
            //     key.currentState?.reverseAnimation();
            //     Get.to(() => const UploadBlogScreen());
            //   },
            //   // Use 'child:' instead of 'icon:' or 'widget:'
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Center(
            //       child:  Image.asset(
            //         'assets/image/message_icon.png',
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),

            CircularMenuItem(
                boxShadow: [],
                iconSize: 20,
                icon: Icons.video_camera_back_outlined,
                color: Color(0xFF001649),
                onTap: () {
                  key.currentState?.reverseAnimation();
                  print("Circular menu item");
                  Get.to(() => UploadVlogScreen());
                }),

            CircularMenuItem(
                boxShadow: [],
                iconSize: 18,
                icon: Icons.edit_note_outlined,
                color: Color(0xFF001649),
                onTap: () {
                  print("Circular menu item");
                  key.currentState?.reverseAnimation();
                  Get.to(() => const UploadBlogScreen());
                }),

            CircularMenuItem(
                color: Colors.transparent,
                onTap: () {
                }
            ),


          ],
          backgroundWidget: Stack(
            children: [
              Scaffold(
                bottomNavigationBar: Container(
                    width: double.infinity,
                    height: 95.0.adaptSize,
                    padding: EdgeInsets.symmetric(horizontal: 16.aw, vertical: 0.ah),
                    decoration: BoxDecoration(
                      color: const Color(0xFF001649),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0.aw, right: 8.aw),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _selectedIndex == 0
                              ? Container(
                            height: 38.adaptSize,
                            width: 38.adaptSize,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: IconButton(
                              icon: Image.asset(
                                'assets/image/ichome.png',
                              ),
                              onPressed: () => _onItemTapped(0),
                            ),
                          )
                              : Container(
                            height: 38.adaptSize,
                            width: 38.adaptSize,
                            decoration: const BoxDecoration(
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
                          _selectedIndex == 1
                              ? Container(
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
                          ) : Container(
                            height: 38.adaptSize,
                            width: 38.adaptSize,
                            child: IconButton(
                              icon: Image.asset(
                                'assets/image/Icon.png',
                              ),
                              onPressed: () => _onItemTapped(1),
                            ),
                          ),

                          SizedBox(
                            height: 70.adaptSize,
                            width: 70.adaptSize,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                    child: Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(200),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(6.adaptSize),
                                          child: Icon(
                                            Icons.add,
                                            color: Color(0xFF001649),
                                            size: 35,
                                          ),
                                        ),
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),

                          _selectedIndex == 3
                              ? Container(
                            height: 38.adaptSize,
                            width: 38.adaptSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: IconButton(
                              icon: Image.asset(
                                'assets/image/proIcon.png',
                              ),
                              onPressed: () => _onItemTapped(3),
                            ),
                          ): Container(
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

                          _selectedIndex == 4
                              ? Container(
                            height: 38.adaptSize,
                            width: 38.adaptSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: IconButton(
                              icon: Image.asset('assets/image/personVector.png'),
                              onPressed: () => _onItemTapped(4),
                            ),
                          ): Container(
                            height: 38.adaptSize,
                            width: 38.adaptSize,
                            child: IconButton(
                              icon: Image.asset('assets/image/Vector.png',
                                color: Colors.white),
                              onPressed: () => _onItemTapped(4),
                            ),
                          ),
                        ],
                      ),
                    )),
                body: Center(child: _items[_selectedIndex]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCircularMenuItem extends StatefulWidget {
  final Color color;
  final double size;
  final VoidCallback onTap;
  final Widget child;

  const CustomCircularMenuItem({
    super.key,
    required this.color,
    required this.onTap,
    required this.child,
    this.size = 50,
  });

  @override
  State<CustomCircularMenuItem> createState() => _CustomCircularMenuItemState();
}

class _CustomCircularMenuItemState extends State<CustomCircularMenuItem>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.9),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 150),
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
          ),
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}
