import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sportify/shared/sharedComponents/components.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);
  final String image, title, description;

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: demo_data.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => OnboardCard(
                    image: demo_data[index].image,
                    title: demo_data[index].title,
                    description: demo_data[index].description,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                    demo_data.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: DoIndicator(isActive: index == _pageIndex),
                    ),
                  ),
                  const Spacer(),
                  // Conditionally render the button based on whether it's the last page or not
                  if (_pageIndex != demo_data.length - 1)
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: tdefaultcolor,
                        ),
                        child: Image.asset('assets/arrow.png'),
                      ),
                    ),
                ],
              ),
              // Add the button on the last page
              if (_pageIndex == demo_data.length - 1)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: _signupButton(context),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signupButton(BuildContext context) {
    return fButton(
      function: () => Navigator.pushNamed(context, '/welcome'),
      text: 'Get started',
      width: 170,
      height: 50,
      isUpper: true,
    );
  }
}

class OnboardCard extends StatelessWidget {
  const OnboardCard({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);
  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 173),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 232,
                width: 404,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: fdefaultColor,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 12.7,
                  fontWeight: FontWeight.w600,
                  color: sdefaultcolor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoIndicator extends StatelessWidget {
  const DoIndicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
        color: isActive ? sdefaultcolor : sdefaultcolor.withOpacity(.4),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class Onboard {
  final String image, title, description;
  Onboard({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<Onboard> demo_data = [
  Onboard(
    image: "assets/p1.jpeg",
    title: 'Your Gateway to Sports and Fitness',
    description:
        'Join the Movement Towards a Happier & Healthier. With Sportify app, you can easily find players to  play with and reserve courts. ',
  ),
  Onboard(
    image: "assets/p2.jpeg",
    title: 'Start Your Athletic Adventure',
    description:
        'All at Your Fingertips. Get ready to dive into the world of athleticism and wellness. With Sportify, your entire athletic. journey will be just a tap away. ',
  ),
  Onboard(
    image: "assets/p3.png",
    title: 'Book Courts,find players',
    description:
        'Experience the convenience of booking courts and.connecting with fellow players, making scheduling games a breeze. ',
  ),
  Onboard(
    image: "assets/p4.jpeg",
    title: 'Booking Simplified, Playing Amplified',
    description:
        'Effortless Booking, Exciting Matches. Book courts effortlessly and discover players to  join your game all within a few taps of your screen. ',
  ),
  Onboard(
    image: "assets/p5.jpeg",
    title: 'Join a Community of Sport Lovers',
    description:
        'Active Body, Active Mind.Join a diverse community of sports enthusiasts who share your passion, enjoy thrilling athletic experiences,and build lasting connections. ',
  ),
];
