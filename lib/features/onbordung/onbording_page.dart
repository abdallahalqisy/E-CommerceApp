import 'package:fashionapp/core/shared/constans/constans.dart';
import 'package:fashionapp/features/auth/register/register_screen.dart';
import 'package:fashionapp/layout/layout_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (_) => token != null && token!.isNotEmpty
              ? const LayoutScreen()
              : RegisterScreen()),
    );
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/images/start.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,
      // globalHeader: Align(
      //   alignment: Alignment.topRight,
      //   child:
      // // SafeArea(
      // //     // child: Padding(
      // //     //   padding: const EdgeInsets.only(top: 16, right: 16),
      // //     //   child: _buildImage('assets/images/onbordingimage1.png', 100),
      // //     // ),
      // //   ),
      // // ),
      // // globalFooter: SizedBox(
      // //   width: double.infinity,
      // //   height: 60,
      // //   child: ElevatedButton(
      // //     child: const Text(
      // //       'Let\'s go right away!',
      // //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      // //     ),
      // //     onPressed: () => _onIntroEnd(context),
      // //   ),
      // ),
      pages: [
        PageViewModel(
          title: "Discover Something New",
          body: "Special New Arrivals Just For You",
          image: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: _buildImage('assets/images/onbordingimage1.png'),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Updata Trendy Outfits",
          body: "Favourite Brands And Hottest Trends ",
          image: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: _buildImage('assets/images/onbordingimage2.png'),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Explore Your True Style",
          body: "Relax And let Us Bring The Style To You",
          image: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: _buildImage('assets/images/onbordingimage3.png'),
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
