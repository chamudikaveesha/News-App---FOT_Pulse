
// import 'package:flutter/material.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:fotpulse/screens/home_screen.dart';
// import 'register_screen.dart';
// import 'forgot_password_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';

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

//   // ───────────────────────────────────────────────────
//   //  Business logic (unchanged)
//   // ───────────────────────────────────────────────────
//   void _handleLogin() async {
//     FocusScope.of(context).unfocus();
//     if (_formKey.currentState!.validate()) {
//       setState(() => _isLoading = true);
//       try {
//         await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: _emailController.text.trim(),
//           password: _passwordController.text,
//         );
//         setState(() => _isLoading = false);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Row(
//               children: [
//                 const Icon(Icons.check_circle, color: Colors.white),
//                 const SizedBox(width: 12),
//                 Text(
//                   'Login successful!',
//                   style: GoogleFonts.inter(color: Colors.white),
//                 ),
//               ],
//             ),
//             backgroundColor: Colors.green,
//             behavior: SnackBarBehavior.floating,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         );

//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const HomeScreen()),
//         );
//       } on FirebaseAuthException catch (e) {
//         setState(() => _isLoading = false);
//         String message = '';
//         if (e.code == 'user-not-found') {
//           message = 'No user found for that email.';
//         } else if (e.code == 'wrong-password') {
//           message = 'Wrong password provided.';
//         } else {
//           message = e.message ?? 'Login failed';
//         }
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Row(
//               children: [
//                 const Icon(Icons.error, color: Colors.white),
//                 const SizedBox(width: 12),
//                 Text(
//                   message,
//                   style: GoogleFonts.inter(color: Colors.white),
//                 ),
//               ],
//             ),
//             backgroundColor: Colors.redAccent,
//             behavior: SnackBarBehavior.floating,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         );
//       }
//     }
//   }

//   void _navigateToRegister() {
//     Navigator.push(
//       context,
//       PageRouteBuilder(
//         pageBuilder:
//             (context, animation, secondaryAnimation) => const RegisterScreen(),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           const begin = Offset(1.0, 0.0);
//           const end = Offset.zero;
//           const curve = Curves.ease;

//           var tween = Tween(
//             begin: begin,
//             end: end,
//           ).chain(CurveTween(curve: curve));

//           return SlideTransition(
//             position: animation.drive(tween),
//             child: child,
//           );
//         },
//       ),
//     );
//   }

//   void _navigateToForgotPassword() {
//     Navigator.push(
//       context,
//       PageRouteBuilder(
//         pageBuilder:
//             (context, animation, secondaryAnimation) =>
//                 const ForgotPasswordScreen(),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           return FadeTransition(opacity: animation, child: child);
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final double headerHeight = size.height * 0.20;
//     const double iconDiameter = 100;
//     const double iconOverlap = iconDiameter / 2;

//     return Scaffold(
//       backgroundColor: const Color(0xFF121212), // Dark background like developer screen
//       body: Container(
//         decoration: const BoxDecoration(
//           color: Color(0xFF121212),
//           image: DecorationImage(
//             image: AssetImage('assets/shape1.png'),
//             alignment: Alignment.topCenter,
//             fit: BoxFit.fitWidth,
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Column(
//                 children: [
//                   // ── header space + animated person icon ──
//                   Stack(
//                     clipBehavior: Clip.none,
//                     alignment: Alignment.topCenter,
//                     children: [
//                       SizedBox(width: double.infinity, height: headerHeight),
//                       Positioned(
//                         top: headerHeight - iconOverlap,
//                         child: FadeInDown(
//                           duration: const Duration(milliseconds: 800),
//                           child: _buildModernProfileCircle(),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 60),

//                   // ── form starts here ──
//                   Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         // Welcome headline
//                         FadeInDown(
//                           delay: const Duration(milliseconds: 200),
//                           duration: const Duration(milliseconds: 800),
//                           child: Text(
//                             'Welcome Back!',
//                             style: GoogleFonts.inter(
//                               fontSize: 28,
//                               fontWeight: FontWeight.w700,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         FadeInDown(
//                           delay: const Duration(milliseconds: 400),
//                           duration: const Duration(milliseconds: 800),
//                           child: Text(
//                             'Enter your email and password',
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.inter(
//                               fontSize: 16,
//                               color: Colors.grey[400],
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 40),

//                         // Email Field
//                         FadeInLeft(
//                           delay: const Duration(milliseconds: 600),
//                           duration: const Duration(milliseconds: 800),
//                           child: _buildModernTextField(
//                             hintText: 'Email',
//                             prefixIcon: Icons.email_outlined,
//                             keyboardType: TextInputType.emailAddress,
//                             controller: _emailController,
//                             validator: (v) {
//                               if (v == null || v.isEmpty) {
//                                 return 'Please enter your email';
//                               }
//                               if (!RegExp(
//                                 r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
//                               ).hasMatch(v)) {
//                                 return 'Please enter a valid email';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         const SizedBox(height: 20),

//                         // Password Field
//                         FadeInRight(
//                           delay: const Duration(milliseconds: 800),
//                           duration: const Duration(milliseconds: 800),
//                           child: _buildModernTextField(
//                             hintText: 'Password',
//                             prefixIcon: Icons.lock_outline,
//                             suffixIcon:
//                                 _isPasswordVisible
//                                     ? Icons.visibility_off_outlined
//                                     : Icons.visibility_outlined,
//                             obscureText: !_isPasswordVisible,
//                             controller: _passwordController,
//                             onSuffixIconPressed:
//                                 () => setState(
//                                   () =>
//                                       _isPasswordVisible = !_isPasswordVisible,
//                                 ),
//                             validator: (v) {
//                               if (v == null || v.isEmpty) {
//                                 return 'Please enter your password';
//                               }
//                               if (v.length < 6) {
//                                 return 'Password must be at least 6 characters';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         const SizedBox(height: 20),

//                         // Remember & forgot
//                         FadeInUp(
//                           delay: const Duration(milliseconds: 1000),
//                           duration: const Duration(milliseconds: 800),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   Transform.scale(
//                                     scale: 0.9,
//                                     child: Checkbox(
//                                       value: _rememberMe,
//                                       onChanged:
//                                           (v) => setState(
//                                             () => _rememberMe = v ?? false,
//                                           ),
//                                       activeColor: Colors.redAccent,
//                                       checkColor: Colors.white,
//                                       fillColor: MaterialStateProperty.resolveWith(
//                                         (states) {
//                                           if (states.contains(MaterialState.selected)) {
//                                             return Colors.redAccent;
//                                           }
//                                           return Colors.grey[700];
//                                         },
//                                       ),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(4),
//                                       ),
//                                     ),
//                                   ),
//                                   Text(
//                                     'Remember me',
//                                     style: GoogleFonts.inter(
//                                       color: Colors.grey[400],
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               GestureDetector(
//                                 onTap: _navigateToForgotPassword,
//                                 child: Text(
//                                   'Forgot Password?',
//                                   style: GoogleFonts.inter(
//                                     color: Colors.redAccent,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 32),

//                         // Login button
//                         FadeInUp(
//                           delay: const Duration(milliseconds: 1200),
//                           duration: const Duration(milliseconds: 800),
//                           child: _buildModernButton(
//                             text: 'Log In',
//                             onPressed: _handleLogin,
//                             isLoading: _isLoading,
//                           ),
//                         ),
//                         const SizedBox(height: 20),

//                         // Google button
//                         FadeInUp(
//                           delay: const Duration(milliseconds: 1400),
//                           duration: const Duration(milliseconds: 800),
//                           child: _buildGoogleButton(),
//                         ),
//                         const SizedBox(height: 32),

//                         // Sign-up link
//                         FadeInUp(
//                           delay: const Duration(milliseconds: 1800),
//                           duration: const Duration(milliseconds: 800),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Don't have an account? ",
//                                 style: GoogleFonts.inter(
//                                   color: Colors.grey[400],
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: _navigateToRegister,
//                                 child: Text(
//                                   'Sign Up',
//                                   style: GoogleFonts.inter(
//                                     color: Colors.redAccent,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 32),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // ─────────────────────────────────────────────────────────
//   //  Modern Helper widgets with dark theme
//   // ─────────────────────────────────────────────────────────
//   Widget _buildModernProfileCircle() => Container(
//     width: 100,
//     height: 100,
//     decoration: BoxDecoration(
//       shape: BoxShape.circle,
//       border: Border.all(
//         color: Colors.redAccent,
//         width: 3,
//       ),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.redAccent.withOpacity(0.3),
//           blurRadius: 20,
//           spreadRadius: 2,
//         ),
//       ],
//     ),
//     child: CircleAvatar(
//       radius: 47,
//       backgroundColor: const Color(0xFF2A2A2A),
//       child: Icon(
//         Icons.person,
//         color: Colors.grey[300],
//         size: 50,
//       ),
//     ),
//   );

//   Widget _buildModernTextField({
//     required String hintText,
//     required IconData prefixIcon,
//     IconData? suffixIcon,
//     bool obscureText = false,
//     TextInputType keyboardType = TextInputType.text,
//     TextEditingController? controller,
//     VoidCallback? onSuffixIconPressed,
//     String? Function(String?)? validator,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFF1E1E1E),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey[700]!, width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         obscureText: obscureText,
//         validator: validator,
//         style: GoogleFonts.inter(
//           color: Colors.white,
//           fontSize: 16,
//           fontWeight: FontWeight.w500,
//         ),
//         decoration: InputDecoration(
//           hintText: hintText,
//           hintStyle: GoogleFonts.inter(
//             color: Colors.grey[500],
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//           ),
//           prefixIcon: Container(
//             padding: const EdgeInsets.all(12),
//             margin: const EdgeInsets.only(right: 12, left: 4),
//             decoration: BoxDecoration(
//               color: Colors.grey[800],
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(
//               prefixIcon,
//               color: Colors.redAccent,
//               size: 20,
//             ),
//           ),
//           suffixIcon: suffixIcon != null
//               ? IconButton(
//                   icon: Icon(
//                     suffixIcon,
//                     color: Colors.grey[500],
//                     size: 20,
//                   ),
//                   onPressed: onSuffixIconPressed,
//                 )
//               : null,
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 20,
//           ),
//           errorStyle: GoogleFonts.inter(
//             color: Colors.redAccent,
//             fontSize: 12,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildModernButton({
//     required String text,
//     required VoidCallback onPressed,
//     bool isLoading = false,
//   }) {
//     return Container(
//       width: double.infinity,
//       height: 55,
//       child: ElevatedButton(
//         onPressed: isLoading ? null : onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           padding: EdgeInsets.zero,
//         ),
//         child: Ink(
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [Colors.redAccent, Colors.orangeAccent],
//             ),
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Container(
//             alignment: Alignment.center,
//             child: isLoading
//                 ? const SizedBox(
//                     width: 24,
//                     height: 24,
//                     child: CircularProgressIndicator(
//                       color: Colors.white,
//                       strokeWidth: 2,
//                     ),
//                   )
//                 : Text(
//                     text,
//                     style: GoogleFonts.inter(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildGoogleButton() {
//     return Container(
//       width: double.infinity,
//       height: 55,
//       decoration: BoxDecoration(
//         color: const Color(0xFF1E1E1E),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey[700]!, width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: ElevatedButton(
//         onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Row(
//               children: [
//                 const Icon(Icons.info, color: Colors.white),
//                 const SizedBox(width: 12),
//                 Text(
//                   'Google sign in clicked!',
//                   style: GoogleFonts.inter(color: Colors.white),
//                 ),
//               ],
//             ),
//             backgroundColor: Colors.blueAccent,
//             behavior: SnackBarBehavior.floating,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         ),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.transparent,
//           foregroundColor: Colors.white,
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.grey[800],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Image.asset(
//                 'assets/google_logo.png',
//                 height: 20,
//                 width: 20,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Text(
//               'Log In With Google',
//               style: GoogleFonts.inter(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
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

  // ─── NEW: keys for each TextFormField ───
  final _emailFieldKey = GlobalKey<FormFieldState<String>>();
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();

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
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Text(
                  'Login successful!',
                  style: GoogleFonts.inter(color: Colors.white),
                ),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
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
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 12),
                Text(
                  message,
                  style: GoogleFonts.inter(color: Colors.white),
                ),
              ],
            ),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
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
    final double headerHeight = size.height * 0.20;
    const double iconDiameter = 100;
    const double iconOverlap = iconDiameter / 2;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF121212),
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
                  // ── header + animated icon ──
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      SizedBox(width: double.infinity, height: headerHeight),
                      Positioned(
                        top: headerHeight - iconOverlap,
                        child: FadeInDown(
                          duration: const Duration(milliseconds: 800),
                          child: _buildModernProfileCircle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),

                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Headline
                        FadeInDown(
                          delay: const Duration(milliseconds: 200),
                          duration: const Duration(milliseconds: 800),
                          child: Text(
                            'Welcome Back!',
                            style: GoogleFonts.inter(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        FadeInDown(
                          delay: const Duration(milliseconds: 400),
                          duration: const Duration(milliseconds: 800),
                          child: Text(
                            'Enter your email and password',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),

                        // ── EMAIL FIELD with external error ──
                        FadeInLeft(
                          delay: const Duration(milliseconds: 600),
                          duration: const Duration(milliseconds: 800),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // a) the styled field, but hide its built-in error
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E1E1E),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.grey[700]!, width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  key: _emailFieldKey,
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (v) {
                                    if (v == null || v.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(v)) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: GoogleFonts.inter(
                                      color: Colors.grey[500],
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    prefixIcon: Container(
                                      padding: const EdgeInsets.all(12),
                                      margin: const EdgeInsets.only(right: 12, left: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[800],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Icons.email_outlined,
                                        color: Colors.redAccent,
                                        size: 20,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 20,
                                    ),
                                    // hide built-in error
                                    errorStyle: const TextStyle(height: 0, fontSize: 0),
                                  ),
                                ),
                              ),
                              // b) our external error message
                              Builder(builder: (context) {
                                final errorText = _emailFieldKey.currentState?.errorText;
                                if (errorText == null) return const SizedBox();
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                                  child: Text(
                                    errorText,
                                    style: GoogleFonts.inter(
                                      color: Colors.redAccent,
                                      fontSize: 12,
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // ── PASSWORD FIELD with external error ──
                        FadeInRight(
                          delay: const Duration(milliseconds: 800),
                          duration: const Duration(milliseconds: 800),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E1E1E),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.grey[700]!, width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  key: _passwordFieldKey,
                                  controller: _passwordController,
                                  obscureText: !_isPasswordVisible,
                                  validator: (v) {
                                    if (v == null || v.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    if (v.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: GoogleFonts.inter(
                                      color: Colors.grey[500],
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    prefixIcon: Container(
                                      padding: const EdgeInsets.all(12),
                                      margin: const EdgeInsets.only(right: 12, left: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[800],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Icons.lock_outline,
                                        color: Colors.redAccent,
                                        size: 20,
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: Colors.grey[500],
                                        size: 20,
                                      ),
                                      onPressed: () =>
                                          setState(() => _isPasswordVisible = !_isPasswordVisible),
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 20,
                                    ),
                                    errorStyle: const TextStyle(height: 0, fontSize: 0),
                                  ),
                                ),
                              ),
                              Builder(builder: (context) {
                                final errorText = _passwordFieldKey.currentState?.errorText;
                                if (errorText == null) return const SizedBox();
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                                  child: Text(
                                    errorText,
                                    style: GoogleFonts.inter(
                                      color: Colors.redAccent,
                                      fontSize: 12,
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // ── rest of form… ──
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
                                      activeColor: Colors.redAccent,
                                      checkColor: Colors.white,
                                      fillColor: MaterialStateProperty.resolveWith(
                                        (states) {
                                          if (states.contains(MaterialState.selected)) {
                                            return Colors.redAccent;
                                          }
                                          return Colors.grey[700];
                                        },
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Remember me',
                                    style: GoogleFonts.inter(
                                      color: Colors.grey[400],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: _navigateToForgotPassword,
                                child: Text(
                                  'Forgot Password?',
                                  style: GoogleFonts.inter(
                                    color: Colors.redAccent,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        FadeInUp(
                          delay: const Duration(milliseconds: 1200),
                          duration: const Duration(milliseconds: 800),
                          child: _buildModernButton(
                            text: 'Log In',
                            onPressed: _handleLogin,
                            isLoading: _isLoading,
                          ),
                        ),
                        const SizedBox(height: 20),

                        FadeInUp(
                          delay: const Duration(milliseconds: 1400),
                          duration: const Duration(milliseconds: 800),
                          child: _buildGoogleButton(),
                        ),
                        const SizedBox(height: 32),

                        FadeInUp(
                          delay: const Duration(milliseconds: 1800),
                          duration: const Duration(milliseconds: 800),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: GoogleFonts.inter(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              GestureDetector(
                                onTap: _navigateToRegister,
                                child: Text(
                                  'Sign Up',
                                  style: GoogleFonts.inter(
                                    color: Colors.redAccent,
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
  //  Modern Helper widgets with dark theme (unchanged)
  // ─────────────────────────────────────────────────────────

  Widget _buildModernProfileCircle() => Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Colors.redAccent,
        width: 3,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.redAccent.withOpacity(0.3),
          blurRadius: 20,
          spreadRadius: 2,
        ),
      ],
    ),
    child: CircleAvatar(
      radius: 47,
      backgroundColor: const Color(0xFF2A2A2A),
      child: Icon(
        Icons.person,
        color: Colors.grey[300],
        size: 50,
      ),
    ),
  );

  Widget _buildModernTextField({
    required String hintText,
    required IconData prefixIcon,
    IconData? suffixIcon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    TextEditingController? controller,
    VoidCallback? onSuffixIconPressed,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[700]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.inter(
            color: Colors.grey[500],
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(right: 12, left: 4),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              prefixIcon,
              color: Colors.redAccent,
              size: 20,
            ),
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(
                    suffixIcon,
                    color: Colors.grey[500],
                    size: 20,
                  ),
                  onPressed: onSuffixIconPressed,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          errorStyle: GoogleFonts.inter(
            color: Colors.redAccent,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildModernButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return Container(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.redAccent, Colors.orangeAccent],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            alignment: Alignment.center,
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    text,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleButton() {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[700]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.info, color: Colors.white),
                const SizedBox(width: 12),
                Text(
                  'Google sign in clicked!',
                  style: GoogleFonts.inter(color: Colors.white),
                ),
              ],
            ),
            backgroundColor: Colors.blueAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                'assets/google_logo.png',
                height: 20,
                width: 20,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              'Log In With Google',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}