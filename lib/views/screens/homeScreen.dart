import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:toktik/constants.dart';
import 'package:toktik/utils/rive_utils.dart';
import 'package:toktik/views/screens/add_video_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class RiveAsset {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAsset({
    required this.src,
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    this.input,
  });

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> buttomNav = [
  RiveAsset(
    src: 'lib/images/icons.riv',
    artboard: 'HOME',
    stateMachineName: 'HOME_Interactivity',
    title: 'Home',
  ),
  RiveAsset(
    src: 'lib/images/icons.riv',
    artboard: 'SEARCH',
    stateMachineName: 'SEARCH_Interactivity',
    title: 'Search',
  ),
  RiveAsset(
    src: 'lib/images/icons.riv',
    artboard: 'SETTINGS',
    stateMachineName: 'SETTINGS_Interactivity',
    title: 'Add Video',
  ),
  RiveAsset(
    src: 'lib/images/icons.riv',
    artboard: 'USER',
    stateMachineName: 'USER_Interactivity',
    title: 'Profile',
  ),
];

class _HomeScreenState extends State<HomeScreen> {
  RiveAsset selectedPage = buttomNav.first;
  int pageIdx = 0;
  double ops = 0.8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 340),
          // margin: const EdgeInsets.symmetric(horizontal: 24),
          margin: const EdgeInsets.only(left: 40, right: 10, bottom: 15),

          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: backgroundColorDark.withOpacity(ops),
            borderRadius: const BorderRadius.all(
              Radius.circular(24),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                4,
                (index) => GestureDetector(
                  onTap: () {
                    ops = 0.8;

                    pageIdx = index;
                    buttomNav[index].input?.change(true);

                    if (buttomNav[index] != selectedPage) {
                      setState(() {
                        selectedPage = buttomNav[index];
                      });
                    }
                    Future.delayed(
                      const Duration(seconds: 1),
                      () {
                        setState(() {});
                        buttomNav[index].input?.change(false);
                      },
                    );
                    Future.delayed(
                      const Duration(milliseconds: 3500),
                      () {
                        setState(() {
                          ops = 0.35;
                        });
                      },
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedBar(
                        isActive: buttomNav[index] == selectedPage,
                      ),
                      SizedBox(
                        height: 36,
                        width: 36,
                        child: Opacity(
                          opacity: buttomNav[index] == selectedPage ? 1 : 0.5,
                          child: RiveAnimation.asset(
                            buttomNav.first.src,
                            artboard: buttomNav[index].artboard,
                            onInit: (artboard) {
                              StateMachineController controller =
                                  RiveUtils.getRiveController(
                                artboard,
                                stateMachineName:
                                    buttomNav[index].stateMachineName,
                              );
                              buttomNav[index].input =
                                  controller.findSMI('active') as SMIBool;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: pages[pageIdx],
    );
    // return Scaffold(
    //   bottomNavigationBar: BottomNavigationBar(
    //     onTap: (idx) {
    //       setState(() {
    //         pageIdx = idx;
    //       });
    //     },
    //     currentIndex: pageIdx,
    //     type: BottomNavigationBarType.fixed,
    //     backgroundColor: Colors.black,
    //     selectedItemColor: buttonColor,
    //     unselectedItemColor: Colors.white,
    //     items: const [
    //       BottomNavigationBarItem(
    //         icon: Icon(
    //           Icons.home,
    //           size: 30,
    //         ),
    //         label: 'Home',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(
    //           Icons.search,
    //           size: 30,
    //         ),
    //         label: 'Search',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: CustomIcon(),
    //         label: '',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(
    //           Icons.person,
    //           size: 30,
    //         ),
    //         label: 'Profile',
    //       ),
    //     ],
    //   ),
    // body: pages[pageIdx],
    // );
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: const BoxDecoration(
        color: Color(0xFF81B4FF),
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}
