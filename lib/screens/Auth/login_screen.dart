import 'package:al_khair/Widgets/circle_avatar_row.dart';
import 'package:al_khair/Widgets/custom_button.dart';
import 'package:al_khair/Widgets/custom_text_field.dart';
import 'package:al_khair/screens/Auth/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _buttonColorAnimation;
  late Animation<Offset> _avatarSlideAnimation;
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

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _buttonColorAnimation =
        ColorTween(begin: Colors.grey, end: const Color(0xFFFFDB6B)).animate(
            CurvedAnimation(
                parent: _animationController, curve: Curves.easeInOut));

    // For avatar slide-in
    _avatarSlideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    // Button scale effect
    _buttonScaleAnimation = Tween<double>(begin: 1, end: 1.1).animate(
        CurvedAnimation(
            parent: _animationController, curve: Curves.elasticOut));

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
                      hintText: "Password",
                      prefixIcon: Icons.lock,
                      isPassword: true,
                      controller: passwordController,
                      obscureText: obscurePassword,
                      toggleVisibility: togglePasswordVisibility,
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Signupscreen()),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don’t have an account ",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFFFFDB6B),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SlideTransition(
                    position: _avatarSlideAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: CircleAvatarRow(
                        avatars: [
                          AvatarData(
                            radius: 30.0,
                            imagePath: 'assets/images/apple.jpg',
                            onTap: () => print("Apple tapped"),
                          ),
                          AvatarData(
                            radius: 40.0,
                            imagePath: 'assets/images/google.jpg',
                            onTap: () => print("Google tapped"),
                          ),
                          AvatarData(
                            radius: 30.0,
                            imagePath: 'assets/images/facebook.jpg',
                            onTap: () => print("Facebook tapped"),
                          ),
                        ],
                      ),
                    ),
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
          Positioned(
            bottom: 120,
            left: 100,
            right: 100,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return GestureDetector(
                  onTap: onLoginPressed,
                  child: Transform.scale(
                    scale: _buttonScaleAnimation.value,
                    child: CustomElevatedButton(
                      text: "Login",
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
          ),
        ],
      ),
    );
  }
}
