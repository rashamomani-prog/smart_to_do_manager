// import 'package:flutter/material.dart';
//
// class AppLogo extends StatefulWidget {
//   const AppLogo({super.key});
//
//   @override
//   State<AppLogo> createState() => _AppLogoState();
// }
//
// class _AppLogoState extends State<AppLogo> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnim;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat(reverse: true);
//
//     _scaleAnim = Tween<double>(begin: 0.9, end: 1.1).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ScaleTransition(
//       scale: _scaleAnim,
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFFF8BBD0), Color(0xFFE91E63)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.pinkAccent.withOpacity(0.4),
//               blurRadius: 10,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: const Icon(
//           Icons.check_circle_outline,
//           size: 60,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }
