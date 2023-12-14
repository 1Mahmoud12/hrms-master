import 'dart:async';

import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

int _curr = 0;

PageController controller = PageController();
List<Widget> _list = <Widget>[
  const SliderWidgetTab(
    backbool: true,
    titletext: 'Welcome to our world',
    imagename: 'assets/images/about.jpg',
    paratext1: [],
    design: 1,
  ),
  const SliderWidgetTab(
    backbool: false,
    titletext: 'Redefining Luxury Real Estate',
    imagename: 'assets/images/mission-1.jpg',
    paratext1: [],
    design: 0,
  ),
  const SliderWidgetTab(
    backbool: true,
    titletext: 'Welcome to Rak elevators',
    imagename: 'assets/images/partnership.jpg',
    paratext1: [],
    design: 1,
  ),
];

class _SliderWidgetState extends State<SliderWidget> with WidgetsBindingObserver {
  late Timer _timer;

  // final List<AppLifecycleState> _stateHistoryList = <AppLifecycleState>[];
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // if (WidgetsBinding.instance.lifecycleState != null) {
    //   _stateHistoryList.add(WidgetsBinding.instance.lifecycleState!);
    // }

    startTimer();
    super.initState();
    debugPrint('Slider call');
    // debugPrint("${AppLifecycleState.inactive == true}");
  }

  void _stopTimer() {
    _timer.cancel();
  }

  void startTimer() {
    setState(() {
      _curr = 0;
    });
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      setState(() {
        // debugPrint("Slider calling  $_curr ${_curr < 3}");

        if (_curr < 2) {
          _curr++;

          controller.animateToPage(_curr, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        } else {
          _curr = 0;
          controller.animateToPage(_curr, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        }
      });
    });
  }

  @override
  void dispose() {
    // debugPrint("$_stateHistoryList");
    WidgetsBinding.instance.removeObserver(this);

    debugPrint('Slider call dispose');
    _stopTimer();
    super.dispose();
  }

  // void deactivate() {
  //   debugPrint("Slider call deactivate");
  //   _stopTimer();
  //   super.dispose();

  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   setState(() {
  //     debugPrint("currrent stateis $state");

  //     if (!(state == AppLifecycleState.resumed)) {
  //       _stopTimer();
  //     } else {
  //       if (_timer == null) {
  //         startTimer();
  //       }
  //     }
  //     // _isVisible = state == AppLifecycleState.resumed;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // if (!(_stateHistoryList[0] == AppLifecycleState.resumed)) {
    //   _stopTimer();
    // } else {
    //   if (_timer == null) {
    //     startTimer();
    //   }
    // }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          // width: MediaQuery.of(context).size.width * .9,
          height: context.screenHeight * .22,
          child: PageView(
            controller: controller,
            onPageChanged: (int num) {
              setState(() {
                _curr = num;
              });
            },
            children: _list,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: List<Widget>.generate(
        //       _list.length,
        //       (index) => Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 2),
        //             child: InkWell(
        //               onTap: () {
        //                 controller.animateToPage(index,
        //                     duration: const Duration(milliseconds: 300),
        //                     curve: Curves.easeIn);
        //               },
        //               child: _curr == index
        //                   ? Icon(
        //                       Icons.circle,
        //                       size: 10,
        //                       color: ColorConstraints.primarycolor,
        //                     )
        //                   : Icon(
        //                       Icons.circle,
        //                       size: 10,
        //                       color: ColorConstraints.primarycolor.withOpacity(-.2),
        //                     ),
        //             ),
        //           )),
        // ),
      ],
    );
  }
}

class SliderWidgetTab extends StatefulWidget {
  final String? titletext;
  final String imagename;
  final List? paratext1;

  final bool? backbool;
  final int? design;

  const SliderWidgetTab({super.key, this.titletext, required this.imagename, this.paratext1, this.backbool, this.design});

  @override
  State<SliderWidgetTab> createState() => _SliderWidgetTabState();
}

class _SliderWidgetTabState extends State<SliderWidgetTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30.r),
              image: DecorationImage(
                image: AssetImage(widget.imagename),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: Center(
              child: Text(
                '${widget.titletext}',
                style: Styles.style18700.copyWith(color: AppColors.white),
              ),
            ),
          ),
          // Positioned(
          //   // top: 11,
          //   top: 0,
          //   right: 0,
          //   bottom: 0,
          //   // left: 19,
          //   // right: null,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Text(
          //         "${widget.titletext}",
          //         style: TextStyle(
          //             fontSize: 19,
          //             fontWeight: FontWeight.w700,
          //             color: ColorConstraints.white),
          //       ),
          //       Container(
          //         width: MediaQuery.of(context).size.width * 0.5,
          //         child: ListView.builder(
          //             physics: NeverScrollableScrollPhysics(),
          //             shrinkWrap: true,
          //             itemCount: widget.paratext1.length,
          //             itemBuilder: ((context, index) =>
          //                 Row(mainAxisSize: MainAxisSize.min, children: [
          //                   Icon(
          //                     Icons.circle,
          //                     color: ColorConstraints.white,
          //                     size: 7,
          //                   ),
          //                   SizedBox(
          //                     width: 10,
          //                   ),
          //                   Text(
          //                     "${widget.paratext1[index]}",
          //                     style: TextStyle(
          //                         fontSize: 12,
          //                         fontWeight: FontWeight.w400,
          //                         color: ColorConstraints.white),
          //                   ),
          //                 ]))),
          //       ),
          //       SizedBox(
          //         height: 10,
          //       ),
          //        ],
          //   ),
          // )
        ],
      ),
    );
  }
}
