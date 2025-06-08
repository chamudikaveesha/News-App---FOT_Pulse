// import 'package:flutter/material.dart';
// import 'package:animate_do/animate_do.dart';
// import '../widgets/custom_button.dart';
// import '../widgets/custom_text_field.dart';
// import '../widgets/animated_logo.dart';
// import '../utils/colors.dart';
// import 'register_screen.dart';
// import 'forgot_password_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _isPasswordVisible = false;
//   bool _rememberMe = false;
//   bool _isLoading = false;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _handleLogin() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() => _isLoading = true);

//       // Simulate API call
//       await Future.delayed(const Duration(seconds: 2));

//       setState(() => _isLoading = false);

//       // Show success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text('Login successful!'),
//           backgroundColor: AppColors.successColor,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       );
//     }
//   }

// void _navigateToRegister() {
//   Navigator.push(
//     context,
//     PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) =>
//           const RegisterScreen(),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(1.0, 0.0);
//         const end = Offset.zero;
//         const curve = Curves.ease;

//         var tween = Tween(begin: begin, end: end).chain(
//           CurveTween(curve: curve),
//         );

//         return SlideTransition(
//           position: animation.drive(tween),
//           child: child,
//         );
//       },
//     ),
//   );
// }

// void _navigateToForgotPassword() {
//   Navigator.push(
//     context,
//     PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) =>
//           const ForgotPasswordScreen(),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         return FadeTransition(opacity: animation, child: child);
//       },
//     ),
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: AppColors.backgroundGradient,
//           image: const DecorationImage(
//             image: AssetImage('assets/shape1.png'), // <- add to pubspec.yaml
//             alignment: Alignment.topCenter,
//             fit: BoxFit.fitWidth,
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 40),

//                     // Logo
//                     FadeInDown(
//                       duration: const Duration(milliseconds: 800),
//                       child: const AnimatedLogo(size: 80),
//                     ),

//                     const SizedBox(height: 32),

//                     // Welcome Text
//                     FadeInDown(
//                       delay: const Duration(milliseconds: 200),
//                       duration: const Duration(milliseconds: 800),
//                       child: Text(
//                         'Welcome Back!',
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.textPrimary,
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 8),

//                     FadeInDown(
//                       delay: const Duration(milliseconds: 400),
//                       duration: const Duration(milliseconds: 800),
//                       child: Text(
//                         'Enter your email and password',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: AppColors.textSecondary,
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 40),

//                     // Email Field
//                     FadeInLeft(
//                       delay: const Duration(milliseconds: 600),
//                       duration: const Duration(milliseconds: 800),
//                       child: CustomTextField(
//                         hintText: 'Email',
//                         prefixIcon: Icons.email_outlined,
//                         keyboardType: TextInputType.emailAddress,
//                         controller: _emailController,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your email';
//                           }
//                           if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                               .hasMatch(value)) {
//                             return 'Please enter a valid email';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     // Password Field
//                     FadeInRight(
//                       delay: const Duration(milliseconds: 800),
//                       duration: const Duration(milliseconds: 800),
//                       child: CustomTextField(
//                         hintText: 'Password',
//                         prefixIcon: Icons.lock_outline,
//                         suffixIcon: _isPasswordVisible
//                             ? Icons.visibility_off_outlined
//                             : Icons.visibility_outlined,
//                         obscureText: !_isPasswordVisible,
//                         controller: _passwordController,
//                         onSuffixIconPressed: () {
//                           setState(() {
//                             _isPasswordVisible = !_isPasswordVisible;
//                           });
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your password';
//                           }
//                           if (value.length < 6) {
//                             return 'Password must be at least 6 characters';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),

//                     const SizedBox(height: 16),

//                     // Remember Me & Forgot Password
//                     FadeInUp(
//                       delay: const Duration(milliseconds: 1000),
//                       duration: const Duration(milliseconds: 800),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Transform.scale(
//                                 scale: 0.9,
//                                 child: Checkbox(
//                                   value: _rememberMe,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _rememberMe = value ?? false;
//                                     });
//                                   },
//                                   activeColor: AppColors.primaryBlue,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(4),
//                                   ),
//                                 ),
//                               ),
//                               Text(
//                                 'Remember me',
//                                 style: TextStyle(
//                                   color: AppColors.textSecondary,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           GestureDetector(
//                             onTap: _navigateToForgotPassword,
//                             child: Text(
//                               'Forgot Password?',
//                               style: TextStyle(
//                                 color: AppColors.primaryBlue,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 32),

//                     // Login Button
//                     FadeInUp(
//                       delay: const Duration(milliseconds: 1200),
//                       duration: const Duration(milliseconds: 800),
//                       child: CustomButton(
//                         text: 'Log In',
//                         onPressed: _handleLogin,
//                         isLoading: _isLoading,
//                       ),
//                     ),

//                     const SizedBox(height: 24),

//                     // Google Login Button
//                     FadeInUp(
//                       delay: const Duration(milliseconds: 1400),
//                       duration: const Duration(milliseconds: 800),
//                       child: CustomButton(
//                         text: 'Log In With Google',
//                         onPressed: () {
//                           // Handle Google login
//                         },
//                         isSecondary: true,
//                       ),
//                     ),

//                     const SizedBox(height: 32),

