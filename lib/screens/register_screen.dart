// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:animate_do/animate_do.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({Key? key}) : super(key: key);

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   bool _isPasswordVisible = false;
//   bool _isConfirmPasswordVisible = false;
//   bool _isLoading = false;

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final double headerHeight = size.height * 0.20;
//     const double iconDiameter = 100;
//     const double iconOverlap = iconDiameter / 2;

//     return Scaffold(
//       backgroundColor: const Color(0xFF121212),
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
//                   // Header space + profile icon
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
//                   Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         FadeInDown(
//                           delay: const Duration(milliseconds: 200),
//                           duration: const Duration(milliseconds: 800),
//                           child: Text(
//                             'Sign Up',
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
//                             "Let's Get You Started",
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.inter(
//                               fontSize: 16,
//                               color: Colors.grey[400],
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 40),

//                         // Username Field
//                         FadeInLeft(
//                           delay: const Duration(milliseconds: 600),
//                           duration: const Duration(milliseconds: 800),
//                           child: _buildModernTextField(
//                             hintText: 'Username',
//                             prefixIcon: Icons.person_outline,
//                             controller: _usernameController,
//                             validator: (v) =>
//                                 (v == null || v.isEmpty)
//                                     ? 'Please enter a username'
//                                     : null,
//                           ),
//                         ),
//                         const SizedBox(height: 20),

//                         // Email Field
//                         FadeInRight(
//                           delay: const Duration(milliseconds: 700),
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
//                         FadeInLeft(
//                           delay: const Duration(milliseconds: 800),
//                           duration: const Duration(milliseconds: 800),
//                           child: _buildModernTextField(
//                             hintText: 'Password',
//                             prefixIcon: Icons.lock_outline,
//                             controller: _passwordController,
//                             obscureText: !_isPasswordVisible,
//                             suffixIcon: _isPasswordVisible
//                                 ? Icons.visibility_off_outlined
//                                 : Icons.visibility_outlined,
//                             onSuffixIconPressed: () =>
//                                 setState(() => _isPasswordVisible = !_isPasswordVisible),
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

//                         // Confirm Password Field
//                         FadeInRight(
//                           delay: const Duration(milliseconds: 900),
//                           duration: const Duration(milliseconds: 800),
//                           child: _buildModernTextField(
//                             hintText: 'Confirm Password',
//                             prefixIcon: Icons.lock_outline,
//                             controller: _confirmPasswordController,
//                             obscureText: !_isConfirmPasswordVisible,
//                             suffixIcon: _isConfirmPasswordVisible
//                                 ? Icons.visibility_off_outlined
//                                 : Icons.visibility_outlined,
//                             onSuffixIconPressed: () =>
//                                 setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
//                             validator: (v) {
//                               if (v == null || v.isEmpty) {
//                                 return 'Please confirm your password';
//                               }
//                               if (v != _passwordController.text) {
//                                 return 'Passwords do not match';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         const SizedBox(height: 32),

//                         // Register button
//                         FadeInUp(
//                           delay: const Duration(milliseconds: 1000),
//                           duration: const Duration(milliseconds: 800),
//                           child: _buildModernButton(
//                             text: 'Register',
//                             onPressed: _handleRegister,
//                             isLoading: _isLoading,
//                           ),
//                         ),
//                         const SizedBox(height: 20),

//                         // Google button
//                         FadeInUp(
//                           delay: const Duration(milliseconds: 1100),
//                           duration: const Duration(milliseconds: 800),
//                           child: _buildGoogleButton(),
//                         ),
//                         const SizedBox(height: 32),

//                         // Sign in link
//                         FadeInUp(
//                           delay: const Duration(milliseconds: 1200),
//                           duration: const Duration(milliseconds: 800),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Already have an account? ',
//                                 style: GoogleFonts.inter(
//                                   color: Colors.grey[400],
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () => Navigator.pop(context),
//                                 child: Text(
//                                   'Sign In',
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

//   // Modern Profile Circle (100x100, consistent with Login)
//   Widget _buildModernProfileCircle() => Container(
//         width: 100,
//         height: 100,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(
//             color: Colors.redAccent,
//             width: 3,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.redAccent.withOpacity(0.3),
//               blurRadius: 20,
//               spreadRadius: 2,
//             ),
//           ],
//         ),
//         child: CircleAvatar(
//           radius: 47,
//           backgroundColor: const Color(0xFF2A2A2A),
//           child: Icon(
//             Icons.person,
//             color: Colors.grey[300],
//             size: 50,
//           ),
//         ),
//       );

