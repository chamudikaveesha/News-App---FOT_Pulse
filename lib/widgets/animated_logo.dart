// import 'package:flutter/material.dart';
// import '../utils/colors.dart';

// class AnimatedLogo extends StatefulWidget {
//   final double size;
  
//   const AnimatedLogo({super.key, this.size = 80});

//   @override
//   State<AnimatedLogo> createState() => _AnimatedLogoState();
// }

// class _AnimatedLogoState extends State<AnimatedLogo>
//     with TickerProviderStateMixin {
//   late AnimationController _rotationController;
//   late AnimationController _pulseController;
//   late Animation<double> _rotationAnimation;
//   late Animation<double> _pulseAnimation;

//   @override
//   void initState() {
//     super.initState();
    
//     _rotationController = AnimationController(
//       duration: const Duration(seconds: 4),
//       vsync: this,
//     );
    
//     _pulseController = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );

//     _rotationAnimation = Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(CurvedAnimation(
//       parent: _rotationController,
//       curve: Curves.easeInOut,
//     ));

//     _pulseAnimation = Tween<double>(
//       begin: 0.9,
//       end: 1.1,
//     ).animate(CurvedAnimation(
//       parent: _pulseController,
//       curve: Curves.easeInOut,
//     ));

//     _rotationController.repeat();
//     _pulseController.repeat(reverse: true);
//   }

//   @override
//   void dispose() {
//     _rotationController.dispose();
//     _pulseController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: Listenable.merge([_rotationController, _pulseController]),
//       builder: (context, child) {
//         return Transform.scale(
//           scale: _pulseAnimation.value,
//           child: RotationTransition(
//             turns: _rotationAnimation,
//             child: Container(
//               width: widget.size,
//               height: widget.size,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.primaryBlue.withOpacity(0.3),
//                     blurRadius: 20,
//                     spreadRadius: 5,
//                   ),
//                 ],
//               ),
//               child: CustomPaint(
//                 painter: LogoPainter(),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class LogoPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 2;

//     // Background circle
//     final backgroundPaint = Paint()
//       ..shader = const LinearGradient(
//         colors: [Colors.white, Color(0xFFF8F9FA)],
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//       ).createShader(Rect.fromCircle(center: center, radius: radius));

//     canvas.drawCircle(center, radius, backgroundPaint);

//     // Draw segments
//     final segmentPaints = [
//       Paint()..color = AppColors.primaryBlue,
//       Paint()..color = AppColors.primaryYellow,
//       Paint()..color = AppColors.primaryOrange,
//       Paint()..color = AppColors.lightBlue,
//     ];

//     const startAngles = [0.0, 90.0, 180.0, 270.0];
//     const sweepAngle = 85.0;

//     for (int i = 0; i < 4; i++) {
//       canvas.drawArc(
//         Rect.fromCircle(center: center, radius: radius * 0.7),
//         (startAngles[i] * 3.14159) / 180,
//         (sweepAngle * 3.14159) / 180,
//         true,
//         segmentPaints[i],
//       );
//     }

//     // Center circle with text
//     final centerPaint = Paint()..color = Colors.white;
//     canvas.drawCircle(center, radius * 0.4, centerPaint);

//     // Draw FOT text
//     final textPainter = TextPainter(
//       text: TextSpan(
//         text: 'FOT\nPulse',
//         style: TextStyle(
//           color: AppColors.textPrimary,
//           fontSize: size.width * 0.15,
//           fontWeight: FontWeight.bold,
//           height: 0.9,
//         ),
//       ),
//       textAlign: TextAlign.center,
//       textDirection: TextDirection.ltr,
//     );

//     textPainter.layout();
//     textPainter.paint(
//       canvas,
//       Offset(
//         center.dx - textPainter.width / 2,
//         center.dy - textPainter.height / 2,
//       ),
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

import 'package:flutter/material.dart';
import '../utils/colors.dart';

class AnimatedLogo extends StatefulWidget {
  final double size;
  
  const AnimatedLogo({super.key, this.size = 80});

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    _rotationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeInOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 0.9,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _rotationController.repeat();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_rotationController, _pulseController]),
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: RotationTransition(
            turns: _rotationAnimation,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryBlue.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.size / 2),
                child: Image.asset(
                  'assets/logo2.png', // Replace with your actual logo path
                  width: widget.size,
                  height: widget.size,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback to custom painted logo if image fails to load
                    return CustomPaint(
                      painter: LogoPainter(),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Keep the original LogoPainter as fallback
class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Background circle
    final backgroundPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.white, Color(0xFFF8F9FA)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw segments
    final segmentPaints = [
      Paint()..color = AppColors.primaryBlue,
      Paint()..color = AppColors.primaryYellow,
      Paint()..color = AppColors.primaryOrange,
      Paint()..color = AppColors.lightBlue,
    ];

    const startAngles = [0.0, 90.0, 180.0, 270.0];
    const sweepAngle = 85.0;

    for (int i = 0; i < 4; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius * 0.7),
        (startAngles[i] * 3.14159) / 180,
        (sweepAngle * 3.14159) / 180,
        true,
        segmentPaints[i],
      );
    }

    // Center circle with text
    final centerPaint = Paint()..color = Colors.white;
    canvas.drawCircle(center, radius * 0.4, centerPaint);

    // Draw FOT text
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'FOT\nPulse',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: size.width * 0.15,
          fontWeight: FontWeight.bold,
          height: 0.9,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}