import 'package:flutter/material.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/upload/post_blogs/post_blog_screen.dart';
import '../../core/utils/pref_utils.dart';
import '../../data/data_sources/remote/api_client.dart';
import '../chat/Pages/chats/chats_screen.dart';
import '../home_screen/home_screen.dart';
import '../search/search_page.dart';
import '../auth/my_profile_view/my_profile_screen.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:get/get.dart';
import '../upload/post_photo_screen/post_photo_screen.dart';
import '../upload/post_video_screen/post_video_screen.dart';
import 'dashboardcontroller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  DashBoardController controller = Get.put(DashBoardController());


  late IO.Socket socket;

  Future<void> connect() async {
    Map<String, dynamic> headers = {
      'Authorization': 'Bearer ${PrefUtils().getAuthToken()}', // Example header
    };
    socket = IO.io(
      ApiClient.mainUrl,
      <String, dynamic>{
        "transports": ["websocket"],
        "extraHeaders": headers,
        "autoConnect": false,
      },
    );
    socket.connect();
    socket.onConnect((data) {
      socket.on("messageReceived", (msg) {
      });
    });
  }













  int _selectedIndex = 0;
  List _items = [
    const HomeScreen(),
    const New(),
    const SizedBox(),
    ChatsScreen(
      chatmodels: [],
    ),
    const MyProfileScreen(),
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
    connect();
    print("line 350");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CircularMenu(
        key: key,
        // toggleButtonPadding: 40,
        alignment: Alignment.bottomCenter,
        toggleButtonSize: 50,
        toggleButtonColor: Colors.transparent,
        toggleButtonIconColor: Colors.transparent,
        toggleButtonMargin: 20,
        radius: 120,
        items: [
          CircularMenuItem(color: Colors.transparent, onTap: () {}),
          CircularMenuItem(
              boxShadow: [],
              iconSize: 20,
              icon: Icons.image_outlined,
              color: const Color(0xffE52C42),
              onTap: () {
                print("Circular menu item");
                key.currentState?.reverseAnimation();
                Get.to(() => const PostPostScreen());
              }),
          CircularMenuItem(
              boxShadow: [],
              iconSize: 20,
              icon: Icons.video_camera_back_outlined,
              color: const Color(0xffE52C42),
              onTap: () {
                key.currentState?.reverseAnimation();
                print("Circular menu item");
                Get.to(() => const PostVideoScreen());
              }),
          CircularMenuItem(
              boxShadow: [],
              iconSize: 18,
              icon: Icons.edit_note_outlined,
              color: const Color(0xffE52C42),
              onTap: () {
                print("Circular menu item");
                key.currentState?.reverseAnimation();
                Get.to(() => const PostBlogScreen());
              }),
          CircularMenuItem(color: Colors.transparent, onTap: () {})
        ],
        backgroundWidget: Stack(
          children: [
            Scaffold(
              bottomNavigationBar: Padding(
                  padding: EdgeInsets.only(
                      bottom: 20.0.ah, left: 10.aw, right: 10.aw),
                  child: Container(
                      width: double.infinity,
                      height: 60.0.adaptSize,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF001649),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 2,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(80),
                        ),
                      ),
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
                                    onPressed: () => _onItemTapped(1),
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
                                )
                              : Container(
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
                                )),
                                // CircularMenu(
                                //   // key: key,
                                //   toggleButtonSize: 25,
                                //   toggleButtonColor: Colors.transparent,
                                //   toggleButtonIconColor: Colors.transparent,
                                //   items: [
                                //     CircularMenuItem(
                                //         color: Colors.transparent, onTap: () {}),
                                //     CircularMenuItem(
                                //         boxShadow: [],
                                //         iconSize: 20,
                                //         icon: Icons.image_outlined,
                                //         color: const Color(0xffE52C42),
                                //         onTap: () {
                                //           print("Circular menu item");
                                //           Get.to(() => const PostPostScreen());
                                //         }),
                                //     CircularMenuItem(
                                //         boxShadow: [],
                                //         iconSize: 20,
                                //         icon: Icons.video_camera_back_outlined,
                                //         color: const Color(0xffE52C42),
                                //         onTap: () {
                                //           print("Circular menu item");
                                //           Get.to(() => const PostVideoScreen());
                                //         }),
                                //     CircularMenuItem(
                                //         boxShadow: [],
                                //         iconSize: 18,
                                //         icon: Icons.edit_note_outlined,
                                //         color: const Color(0xffE52C42),
                                //         onTap: () {
                                //           print("Circular menu item");
                                //           Get.to(() => const PostBlogScreen());
                                //         }),
                                //     CircularMenuItem(
                                //         color: Colors.transparent, onTap: () {})
                                //   ],
                                // ),
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
                                    onPressed: () => _onItemTapped(1),
                                  ),
                                )
                              : Container(
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
                                    icon: Image.asset(
                                      'assets/image/personVector.png',
                                    ),
                                    onPressed: () => _onItemTapped(1),
                                  ),
                                )
                              : Container(
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
                        ],
                      ))),
              body: Center(child: _items[_selectedIndex]),
              // body: CircularMenu(
              //     toggleButtonColor: Colors.transparent,
              //     toggleButtonIconColor: Colors.transparent,
              //     items: [
              //       CircularMenuItem(color: Colors.transparent, onTap: () {}),
              //       CircularMenuItem(
              //           boxShadow: [],
              //           icon: Icons.image_outlined,
              //           color: const Color(0xffE52C42),
              //           onTap: () {
              //             Get.to(() => const PostPostScreen());
              //           }),
              //       CircularMenuItem(
              //           boxShadow: [],
              //           icon: Icons.video_camera_back_outlined,
              //           color: const Color(0xffE52C42),
              //           onTap: () {
              //             Get.to(() => const PostVideoScreen());
              //           }),
              //       CircularMenuItem(
              //           boxShadow: [],
              //           icon: Icons.edit_note_outlined,
              //           color: const Color(0xffE52C42),
              //           onTap: () {
              //             Get.to(() => const PostBlogScreen());
              //           }),
              //       CircularMenuItem(color: Colors.transparent, onTap: () {})
              //     ],
              //     backgroundWidget: Stack(
              //       children: [
              //         // Center(child: _items[_selectedIndex]),
              //         // Obx(() => controller.bottomBarShow.value
              //         //     ? Positioned(
              //         //     bottom: 20.ah,
              //         //     left: 10.aw,
              //         //     right: 10.aw,
              //         //     child: Container(
              //         //       width: 390.aw,
              //         //       height: 61.ah,
              //         //       decoration: BoxDecoration(
              //         //         border: Border.all(
              //         //           width: 1.5,
              //         //           color: Colors.grey,
              //         //         ),
              //         //         borderRadius: BorderRadius.circular(80),
              //         //         color: const Color(0xff001649),
              //         //       ),
              //         //       child: Row(
              //         //         mainAxisAlignment: MainAxisAlignment.spaceAround,
              //         //         children: <Widget>[
              //         //           _selectedIndex == 0 ?
              //         //           Container(
              //         //             height: 38.adaptSize,
              //         //             width: 38.adaptSize,
              //         //             decoration: BoxDecoration(
              //         //               shape: BoxShape.circle,
              //         //               color: Colors.white,
              //         //             ),
              //         //             child: IconButton(
              //         //               icon: Image.asset(
              //         //                 'assets/image/ichome.png',
              //         //               ),
              //         //               onPressed: () => _onItemTapped(1),
              //         //             ),
              //         //           ) :
              //         //           Container(
              //         //             height: 38.adaptSize,
              //         //             width: 38.adaptSize,
              //         //             decoration: BoxDecoration(
              //         //               shape: BoxShape.circle,
              //         //               color: Colors.transparent,
              //         //             ),
              //         //             child: IconButton(
              //         //               icon: Image.asset(
              //         //                 'assets/image/icoohome.png',
              //         //               ),
              //         //               onPressed: () => _onItemTapped(0),
              //         //             ),
              //         //           ),
              //         //
              //         //
              //         //           // Container(
              //         //           //   height: 38.adaptSize,
              //         //           //   width: 38.adaptSize,
              //         //           //   child: IconButton(
              //         //           //     icon: const Icon(
              //         //           //       Icons.home,
              //         //           //       color: Colors.white,
              //         //           //     ),
              //         //           //     onPressed: () => _onItemTapped(0),
              //         //           //   ),
              //         //           // ),
              //         //           // This is necessary to create space in the center
              //         //           _selectedIndex == 1 ?
              //         //           Container(
              //         //             height: 38.adaptSize,
              //         //             width: 38.adaptSize,
              //         //             decoration: BoxDecoration(
              //         //               shape: BoxShape.circle,
              //         //               color: Colors.white,
              //         //             ),
              //         //             child: IconButton(
              //         //               icon: Image.asset(
              //         //                 'assets/image/serch.png',
              //         //
              //         //               ),
              //         //               onPressed: () => _onItemTapped(1),
              //         //             ),
              //         //           ) :
              //         //           Container(
              //         //             height: 38.adaptSize,
              //         //             width: 38.adaptSize,
              //         //             child: IconButton(
              //         //               icon: Image.asset(
              //         //                 'assets/image/Icon.png',
              //         //
              //         //               ),
              //         //               // Icon(Icons.notifications),
              //         //               onPressed: () => _onItemTapped(1),
              //         //             ),
              //         //           ),
              //         //
              //         //           _selectedIndex == 2 ?
              //         //           Container(
              //         //             height: 38.adaptSize,
              //         //             width: 38.adaptSize,
              //         //             decoration: BoxDecoration(
              //         //               shape: BoxShape.circle,
              //         //               color: Colors.white,
              //         //             ),
              //         //             child: IconButton(
              //         //               icon: Image.asset(
              //         //                 'assets/image/ichome.png',
              //         //
              //         //               ),
              //         //
              //         //               onPressed: () => _onItemTapped(1),
              //         //             ),
              //         //           ) :
              //         //           IconButton(
              //         //             icon: Container(
              //         //               height: 43.ah,
              //         //               width: 43.aw,
              //         //               decoration: const BoxDecoration(
              //         //                 color: Colors.white,
              //         //                 shape: BoxShape.circle,
              //         //               ),
              //         //               child: Center(
              //         //                   child: Image.asset(
              //         //                     'assets/image/Union (1).png',
              //         //                     height: 19.ah,
              //         //                     width: 19.aw,
              //         //                   )),
              //         //             ),
              //         //             onPressed: () {},
              //         //           ),
              //         //
              //         //           _selectedIndex == 3 ?
              //         //           Container(
              //         //             height: 38.adaptSize,
              //         //             width: 38.adaptSize,
              //         //             decoration: BoxDecoration(
              //         //               shape: BoxShape.circle,
              //         //               color: Colors.white,
              //         //             ),
              //         //             child: IconButton(
              //         //               icon: Image.asset('assets/image/proIcon.png',
              //         //               ),
              //         //
              //         //               onPressed: () => _onItemTapped(1),
              //         //             ),
              //         //           ) :
              //         //           Container(
              //         //             height: 38.adaptSize,
              //         //             width: 38.adaptSize,
              //         //             child: IconButton(
              //         //               icon: Image.asset(
              //         //                 'assets/image/message_icon.png',
              //         //                 color: Colors.white,
              //         //               ),
              //         //               onPressed: () => _onItemTapped(3),
              //         //             ),
              //         //           ),
              //         //
              //         //           _selectedIndex == 4 ?
              //         //           Container(
              //         //             height: 38.adaptSize,
              //         //             width: 38.adaptSize,
              //         //             decoration: BoxDecoration(
              //         //               shape: BoxShape.circle,
              //         //               color: Colors.white,
              //         //             ),
              //         //             child: IconButton(
              //         //               icon: Image.asset(
              //         //                 'assets/image/personVector.png',
              //         //               ),
              //         //
              //         //               onPressed: () => _onItemTapped(1),
              //         //             ),
              //         //           ) :
              //         //
              //         //           Container(
              //         //             height: 38.adaptSize,
              //         //             width: 38.adaptSize,
              //         //             child: IconButton(
              //         //               icon: Image.asset(
              //         //                 'assets/image/Vector.png',
              //         //                 color: Colors.white,
              //         //               ),
              //         //               onPressed: () => _onItemTapped(4),
              //         //             ),
              //         //           ),
              //         //
              //         //           // Image.asset('assets/image/Vector.png',height: 21.ah,width: 21.aw,color: Colors.white,)
              //         //         ],
              //         //       ),
              //         //     ))
              //         //     : const SizedBox()),
              //       ],
              //     )
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
