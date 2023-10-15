import 'dart:ui';
import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  final String temperature;
  final String weatherCondition;
  final String locationName;
  final IconData icon;

  const MainCard({
    Key? key,
    required this.temperature,
    required this.weatherCondition,
    required this.locationName,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.all(4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10.0,
              sigmaY: 10.0,
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      temperature,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Icon(
                      icon,
                      size: 64,
                    ),
                    SizedBox(height: 16),
                    Text(
                      weatherCondition,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 24,
                        ),
                        Text(
                          ' $locationName',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'dart:ui';
// import 'package:flutter/material.dart';

// class MainCard extends StatelessWidget {
//   final String temperature;
//   final String weatherCondition;

//   const MainCard({
//     Key? key,
//     required this.temperature,
//     required this.weatherCondition,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: Card(
//         margin: EdgeInsets.all(4),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10.0),
//           child: BackdropFilter(
//             filter: ImageFilter.blur(
//               sigmaX: 10.0,
//               sigmaY: 10.0,
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(20),
//               child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     Text(
//                       temperature,
//                       style: TextStyle(
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     Icon(
//                       Icons.cloud,
//                       size: 64,
//                     ),
//                     SizedBox(height: 16),
//                     Text(
//                       weatherCondition,
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
