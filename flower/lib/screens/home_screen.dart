import 'package:flutter/material.dart';
import 'AppColor.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Images/fl.jpg'), // Replace with your background image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 32),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6, // 60% height
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Text(
                            'Want to Buy Flowers?',
                            style: TextStyle(
                              fontFamily: 'Inter', // Use the font you prefer
                              fontWeight: FontWeight.w700,
                              fontSize: 32,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          "flowerss.....",
                          style: TextStyle(color: Colors.black                    ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Get Started Button
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: ElevatedButton(
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                color: AppColor.secondary, // Define your secondary color
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                              ),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                isScrollControlled: true,
                                builder: (context) {
                                  return RegisterScreen(); // Your registration modal
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ), backgroundColor: AppColor.primarySoft, // Define your primary soft color
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        // Log in Button
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: OutlinedButton(
                            child: Text(
                              'Log in',
                              style: TextStyle(
                                color: AppColor.secondary, // Define your secondary color
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                              ),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                isScrollControlled: true,
                                builder: (context) {
                                  return LoginScreen(); // Your login modal
                                },
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white, shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: BorderSide(
                                color: AppColor.secondary.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          margin: EdgeInsets.only(top: 32),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'join us ',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                height: 150 / 100,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Terms of service ',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontWeight: FontWeight.w700,
                                    height: 150 / 100,
                                  ),
                                ),
                                TextSpan(
                                  text: 'and ',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    height: 150 / 100,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Privacy policy.',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontWeight: FontWeight.w700,
                                    height: 150 / 100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
