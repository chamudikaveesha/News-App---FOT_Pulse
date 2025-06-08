import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    final double headerHeight =
        size.height * 0.16; // ← shrink from 0.30 to 0.10
    const double iconDiameter = 80; // icon container is 80 × 80
    const double iconOverlap = iconDiameter / 2; // we want half to overlap

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/shape1.png'),
            alignment: Alignment.topCenter,
            fit: BoxFit.fitWidth,
          ),
        ),
        // SafeArea kept (remove if you don’t need it)
        child: SafeArea(
          child: Column(
            children: [
              // ── fake status-bar row ──
              _buildFakeStatusBar(),

              // ── header + icon ──
              Stack(
                clipBehavior: Clip.none, // allow overflow
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                    // reserve header space
                    width: double.infinity,
                    height: headerHeight,
                  ),
                  Positioned(
                    // icon overlaps header
                    top: headerHeight - iconOverlap,
                    child: _buildProfileCircle(),
                  ),
                ],
              ),

              // ── form card ──
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ), // was 60 → 40
                  child: _buildFormCard(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -----------------------------------------------------------------
  //  Small helper widgets (unchanged business logic)
  // -----------------------------------------------------------------
  Widget _buildFakeStatusBar() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '9:41',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: const [
            Icon(Icons.signal_cellular_4_bar, color: Colors.white, size: 18),
            SizedBox(width: 5),
            Icon(Icons.wifi, color: Colors.white, size: 18),
            SizedBox(width: 5),
            Icon(Icons.battery_std, color: Colors.white, size: 18),
          ],
        ),
      ],
    ),
  );

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

  Widget _buildFormCard(BuildContext context) {
    // (exact same as before) …
    //               ↓↓↓  OMITTED FOR BREVITY  ↓↓↓
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Align(
  alignment: Alignment.centerLeft,            // left-align inside the card
  child: const Text(
    "Let's Get You Started",
    textAlign: TextAlign.left,                // (defensive) left text-align
    style: TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.bold,            // make it bold
    ),
  ),
),
            const SizedBox(height: 30),
            // … all your text-fields & buttons stay the same …
            // (no edits below this line)
            _buildTextField(
              controller: _usernameController,
              label: 'Username',
              hint: 'chamudi kaveesha',
              icon: Icons.person_outline,
              validator:
                  (v) =>
                      (v == null || v.isEmpty)
                          ? 'Please enter a username'
                          : null,
            ),
            const SizedBox(height: 15),
            _buildTextField(
              controller: _emailController,
              label: 'Email',
              hint: 'chamudikavayaka@gmail.com',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Please enter an email';
                final ok = RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(v);
                return ok ? null : 'Please enter a valid email';
              },
            ),
            const SizedBox(height: 15),
            _buildTextField(
              controller: _passwordController,
              label: 'Password',
              hint: '••••••••••••••',
              icon: Icons.lock_outline,
              isPassword: true,
              isPasswordVisible: _isPasswordVisible,
              onTogglePassword:
                  () =>
                      setState(() => _isPasswordVisible = !_isPasswordVisible),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Please enter a password';
                return v.length < 6
                    ? 'Password must be at least 6 characters'
                    : null;
              },
            ),
            const SizedBox(height: 15),
            _buildTextField(
              controller: _confirmPasswordController,
              label: 'Confirm Password',
              hint: '••••••••••••••',
              icon: Icons.lock_outline,
              isPassword: true,
              isPasswordVisible: _isConfirmPasswordVisible,
              onTogglePassword:
                  () => setState(
                    () =>
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible,
                  ),
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return 'Please confirm your password';
                }
                return v != _passwordController.text
                    ? 'Passwords do not match'
                    : null;
              },
            ),
            const SizedBox(height: 30),
            // Register button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
  if (_formKey.currentState!.validate()) {
    // Optionally: Show a loading indicator

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Optionally, update display name
      await FirebaseAuth.instance.currentUser!.updateDisplayName(_usernameController.text.trim());

      // Registration successful! Show success & navigate or pop
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to login or home
      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {
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
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    }
  }
},

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A90E2),
                  foregroundColor: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Google sign-in button…
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed:
                    () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Google sign in clicked!')),
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

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already Have An Account ? ',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Color(0xFF4A90E2),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onTogglePassword,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: const Color(0xFFFFE082), width: 1),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && !isPasswordVisible,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.grey[600]),
          suffixIcon:
              isPassword
                  ? IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey[600],
                    ),
                    onPressed: onTogglePassword,
                  )
                  : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          labelStyle: TextStyle(
            color: Colors.grey[700],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';

// class WavePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint =
//         Paint()
//           ..shader = const LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0x80FFFFFF), Color(0x40FFFFFF), Colors.transparent],
//           ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

//     // First wave layer
//     final path1 = Path();
//     path1.moveTo(0, size.height * 0.3);
//     path1.quadraticBezierTo(
//       size.width * 0.20,
//       size.height * 0.25,
//       size.width * 0.5,
//       size.height * 0.35,
//     );
//     path1.quadraticBezierTo(
//       size.width * 0.10,
//       size.height * 0.15, 
//       size.width * 0.2,
//       size.height * 0.05,
//     );
//     path1.lineTo(size.width, size.height);
//     path1.lineTo(0, size.height);
//     path1.close();

//     canvas.drawPath(path1, paint);

//     // Second wave layer
//     final paint2 =
//         Paint()
//           ..shader = const LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0x60FFFFFF), Color(0x20FFFFFF), Colors.transparent],
//           ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

//     final path2 = Path();
//     path2.moveTo(0, size.height * 0.4);
//     path2.quadraticBezierTo(
//       size.width * 0.3,
//       size.height * 0.35,
//       size.width * 0.6,
//       size.height * 0.45,
//     );
//     path2.quadraticBezierTo(
//       size.width * 0.8,
//       size.height * 0.55,
//       size.width,
//       size.height * 0.4,
//     );
//     path2.lineTo(size.width, size.height);
//     path2.lineTo(0, size.height);
//     path2.close();

//     canvas.drawPath(path2, paint2);

//     // Third wave layer
//     final paint3 =
//         Paint()
//           ..shader = const LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0x40FFFFFF), Color(0x10FFFFFF), Colors.transparent],
//           ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

//     final path3 = Path();
//     path3.moveTo(0, size.height * 0.5);
//     path3.quadraticBezierTo(
//       size.width * 0.2,
//       size.height * 0.45,
//       size.width * 0.4,
//       size.height * 0.55,
//     );
//     path3.quadraticBezierTo(
//       size.width * 0.7,
//       size.height * 0.65,
//       size.width,
//       size.height * 0.5,
//     );
//     path3.lineTo(size.width, size.height);
//     path3.lineTo(0, size.height);
//     path3.close();

//     canvas.drawPath(path3, paint3);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

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
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0xFF4A90E2), Color(0xFFFFA726)],
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               // Status bar area
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 10,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       '9:41',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     Row(
//                       children: const [
//                         Icon(
//                           Icons.signal_cellular_4_bar,
//                           color: Colors.white,
//                           size: 18,
//                         ),
//                         SizedBox(width: 5),
//                         Icon(Icons.wifi, color: Colors.white, size: 18),
//                         SizedBox(width: 5),
//                         Icon(Icons.battery_std, color: Colors.white, size: 18),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               const Spacer(),

//               // Main content with wave overlay
//               Stack(
//                 children: [
//                   // Background waves extending from gradient
//                   Positioned.fill(child: CustomPaint(painter: WavePainter())),

//                   // Main content card
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Column(
//                       children: [
//                         // Top spacing for wave area
//                         const SizedBox(height: 80),

//                         // Profile icon positioned over waves
//                         Container(
//                           width: 80,
//                           height: 80,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(40),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.15),
//                                 blurRadius: 15,
//                                 offset: const Offset(0, 8),
//                               ),
//                             ],
//                           ),
//                           child: const Icon(
//                             Icons.person,
//                             color: Color(0xFF4A90E2),
//                             size: 40,
//                           ),
//                         ),

//                         const SizedBox(height: 20),

//                         // White container with content
//                         Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.all(30),
//                           decoration: BoxDecoration(
//                             color: Colors.transparent,
//                             borderRadius: BorderRadius.circular(25),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.1),
//                                 blurRadius: 20,
//                                 offset: const Offset(0, 10),
//                               ),
//                             ],
//                           ),
//                           child: Form(
//                             key: _formKey,
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 // Sign Up text
//                                 const Text(
//                                   'Sign Up',
//                                   style: TextStyle(
//                                     fontSize: 24,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black87,
//                                   ),
//                                 ),

//                                 const SizedBox(height: 8),

//                                 // Let's Get You Started text
//                                 const Text(
//                                   "Let's Get You Started",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.grey,
//                                   ),
//                                 ),

//                                 const SizedBox(height: 30),

//                                 // Username field
//                                 _buildTextField(
//                                   controller: _usernameController,
//                                   label: 'Username',
//                                   hint: 'chamudi kaveesha',
//                                   icon: Icons.person_outline,
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Please enter a username';
//                                     }
//                                     return null;
//                                   },
//                                 ),

//                                 const SizedBox(height: 15),

//                                 // Email field
//                                 _buildTextField(
//                                   controller: _emailController,
//                                   label: 'Email',
//                                   hint: 'chamudikavayaka@gmail.com',
//                                   icon: Icons.email_outlined,
//                                   keyboardType: TextInputType.emailAddress,
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Please enter an email';
//                                     }
//                                     if (!RegExp(
//                                       r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
//                                     ).hasMatch(value)) {
//                                       return 'Please enter a valid email';
//                                     }
//                                     return null;
//                                   },
//                                 ),

//                                 const SizedBox(height: 15),

//                                 // Password field
//                                 _buildTextField(
//                                   controller: _passwordController,
//                                   label: 'Password',
//                                   hint: '••••••••••••••',
//                                   icon: Icons.lock_outline,
//                                   isPassword: true,
//                                   isPasswordVisible: _isPasswordVisible,
//                                   onTogglePassword: () {
//                                     setState(() {
//                                       _isPasswordVisible = !_isPasswordVisible;
//                                     });
//                                   },
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Please enter a password';
//                                     }
//                                     if (value.length < 6) {
//                                       return 'Password must be at least 6 characters';
//                                     }
//                                     return null;
//                                   },
//                                 ),

//                                 const SizedBox(height: 15),

//                                 // Confirm Password field
//                                 _buildTextField(
//                                   controller: _confirmPasswordController,
//                                   label: 'Confirm Password',
//                                   hint: '••••••••••••••',
//                                   icon: Icons.lock_outline,
//                                   isPassword: true,
//                                   isPasswordVisible: _isConfirmPasswordVisible,
//                                   onTogglePassword: () {
//                                     setState(() {
//                                       _isConfirmPasswordVisible =
//                                           !_isConfirmPasswordVisible;
//                                     });
//                                   },
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Please confirm your password';
//                                     }
//                                     if (value != _passwordController.text) {
//                                       return 'Passwords do not match';
//                                     }
//                                     return null;
//                                   },
//                                 ),

//                                 const SizedBox(height: 30),

//                                 // Register button
//                                 SizedBox(
//                                   width: double.infinity,
//                                   height: 55,
//                                   child: ElevatedButton(
//                                     onPressed: () {
//                                       if (_formKey.currentState!.validate()) {
//                                         // Handle registration logic here
//                                         ScaffoldMessenger.of(
//                                           context,
//                                         ).showSnackBar(
//                                           const SnackBar(
//                                             content: Text(
//                                               'Registration successful!',
//                                             ),
//                                             backgroundColor: Colors.green,
//                                           ),
//                                         );
//                                       }
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: const Color(0xFF4A90E2),
//                                       foregroundColor: Colors.white,
//                                       elevation: 3,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(25),
//                                       ),
//                                     ),
//                                     child: const Text(
//                                       'Register',
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ),
//                                 ),

//                                 const SizedBox(height: 15),

//                                 // Google sign in button
//                                 SizedBox(
//                                   width: double.infinity,
//                                   height: 55,
//                                   child: ElevatedButton.icon(
//                                     onPressed: () {
//                                       // Handle Google sign in logic here
//                                       ScaffoldMessenger.of(
//                                         context,
//                                       ).showSnackBar(
//                                         const SnackBar(
//                                           content: Text(
//                                             'Google sign in clicked!',
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: const Color(0xFFE3F2FD),
//                                       foregroundColor: Colors.black87,
//                                       elevation: 1,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(25),
//                                       ),
//                                     ),
//                                     icon: Image.asset(
//                                       'assets/images/google_logo.png',
//                                       height: 24,
//                                       width: 24,
//                                       errorBuilder: (
//                                         context,
//                                         error,
//                                         stackTrace,
//                                       ) {
//                                         return const Icon(
//                                           Icons.g_mobiledata,
//                                           color: Color(0xFF4285F4),
//                                           size: 24,
//                                         );
//                                       },
//                                     ),
//                                     label: const Text(
//                                       'Log In With Google',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                 ),

//                                 const SizedBox(height: 20),

//                                 // Already have account
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Text(
//                                       'Already Have An Account ? ',
//                                       style: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         // Navigate to sign in screen
//                                         Navigator.pop(context);
//                                       },
//                                       child: const Text(
//                                         'Sign In',
//                                         style: TextStyle(
//                                           color: Color(0xFF4A90E2),
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 50),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required String hint,
//     required IconData icon,
//     bool isPassword = false,
//     bool isPasswordVisible = false,
//     VoidCallback? onTogglePassword,
//     TextInputType? keyboardType,
//     String? Function(String?)? validator,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFFFFF8E1),
//         borderRadius: BorderRadius.circular(25),
//         border: Border.all(color: const Color(0xFFFFE082), width: 1),
//       ),
//       child: TextFormField(
//         controller: controller,
//         obscureText: isPassword && !isPasswordVisible,
//         keyboardType: keyboardType,
//         validator: validator,
//         decoration: InputDecoration(
//           labelText: label,
//           hintText: hint,
//           prefixIcon: Icon(icon, color: Colors.grey[600]),
//           suffixIcon:
//               isPassword
//                   ? IconButton(
//                     icon: Icon(
//                       isPasswordVisible
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                       color: Colors.grey[600],
//                     ),
//                     onPressed: onTogglePassword,
//                   )
//                   : null,
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 15,
//           ),
//           labelStyle: TextStyle(
//             color: Colors.grey[700],
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//           ),
//           hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';

// class RegisterScreen extends StatelessWidget {
//   const RegisterScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//       ),
//       body: Stack(
//         children: [
//           // ── Gradient header with the tighter-matched wave ──
//           SizedBox(
//             height: 260,
//             width: double.infinity,
//             child: ClipPath(
//               clipper: _ExactWaveClipper(),
//               child: Container(
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Color(0xFF2176DF), // top blue
//                       Color(0xFF5F867D), // dusty green mid
//                       Color(0xFFF0BE17), // golden yellow bottom
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // ── Page content ──
//           SafeArea(
//             child: Column(
//               children: [
//                 const SizedBox(height: 82),
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 12,
//                         color: Colors.black26,
//                         offset: Offset(0, 4),
//                       )
//                     ],
//                   ),
//                   child: const Icon(
//                     Icons.person,
//                     size: 64,
//                     color: Color(0xFF42A5F5),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 const Text(
//                   'Sign Up',
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Let’s Get You Started',
//                   style: TextStyle(fontSize: 16, color: Colors.black54),
//                 ),
//                 const SizedBox(height: 32),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24),
//                   child: Column(
//                     children: [
//                       TextField(decoration: _decoration('Full Name')),
//                       const SizedBox(height: 16),
//                       TextField(
//                         decoration: _decoration('Email'),
//                         keyboardType: TextInputType.emailAddress,
//                       ),
//                       const SizedBox(height: 16),
//                       TextField(
//                         decoration: _decoration('Password'),
//                         obscureText: true,
//                       ),
//                       const SizedBox(height: 32),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         onPressed: () {},
//                         child: const Text('Create Account'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   static InputDecoration _decoration(String label) => InputDecoration(
//         labelText: label,
//         filled: true,
//         fillColor: Colors.grey[100],
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//       );
// }

// /// Matches the screenshot’s low left dip ➜ gentle rise under avatar ➜
// /// small crest ➜ taper toward the right.
// class _ExactWaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final w = size.width;
//     final h = size.height;
//     final path = Path()..lineTo(0, h * 0.85); // deep left trough

//     // Long smooth rise
//     path.cubicTo(
//       w * 0.08, h * 0.65,   // control-1
//       w * 0.18, h * 0.58,   // control-2
//       w * 0.30, h * 0.66,   // anchor-1 (sub-peak)
//     );

//     // Shallow dip just left of the avatar
//     path.cubicTo(
//       w * 0.38, h * 0.72,   // c-1
//       w * 0.44, h * 0.82,   // c-2
//       w * 0.50, h * 0.78,   // anchor-2 (small valley)
//     );

//     // Rise under the avatar toward right crest
//     path.cubicTo(
//       w * 0.60, h * 0.68,   // c-1
//       w * 0.70, h * 0.60,   // c-2
//       w * 0.80, h * 0.66,   // anchor-3 (right crest)
//     );

//     // Gentle fall to the right edge
//     path.cubicTo(
//       w * 0.90, h * 0.70,
//       w * 0.96, h * 0.70,
//       w,       h * 0.68,
//     );

//     path.lineTo(w, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