//   // Modern TextField (sizing, borders, and font matching Login)
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
//       height: 60,
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
//       child: Center(
//         child: TextFormField(
//           controller: controller,
//           keyboardType: keyboardType,
//           obscureText: obscureText,
//           validator: validator,
//           style: GoogleFonts.inter(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//           ),
//           decoration: InputDecoration(
//             hintText: hintText,
//             hintStyle: GoogleFonts.inter(
//               color: Colors.grey[500],
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//             prefixIcon: Container(
//               padding: const EdgeInsets.all(12),
//               margin: const EdgeInsets.only(right: 12, left: 4),
//               decoration: BoxDecoration(
//                 color: Colors.grey[800],
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(
//                 prefixIcon,
//                 color: Colors.redAccent,
//                 size: 20,
//               ),
//             ),
//             suffixIcon: suffixIcon != null
//                 ? IconButton(
//                     icon: Icon(
//                       suffixIcon,
//                       color: Colors.grey[500],
//                       size: 20,
//                     ),
//                     onPressed: onSuffixIconPressed,
//                   )
//                 : null,
//             border: InputBorder.none,
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 20,
//               vertical: 20,
//             ),
//             errorStyle: GoogleFonts.inter(
//               color: Colors.redAccent,
//               fontSize: 12,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Modern Button with gradient (matches Login)
//   Widget _buildModernButton({
//     required String text,
//     required VoidCallback onPressed,
//     bool isLoading = false,
//   }) {
//     return SizedBox(
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

//   // Google Button
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
//               'Sign Up With Google',
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

//   // Registration logic with modern snackbar
//   void _handleRegister() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() => _isLoading = true);

//       try {
//         await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: _emailController.text.trim(),
//           password: _passwordController.text,
//         );

//         // Update display name
//         await FirebaseAuth.instance.currentUser!
//             .updateDisplayName(_usernameController.text.trim());

//         setState(() => _isLoading = false);

//         // Registration successful
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Row(
//               children: [
//                 const Icon(Icons.check_circle, color: Colors.white),
//                 const SizedBox(width: 12),
//                 Text(
//                   'Registration successful!',
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

//         Navigator.pop(context);
//       } on FirebaseAuthException catch (e) {
//         setState(() => _isLoading = false);
//         String message = '';
//         if (e.code == 'email-already-in-use') {
//           message = 'This email is already registered!';
//         } else if (e.code == 'invalid-email') {
//           message = 'The email address is invalid.';
//         } else if (e.code == 'weak-password') {
//           message = 'Password should be at least 6 characters.';
//         } else {
//           message = e.message ?? 'Registration failed. Try again.';
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
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
                  // Header space + profile icon
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
                        FadeInDown(
                          delay: const Duration(milliseconds: 200),
                          duration: const Duration(milliseconds: 800),
                          child: Text(
                            'Sign Up',
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
                            "Let's Get You Started",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Username Field
                        FadeInLeft(
                          delay: const Duration(milliseconds: 600),
                          duration: const Duration(milliseconds: 800),
                          child: _buildModernTextField(
                            hintText: 'Username',
                            prefixIcon: Icons.person_outline,
                            controller: _usernameController,
                            validator: (v) =>
                                (v == null || v.isEmpty)
                                    ? 'Please enter a username'
                                    : null,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Email Field
                        FadeInRight(
                          delay: const Duration(milliseconds: 700),
                          duration: const Duration(milliseconds: 800),
                          child: _buildModernTextField(
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

                        // Password Field
                        FadeInLeft(
                          delay: const Duration(milliseconds: 800),
                          duration: const Duration(milliseconds: 800),
                          child: _buildModernTextField(
                            hintText: 'Password',
                            prefixIcon: Icons.lock_outline,
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            suffixIcon: _isPasswordVisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            onSuffixIconPressed: () =>
                                setState(() => _isPasswordVisible = !_isPasswordVisible),
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
                        const SizedBox(height: 20),

                        // Confirm Password Field
                        FadeInRight(
                          delay: const Duration(milliseconds: 900),
                          duration: const Duration(milliseconds: 800),
                          child: _buildModernTextField(
                            hintText: 'Confirm Password',
                            prefixIcon: Icons.lock_outline,
                            controller: _confirmPasswordController,
                            obscureText: !_isConfirmPasswordVisible,
                            suffixIcon: _isConfirmPasswordVisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            onSuffixIconPressed: () =>
                                setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (v != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Register button
                        FadeInUp(
                          delay: const Duration(milliseconds: 1000),
                          duration: const Duration(milliseconds: 800),
                          child: _buildModernButton(
                            text: 'Register',
                            onPressed: _handleRegister,
                            isLoading: _isLoading,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Google button
                        FadeInUp(
                          delay: const Duration(milliseconds: 1100),
                          duration: const Duration(milliseconds: 800),
                          child: _buildGoogleButton(),
                        ),
                        const SizedBox(height: 32),

                        // Sign in link
                        FadeInUp(
                          delay: const Duration(milliseconds: 1200),
                          duration: const Duration(milliseconds: 800),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account? ',
                                style: GoogleFonts.inter(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Text(
                                  'Sign In',
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

  // Modern Profile Circle (100x100, consistent with Login)
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

  // Modern TextField with external error display
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 60, // Fixed height back for consistency
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
          child: Center(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              validator: validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                // Hide the default error text
                errorStyle: const TextStyle(height: 0, fontSize: 0),
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
        ),
        // External error message display
        FormField<String>(
          validator: validator,
          builder: (FormFieldState<String> field) {
            final errorText = validator?.call(controller?.text);
            return errorText != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 6, left: 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 14,
                          color: Colors.redAccent,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            errorText,
                            style: GoogleFonts.inter(
                              color: Colors.redAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  // Modern Button with gradient (matches Login)
  Widget _buildModernButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return SizedBox(
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

  // Google Button
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
              'Sign Up With Google',
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

  // Registration logic with modern snackbar
  void _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

        // Update display name
        await FirebaseAuth.instance.currentUser!
            .updateDisplayName(_usernameController.text.trim());

        setState(() => _isLoading = false);

        // Registration successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Text(
                  'Registration successful!',
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

        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        setState(() => _isLoading = false);
        String message = '';
        if (e.code == 'email-already-in-use') {
          message = 'This email is already registered!';
        } else if (e.code == 'invalid-email') {
          message = 'The email address is invalid.';
        } else if (e.code == 'weak-password') {
          message = 'Password should be at least 6 characters.';
        } else {
          message = e.message ?? 'Registration failed. Try again.';
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
}

