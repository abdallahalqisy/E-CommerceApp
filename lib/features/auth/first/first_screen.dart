import 'package:fashionapp/features/onbordung/onbording_page.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool isRegisterHovered = false;
  bool isLoginHovered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.darken,
              ),
              image: const AssetImage(
                'assets/images/start.png',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 500),
                const Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'Welcome to GemStore!\nThe Home for A Fashionista',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                MaterialButton(
                  minWidth: 220,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  splashColor: Colors.black,
                  color: Colors.grey.withOpacity(.9),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OnBoardingPage(),
                      ),
                    );
                  },
                  child: const Text('Get Started',
                      style: TextStyle(color: Colors.white)),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     // Register Button without Animation
                //     InkWell(
                //       onHover: (hovering) {
                //         setState(() {
                //           isRegisterHovered = hovering;
                //         });
                //       },
                //       onTap: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => RegisterScreen(),
                //           ),
                //         );
                //       },
                //       child: Container(
                //         width: 100,
                //         height: 45,
                //         decoration: BoxDecoration(
                //           color: secondaryColor,
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         child: const Center(
                //           child: Text(
                //             'Register',
                //             style: TextStyle(
                //               color: Colors.white,
                //               fontSize: 18,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     // Login Button without Animation
                //     InkWell(
                //       onHover: (hovering) {
                //         setState(() {
                //           isLoginHovered = hovering;
                //         });
                //       },
                //       onTap: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => LoginScreen(),
                //           ),
                //         );
                //       },
                //       child: Container(
                //         width: 100,
                //         height: 45,
                //         decoration: BoxDecoration(
                //           color: secondaryColor,
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         child: const Center(
                //           child: Text(
                //             'Login',
                //             style: TextStyle(
                //               color: Colors.white,
                //               fontSize: 18,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
