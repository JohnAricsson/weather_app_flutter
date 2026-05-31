import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_flutter/bloc/weather_bloc_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Stack(
        children: [
          // Premium deep midnight gradient background instead of solid black
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0B0C1E),
                  Color(0xFF15162E),
                  Color(0xFF1F1235),
                ],
              ),
            ),
          ),

          // Background decorative ambient circles
          Align(
            alignment: const AlignmentDirectional(3, -0.4),
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepPurple,
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(-3, -0.2),
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.indigo,
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0, -1.3),
            child: Container(
              height: 280,
              width: 280,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orangeAccent,
              ),
            ),
          ),

          // Frosted glass blur filter layer
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
              child: Container(color: Colors.transparent),
            ),
          ),

          // Main Weather UI Core
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 10.0,
              ),
              child: BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                builder: (context, state) {
                  if (state is WeatherBlocSuccess) {
                    final weather = state.weather;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Location info block
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.orangeAccent,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${weather.locationName}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Good Morning',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),

                        const Spacer(),

                        // Big Temperature Display
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.network(
                                "https:${weather.icon}",
                                scale: 0.7, // Slightly larger icon presence
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.wb_cloudy,
                                      size: 80,
                                      color: Colors.white,
                                    ),
                              ),
                              Text(
                                '${weather.tempC.round()}°',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 84,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Condition Title Text
                        Center(
                          child: Text(
                            weather.conditionText.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 3.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Localized Date & Time
                        Center(
                          child: Text(
                            DateFormat(
                              'EEEE dd  •  ',
                            ).add_jm().format(weather.date),
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),

                        const Spacer(flex: 2),

                        // Glassmorphic Weather Detail Container Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.12),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Top Row: Sunrise and Sunset
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildDetailItem(
                                    assetPath: 'assets/sun.png',
                                    title: 'Sunrise',
                                    value: '${weather.sunrise}',
                                  ),
                                  _buildDetailItem(
                                    assetPath: 'assets/night.png',
                                    title: 'Sunset',
                                    value: '${weather.sunset}',
                                  ),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                ),
                                child: Divider(
                                  color: Colors.white.withOpacity(0.08),
                                  thickness: 1,
                                ),
                              ),

                              // Bottom Row: Min/Max Temps
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildDetailItem(
                                    assetPath: 'assets/hot.png',
                                    title: 'Temp Max',
                                    value: '${weather.maxTempC.round()}°C',
                                  ),
                                  _buildDetailItem(
                                    assetPath: 'assets/cold.png',
                                    title: 'Temp Min',
                                    value: '${weather.minTempC.round()}°C',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  } else if (state is WeatherBlocLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.orangeAccent,
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'Failed to load terminal weather matrix.',
                        style: TextStyle(color: Colors.white60, fontSize: 16),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Extracted helper function for uniform, structural metadata grid items
  Widget _buildDetailItem({
    required String assetPath,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Image.asset(
          assetPath,
          scale: 7,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.wb_sunny_outlined,
            color: Colors.white38,
            size: 28,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
