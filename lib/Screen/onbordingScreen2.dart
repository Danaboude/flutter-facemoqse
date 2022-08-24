import 'package:flutter/material.dart';
import 'package:onboarding_intro_screen/onboarding_screen.dart';

class OnbordingScreen2 extends StatefulWidget {
  static const routeName = '/onbarding2';

  @override
  State<OnbordingScreen2> createState() => _OnbordingScreen2State();
}

class _OnbordingScreen2State extends State<OnbordingScreen2> {
  @override
  Widget build(BuildContext context) {
    var sizedphone = MediaQuery.of(context).size;
    return OnBoardingScreen2(
      onSkip: () {
        debugPrint("On Skip Called....");
      },
      showPrevNextButton: true,
      showIndicator: true,
      backgourndColor: Colors.white,
      activeDotColor: Theme.of(context).primaryColor,
      deactiveDotColor: Colors.grey,
      iconColor: Theme.of(context).primaryColor,
      leftIcon: Icons.arrow_circle_left_rounded,
      rightIcon: Icons.arrow_circle_right_rounded,
      iconSize: 30,
      pages: [
        OnBoardingModel2(
          bodyFontWeight: FontWeight.bold,
          titleFontSize: 13,
          image: Image.asset(
            "assets/images/mosque.png",
            height: sizedphone.height * 0.3,
            width: sizedphone.width * 0.7,
          ),
          title:
              "FaceMosque is the first smart communication system that brings mosques with their visitors, worshipers, the residents of the neighborhood or even the imams together.",
          body:
              " .فايس موسك هو أول نظام تواصل ذكي يجمع المساجد مع روادها سواءً المصلين, العُبَّاد, سكان الحيَّ أو حتى الآئمة معاً",
        ),
        OnBoardingModel2(
          image: Image.asset(
            "assets/images/link.png",
            height: sizedphone.height * 0.3,
            width: sizedphone.width * 0.7,
          ),
          title:
              "This App is directly linked with the hadiths and verses database and allows the user to follow any mosque activity or islamic events.",
          body:
              'ايس موسك مرتبط مباشرة مع قاعدة بيانات يومية لأحاديث وأيات قرآنية ويسمح للمستخدم بمتابعة جميع مستجدات المسجد والأحداث الإسلامي',
        ),
        OnBoardingModel2(
          image: Image.asset(
            "assets/images/bell.png",
            height: sizedphone.height * 0.3,
            width: sizedphone.width * 0.7,
          ),
          title:
              "User can also activate or deactivate the notifications of prayer times and all other events. It is not only an app for prayer timings, it is smart enough to bring your mosque to you.",
          body:
              'لمستخدم يستطيع تفعيل أو إلغاء إشعارات الأذان أو أي إشعارات أخرى, فايس موسك هو ليس فقط برنامج لإظهار مواقيت الصلاة وإنما يتمتع بالذكاء ليجعل مسجدك معك ',
        ),
      ],
    );
  }
}

class OnBoardingModel2 extends StatelessWidget {
  final String? title;
  final String? body;
  final Widget? image;
  final double? titleFontSize;
  final double? bodyFontSize;
  final FontWeight? titleFontWeight;
  final FontWeight? bodyFontWeight;
  final Color? titleColor;
  final Color? bodyColor;

