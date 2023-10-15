import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_card.dart';
import 'package:weather_app/main_card.dart';
import 'package:weather_app/secrets.dart';
import 'package:weather_app/weather_forecast_card.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>?> getCurrentWeather() async {
    try {
      String cityName = 'Lerchenfeld';
      final response = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$openWeatherAPIKey'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return data;
      } else {
        throw 'An Unexpected Error Occurred';
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              getCurrentWeather().then((_) {
                setState(() {});
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          print(snapshot);
          print(snapshot.runtimeType);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          final data = snapshot.data!;
          double kelvinTemperature = data['list'][0]['main']['temp'];
          double celsiusTemperature = kelvinTemperature - 273.15;
          double currentTemp = celsiusTemperature;
          final currentSky = data['list'][0]['weather'][0]['main'];
          final currentPressure = data['list'][0]['main']['pressure'];
          final humadity = data['list'][0]['main']['humidity'];
          final windSpeed = data['list'][0]['wind']['speed'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MainCard(
                  temperature: currentTemp.toStringAsFixed(1) + ' °C',
                  weatherCondition: currentSky,
                  locationName: 'Lerchenfeld',
                  icon: currentSky == 'Clouds' || currentSky == 'Rain'
                      ? Icons.cloud
                      : Icons.wb_sunny,
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List<Widget>.generate(5, (int i) {
                      final weather = data['list'][i + 1]['weather'][0]['main'];
                      final dateTime =
                          DateTime.parse(data['list'][i + 1]['dt_txt']);

                      final hour = dateTime.hour;
                      final minute = dateTime.minute;
                      final formattedTime =
                          '$hour.${minute.toString().padLeft(2, '0')}'; // Format jam
                      final tempInKelvin = data['list'][i + 1]['main']['temp'];
                      final tempInCelcius =
                          (tempInKelvin - 273.15).toStringAsFixed(1);

                      return HourlyForecastItem(
                        icon: weather == 'Clouds' || weather == 'Rain'
                            ? Icons.cloud
                            : Icons.wb_sunny,
                        time: formattedTime
                            .toString(), // Menggunakan .hour untuk mengakses jam
                        temperature: '$tempInCelcius °C',
                      );
                    }),
                  ),
                ),
                // SizedBox(
                //   height: 155,
                //   child: ListView.builder(
                //     itemCount: 5,
                //     scrollDirection: Axis.horizontal,
                //     itemBuilder: (context, index) {
                //       final weather =
                //           data['list'][index + 1]['weather'][0]['main'];
                //       final dateTime =
                //           DateTime.parse(data['list'][index + 1]['dt_txt']);

                //       final hour = dateTime.hour;
                //       final minute = dateTime.minute;
                //       final formattedTime =
                //           '$hour.${minute.toString().padLeft(2, '0')}'; // Format jam
                //       final tempInKelvin =
                //           data['list'][index + 1]['main']['temp'];
                //       final tempInCelcius =
                //           (tempInKelvin - 273.15).toStringAsFixed(1);

                //       return HourlyForecastItem(
                //         icon: weather == 'Clouds' || weather == 'Rain'
                //             ? Icons.cloud
                //             : Icons.wb_sunny,
                //         time: formattedTime
                //             .toString(), // Menggunakan .hour untuk mengakses jam
                //         temperature: '$tempInCelcius °C',
                //       );
                //     },
                //   ),
                // ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Additional Information',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AdditionalInfoCard(
                      icon: Icons.water_drop,
                      title: 'Pressure',
                      value: '$currentPressure hPa',
                    ),
                    AdditionalInfoCard(
                      icon: Icons.waves,
                      title: 'Humidity',
                      value: '$humadity %',
                    ),
                    AdditionalInfoCard(
                      icon: Icons.waves,
                      title: 'Wind Speed',
                      value: '$windSpeed km/h',
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:weather_app/additional_info_card.dart';
// import 'package:weather_app/main_card.dart';
// import 'package:weather_app/secrets.dart';
// import 'package:weather_app/weather_forecast_card.dart';
// import 'dart:ui';
// import 'package:http/http.dart' as http;

// class WeatherScreen extends StatefulWidget {
//   const WeatherScreen({Key? key});

//   @override
//   State<WeatherScreen> createState() => _WeatherScreenState();
// }

// class _WeatherScreenState extends State<WeatherScreen> {
//   double temp = 0;
//   bool isLoading = true; // Tambahkan variabel isLoading

//   @override
//   void initState() {
//     super.initState();
//     getCurrentWeather();
//   }

//   Future getCurrentWeather() async {
//     try {
//       String cityName = 'Lerchenfeld';
//       final response = await http.get(
//         Uri.parse(
//             'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$openWeatherAPIKey'),
//       );
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         double kelvinTemperature = data['list'][0]['main']['temp'];
//         double celsiusTemperature = kelvinTemperature - 273.15;
//         setState(() {
//           temp = celsiusTemperature;
//           isLoading = false; // Setelah pembaruan, atur isLoading ke false
//         });
//       } else {
//         throw 'An Unexpected Error Occurred';
//       }
//     } catch (e) {
//       // Tangani kesalahan dengan benar
//       print(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(temp.toString() + ' °C');
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Weather App',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {
//               setState(() {
//                 isLoading = true; // Atur isLoading ke true
//               });
//               getCurrentWeather();
//             },
//             icon: const Icon(Icons.refresh),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             isLoading
//                 ? CircularProgressIndicator()
//                 : MainCard(
//                     temperature: temp.toStringAsFixed(1) + ' °C',
//                     weatherCondition: 'Winter',
//                   ),
//             const SizedBox(height: 20),
//             const SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: [
//                   HourlyForecastItem(
//                     icon: Icons.wb_sunny,
//                     time: '12:00',
//                     temperature: '30°C',
//                   ),
//                   HourlyForecastItem(
//                     icon: Icons.wb_sunny,
//                     time: '12:00',
//                     temperature: '30°C',
//                   ),
//                   HourlyForecastItem(
//                     icon: Icons.wb_sunny,
//                     time: '12:00',
//                     temperature: '30°C',
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Additional Information',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 AdditionalInfoCard(
//                   icon: Icons.water_drop,
//                   title: 'Pressure',
//                   value: '1013 hPa',
//                 ),
//                 AdditionalInfoCard(
//                   icon: Icons.waves,
//                   title: 'Humidity',
//                   value: '83%',
//                 ),
//                 AdditionalInfoCard(
//                   icon: Icons.waves,
//                   title: 'Wind Speed',
//                   value: '3.6 km/h',
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
