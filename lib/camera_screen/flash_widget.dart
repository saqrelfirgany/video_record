// import 'package:camera/camera.dart';
// import 'package:flash/flash.dart';
// import 'package:flutter/material.dart';
//
// // Create a flash button widget
// class FlashButton extends StatelessWidget {
//   // Declare a controller for the camera
//   final CameraController controller;
//
//   // Declare a constructor that takes the controller as a parameter
//   const FlashButton({Key? key, required this.controller}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       // Set the icon to a flash icon
//       icon: Icon(
//         controller.value.flashMode == FlashMode.off ? Icons.flash_off : Icons.flash_on,
//       ),
//       // Set the color to white
//       color: Colors.white,
//       // Set the onPressed function
//       onPressed: () {
//         // Get the current flash mode
//         final currentFlashMode = controller.value.flashMode;
//
//         // Set the flash mode to on or off
//         FlashMode nextFlashMode;
//         if (currentFlashMode == FlashMode.off) {
//           nextFlashMode = FlashMode.always;
//         } else {
//           nextFlashMode = FlashMode.off;
//         }
//
//         // Set the flash mode of the controller
//         controller.setFlashMode(nextFlashMode);
//
//         // Show a toast message with the flash mode
//         showFlash(
//           context: context,
//           duration: const Duration(seconds: 2),
//           builder: (context, controller) {
//             return Flash(
//               controller: controller,
//               // backgroundColor: Colors.black.withOpacity(0.5),
//               // style: FlashStyle.floating,
//               position: FlashPosition.top,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   'Flash mode: ${nextFlashMode.toString().split('.').last}',
//                   style: const TextStyle(color: Colors.white),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