  const OnBoardingModel2({
    Key? key,
    this.title,
    this.body,
    this.image,
    this.titleFontSize = 22,
    this.bodyFontSize = 16,
    this.titleFontWeight = FontWeight.bold,
    this.bodyFontWeight = FontWeight.normal,
    this.titleColor = Colors.black,
    this.bodyColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 10,
          child: SizedBox(
            child: image!,
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Title Text
                Expanded(
                  child: Text(
                    title!,
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    overflow: TextOverflow.fade,
                    softWrap: true,
                    style: TextStyle(
                      color: titleColor,
                      fontSize: titleFontSize,
                      fontWeight: titleFontWeight,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Body Text
                Expanded(
                  child: Text(
                    body!,
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    textScaleFactor: 0.9,
                    overflow: TextOverflow.fade,
                    softWrap: true,
                    style: TextStyle(
                      color: bodyColor,
                      fontSize: bodyFontSize,
                      fontWeight: bodyFontWeight,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class OnBoardingScreen2 extends StatefulWidget {
  // Background Color
  final Color? backgourndColor;

  // Page List of OnBoardingModel class
  final List<OnBoardingModel2> pages;

  // Left Side Icon
  final IconData? leftIcon;

  // Right Side Icon
  final IconData? rightIcon;

  // OnSkip callback
  final VoidCallback onSkip;

  // Animation Duration
  final Duration animationDuration;

  // Icon Size
  final double? iconSize;

  // Icon Color
  final Color? iconColor;

  // Actie Indicator Color
  final Color? activeDotColor;

  // Deactive Indicator Color
  final Color? deactiveDotColor;

  // Show Previous/Next Icons
  final bool? showPrevNextButton;

  // Show Bottom Indicator
  final bool? showIndicator;

  OnBoardingScreen2({
    Key? key,
    required this.pages,
    required this.onSkip,
    this.backgourndColor = Colors.white,
    this.leftIcon = Icons.arrow_circle_left_rounded,
    this.rightIcon = Icons.arrow_circle_right_rounded,
    this.animationDuration = const Duration(milliseconds: 400),
    this.iconSize = 30,
    this.iconColor = Colors.black,
    this.showPrevNextButton = false,
    this.showIndicator = true,
    this.activeDotColor = Colors.blue,
    this.deactiveDotColor = Colors.grey,
  })  : assert(pages.length <= 12,
            (throw Exception("Page Length Must be less than 12"))),
        super(key: key);

  @override
  State<OnBoardingScreen2> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen2> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  final _curve = Curves.easeInOut;
  final _overlayColor = MaterialStateProperty.all(Colors.transparent);

  _nextPage() {
    _pageController.nextPage(
      duration: widget.animationDuration,
      curve: _curve,
    );
  }

  _previousPage() {
    _pageController.previousPage(
      duration: widget.animationDuration,
      curve: _curve,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: widget.backgourndColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 20, top: 15),
              alignment: Alignment.centerRight,
              child: InkWell(
                overlayColor: _overlayColor,
                onTap: widget.onSkip,
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                children: widget.pages,
              ),
            ),
            widget.showPrevNextButton == false && widget.showIndicator == false
                ? const SizedBox()
                : SizedBox(
                    height: size.height * 0.1,
                    width: size.width,
                    child: Row(
                      children: [
                        widget.showPrevNextButton == false
                            ? const SizedBox()
                            : Expanded(
                                flex: 2,
                                child: currentIndex == 0
                                    ? const SizedBox()
                                    : InkWell(
                                        overlayColor: _overlayColor,
                                        onTap: _previousPage,
                                        child: Icon(
                                          widget.leftIcon,
                                          size: widget.iconSize,
                                          color: widget.iconColor,
                                        ),
                                      ),
                              ),
                        widget.showIndicator == false
                            ? const SizedBox()
                            : Expanded(
                                flex: 6,
                                child: Indicator(
                                  pageLenth: widget.pages.length,
                                  currentIndex: currentIndex,
                                  animatioDuration: widget.animationDuration,
                                  curve: _curve,
                                  activeDotColor: widget.activeDotColor,
                                  deactiveDotColor: widget.deactiveDotColor,
                                ),
                              ),

                        // Next Text
                        widget.showPrevNextButton == false
                            ? const SizedBox()
                            : Expanded(
                                flex: 2,
                                child: currentIndex + 1 == widget.pages.length
                                    ? const SizedBox()
                                    : InkWell(
                                        overlayColor: _overlayColor,
                                        onTap: _nextPage,
                                        child: Icon(
                                          widget.rightIcon,
                                          size: widget.iconSize,
                                          color: widget.iconColor,
                                        ),
                                      ),
                              )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
