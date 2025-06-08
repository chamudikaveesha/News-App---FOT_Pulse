// import 'package:flutter/material.dart';
// import 'package:animate_do/animate_do.dart';
// import '../widgets/animated_logo.dart';
// import '../utils/colors.dart';
// import 'login_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     );

//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
//     ));

//     _scaleAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
//     ));

//     _controller.forward();
    
//     // Navigate to login screen after animation
//     Future.delayed(const Duration(seconds: 4), () {
//       if (mounted) {
//         Navigator.pushReplacement(
//           context,
//           PageRouteBuilder(
//             pageBuilder: (context, animation, secondaryAnimation) =>
//                 const LoginScreen(),
//             transitionsBuilder:
//                 (context, animation, secondaryAnimation, child) {
//               return FadeTransition(opacity: animation, child: child);
//             },
//             transitionDuration: const Duration(milliseconds: 800),
//           ),
//         );
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: AppColors.backgroundGradient,
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Animated Logo
//               AnimatedBuilder(
//                 animation: _controller,
//                 builder: (context, child) {
//                   return Transform.scale(
//                     scale: _scaleAnimation.value,
//                     child: Opacity(
//                       opacity: _fadeAnimation.value,
//                       child: const AnimatedLogo(size: 120),
//                     ),
//                   );
//                 },
//               ),
              
//               const SizedBox(height: 40),
              
//               // App Title with Animation
//               FadeInUp(
//                 delay: const Duration(milliseconds: 800),
//                 duration: const Duration(milliseconds: 1200),
//                 child: Text(
//                   'FOT Pulse',
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.textPrimary,
//                     shadows: [
//                       Shadow(
//                         offset: const Offset(0, 2),
//                         blurRadius: 4,
//                         color: Colors.black.withOpacity(0.1),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
              
//               const SizedBox(height: 16),
              
//               // Subtitle
//               FadeInUp(
//                 delay: const Duration(milliseconds: 1200),
//                 duration: const Duration(milliseconds: 1200),
//                 child: Text(
//                   'Welcome to your learning journey',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: AppColors.textSecondary,
//                     fontWeight: FontWeight.w300,
//                   ),
//                 ),
//               ),
              
//               const SizedBox(height: 80),
              
//               // Loading Animation
//               FadeInUp(
//                 delay: const Duration(milliseconds: 1600),
//                 duration: const Duration(milliseconds: 1200),
//                 child: SizedBox(
//                   width: 40,
//                   height: 40,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 3,
//                     valueColor: AlwaysStoppedAnimation<Color>(
//                       AppColors.primaryBlue.withOpacity(0.8),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../widgets/animated_logo.dart';
import '../utils/colors.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _finalScaleAnimation;
  late Animation<double> _gradientAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // Stage 1: Logo fade & scale in (0.0 - 0.3)
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.3, curve: Curves.easeInOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.1, 0.3, curve: Curves.elasticOut),
    ));

    // Stage 2: Logo rotation (0.3 - 0.6)
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.6, curve: Curves.easeInOut),
    ));

    // Stage 3: Final scale adjustment (0.6 - 0.7)
    _finalScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.6, 0.7, curve: Curves.elasticOut),
    ));

    // Stage 4: Gradient fade in (0.7 - 1.0)
    _gradientAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.7, 1.0, curve: Curves.easeInOut),
    ));

    _controller.forward();
    
    // Navigate to login screen after animation
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LoginScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              // Start with black, then fade to gradient
              color: _gradientAnimation.value < 0.1 
                  ? Colors.black 
                  : null,
              gradient: _gradientAnimation.value > 0.1
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.backgroundGradient.colors[0].withOpacity(_gradientAnimation.value),
                        AppColors.backgroundGradient.colors[1].withOpacity(_gradientAnimation.value),
                      ],
                    )
                  : null,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Logo with all transformations
                  Transform.scale(
                    scale: _scaleAnimation.value * _finalScaleAnimation.value,
                    child: Transform.rotate(
                      angle: _rotationAnimation.value * 2 * 3.14159, // 360 degrees
                      child: Opacity(
                        opacity: _fadeAnimation.value,
                        child: const AnimatedLogo(size: 120),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // App Title with delayed animation (only after gradient appears)
                  Opacity(
                    opacity: _gradientAnimation.value > 0.5 ? 1.0 : 0.0,
                    child: FadeInUp(
                      delay: Duration(milliseconds: (_gradientAnimation.value > 0.5 ? 200 : 2000).round()),
                      duration: const Duration(milliseconds: 800),
                      child: Text(
                        'FOT Pulse',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          shadows: [
                            Shadow(
                              offset: const Offset(0, 2),
                              blurRadius: 4,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Subtitle (only after gradient appears)
                  Opacity(
                    opacity: _gradientAnimation.value > 0.7 ? 1.0 : 0.0,
                    child: FadeInUp(
                      delay: Duration(milliseconds: (_gradientAnimation.value > 0.7 ? 400 : 2000).round()),
                      duration: const Duration(milliseconds: 800),
                      child: Text(
                        'Welcome to your News App',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 80),
                  
                  // Loading Animation (only after gradient appears)
                  Opacity(
                    opacity: _gradientAnimation.value > 0.8 ? 1.0 : 0.0,
                    child: FadeInUp(
                      delay: Duration(milliseconds: (_gradientAnimation.value > 0.8 ? 600 : 2000).round()),
                      duration: const Duration(milliseconds: 800),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryBlue.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}