//                     // Social Login Icons
//                     FadeInUp(
//                       delay: const Duration(milliseconds: 1600),
//                       duration: const Duration(milliseconds: 800),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           _buildSocialIcon(Icons.facebook, Colors.blue[600]!),
//                           const SizedBox(width: 20),
//                           _buildSocialIcon(Icons.g_mobiledata, Colors.red[600]!),
//                           const SizedBox(width: 20),
//                           _buildSocialIcon(Icons.apple, Colors.black),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 40),

//                     // Sign Up Link
//                     FadeInUp(
//                       delay: const Duration(milliseconds: 1800),
//                       duration: const Duration(milliseconds: 800),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Don't have an account? ",
//                             style: TextStyle(
//                               color: AppColors.textSecondary,
//                               fontSize: 16,
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: _navigateToRegister,
//                             child: Text(
//                               'Sign Up',
//                               style: TextStyle(
//                                 color: AppColors.primaryBlue,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 32),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSocialIcon(IconData icon, Color color) {
//     return GestureDetector(
//       onTap: () {
//         // Handle social login
//       },
//       child: Container(
//         width: 50,
//         height: 50,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Icon(
//           icon,
//           color: color,
//           size: 28,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fotpulse/screens/home_screen.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../utils/colors.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ───────────────────────────────────────────────────
  //  Business logic (unchanged)
  // ───────────────────────────────────────────────────
  void _handleLogin() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Login successful!'),
            backgroundColor: AppColors.successColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        // TODO: Navigate to home screen here!
      } on FirebaseAuthException catch (e) {
        setState(() => _isLoading = false);
        String message = '';
        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided.';
        } else {
          message = e.message ?? 'Login failed';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder:
            (context, animation, secondaryAnimation) => const RegisterScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  void _navigateToForgotPassword() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder:
            (context, animation, secondaryAnimation) =>
                const ForgotPasswordScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double headerHeight = size.height * 0.20; // like RegisterScreen
    const double iconDiameter = 80;
    const double iconOverlap = iconDiameter / 2;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // gradient: AppColors.backgroundGradient,
          image: DecorationImage(
            image: AssetImage('assets/shape1.png'),
            alignment: Alignment.topCenter,
            fit: BoxFit.fitWidth,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // top system-bar padding already handled by SafeArea

                  // ── header space + animated person icon ──
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      SizedBox(width: double.infinity, height: headerHeight),
                      Positioned(
                        top: headerHeight - iconOverlap,
                        child: FadeInDown(
                          duration: const Duration(milliseconds: 800),
                          child: _buildProfileCircle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),

                  // ── form starts here ──
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Welcome headline
                        FadeInDown(
                          delay: const Duration(milliseconds: 200),
                          duration: const Duration(milliseconds: 800),
                          child: Text(
                            'Welcome Back!',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        FadeInDown(
                          delay: const Duration(milliseconds: 400),
                          duration: const Duration(milliseconds: 800),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Enter your email and password',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Email
                        FadeInLeft(
                          delay: const Duration(milliseconds: 600),
                          duration: const Duration(milliseconds: 800),
                          child: CustomTextField(
                            hintText: 'Email',
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(v)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Password
                        FadeInRight(
                          delay: const Duration(milliseconds: 800),
                          duration: const Duration(milliseconds: 800),
                          child: CustomTextField(
                            hintText: 'Password',
                            prefixIcon: Icons.lock_outline,
                            suffixIcon:
                                _isPasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                            obscureText: !_isPasswordVisible,
                            controller: _passwordController,
                            onSuffixIconPressed:
                                () => setState(
                                  () =>
                                      _isPasswordVisible = !_isPasswordVisible,
                                ),
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (v.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Remember & forgot
                        FadeInUp(
                          delay: const Duration(milliseconds: 1000),
                          duration: const Duration(milliseconds: 800),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Transform.scale(
                                    scale: 0.9,
                                    child: Checkbox(
                                      value: _rememberMe,
                                      onChanged:
                                          (v) => setState(
                                            () => _rememberMe = v ?? false,
                                          ),
                                      activeColor: AppColors.primaryBlue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Remember me',
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: _navigateToForgotPassword,
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: AppColors.primaryBlue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Login button
                        FadeInUp(
                          delay: const Duration(milliseconds: 1200),
                          duration: const Duration(milliseconds: 800),
                          child: CustomButton(
                            text: 'Log In',
                            onPressed: _handleLogin,
                            isLoading: _isLoading,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Google button
                        FadeInUp(
                          delay: const Duration(milliseconds: 1400),
                          duration: const Duration(milliseconds: 800),
                          child: SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed:
                                  () => ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(
                                    const SnackBar(
                                      content: Text('Google sign in clicked!'),
                                    ),
                                  ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE3F2FD),
                                foregroundColor: Colors.black87,
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/google_logo.png',
                                    height: 24,
                                    width: 24,
                                  ),
                                  const SizedBox(width: 24),
                                  const Text(
                                    'Log In With Google',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Sign-up link
                        FadeInUp(
                          delay: const Duration(milliseconds: 1800),
                          duration: const Duration(milliseconds: 800),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 16,
                                ),
                              ),
                              GestureDetector(
                                onTap: _navigateToRegister,
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: AppColors.primaryBlue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  //  Helper widgets
  // ─────────────────────────────────────────────────────────
  Widget _buildProfileCircle() => Container(
    width: 80,
    height: 80,
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: const Icon(Icons.person, color: Color(0xFF4A90E2), size: 70),
  );

  Widget _buildSocialIcon(IconData icon, Color color) => GestureDetector(
    onTap: () {
      // Handle social login
    },
    child: Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, color: color, size: 28),
    ),
  );
}
