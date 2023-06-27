import 'package:flutter/material.dart';
import 'package:modernland_signflow/pages/splash/splash_screen.dart';

class ModernlandInitialPage extends StatefulWidget {
  const ModernlandInitialPage({Key? key}) : super(key: key);

  @override
  State<ModernlandInitialPage> createState() => _ModernlandInitialPageState();
}

class _ModernlandInitialPageState extends State<ModernlandInitialPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInToLinear,
    );
    _animationController.forward().whenComplete(() {
      // Navigation to next page after 5 seconds
      navigateToNextPage();
    });
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }



  void navigateToNextPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => SplashScreenPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set your desired background color here
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Expanded(
            flex: MediaQuery.of(context).size.width > 600 ? 3 : 10,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  margin: EdgeInsets.all(250),
                  child: Image.asset(
                    "asset/img/icons/logo_modernland.png",
                    width: constraints.maxWidth,
                  ),
                );
              },
            ),
          ), // Replace with your logo image
        ),
      ),
    );
  }
}