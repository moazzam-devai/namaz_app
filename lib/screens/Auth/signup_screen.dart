import 'package:al_khair/Widgets/custom_button.dart';
import 'package:al_khair/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  _SignupscreenState createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool obscurePassword = true;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<Color?> _buttonColorAnimation;
  late Animation<double> _buttonScaleAnimation;

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  void onLoginPressed() {
    print("Login button pressed!");
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _buttonColorAnimation =
        ColorTween(begin: Colors.grey, end: const Color(0xFFFFDB6B)).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _buttonScaleAnimation = Tween<double>(begin: 1, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222933),
      appBar: AppBar(
        backgroundColor: const Color(0xFF222933),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Back icon
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Image.asset(
                    'assets/images/name.png',
                    height: 64,
                    width: 305,
                  ),
                  const SizedBox(height: 40),
                  SlideTransition(
                    position: _slideAnimation,
                    child: CustomTextField(
                      hintText: "Username",
                      prefixIcon: Icons.person,
                      controller: usernameController,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SlideTransition(
                    position: _slideAnimation,
                    child: CustomTextField(
                      hintText: "email",
                      prefixIcon: Icons.email,
                      controller: emailController,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SlideTransition(
                    position: _slideAnimation,
                    child: CustomTextField(
                      hintText: "Password",
                      prefixIcon: Icons.lock,
                      isPassword: true,
                      controller: passwordController,
                      obscureText: obscurePassword,
                      toggleVisibility: togglePasswordVisibility,
                    ),
                  ),
                  const SizedBox(height: 50),
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return GestureDetector(
                        onTap: onLoginPressed,
                        child: Transform.scale(
                          scale: _buttonScaleAnimation.value,
                          child: CustomElevatedButton(
                            text: "Signup",
                            onPressed: onLoginPressed,
                            width: 250,
                            height: 50,
                            color: _buttonColorAnimation.value ?? Colors.grey,
                            borderRadius: 16.0,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Image.asset(
              'assets/images/mas.png',
              height: 300,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }
}
