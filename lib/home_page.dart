import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:myapp/view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showTravelTime = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AppViewModel>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2E225A), Color(0xFF161328)],
          ),
        ),
        child: Center(
          child: GlassmorphicContainer(
            width: 350,
            height: 600,
            borderRadius: 20,
            blur: 10,
            alignment: Alignment.center,
            border: 2,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFFFFFFF).withOpacity(0.1),
                const Color(0xFFFFFFFF).withOpacity(0.05),
              ],
              stops: const [0.1, 1],
            ),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFFFFFFF).withOpacity(0.5),
                const Color(0xFFFFFFFF).withOpacity(0.5),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'E-SCOOTER',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                _buildSpeedometer(viewModel.speed),
                _buildDataRow(viewModel.batteryLevel, viewModel.distance),
                _buildAnimatedButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpeedometer(double speed) {
    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        customWidths: CustomSliderWidths(progressBarWidth: 15),
        customColors: CustomSliderColors(
          trackColor: Colors.grey[800],
          progressBarColors: [Colors.purple, Colors.pink],
          shadowColor: Colors.black,
          shadowMaxOpacity: 0.1,
        ),
        infoProperties: InfoProperties(
          mainLabelStyle: GoogleFonts.inter(
            fontSize: 80,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bottomLabelText: 'km/h',
          bottomLabelStyle: GoogleFonts.inter(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        startAngle: 150,
        angleRange: 240,
        size: 250,
      ),
      min: 0,
      max: 70,
      initialValue: speed,
    );
  }

  Widget _buildDataRow(int batteryLevel, double distance) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDataColumn(Icons.battery_full, '$batteryLevel%'),
        _buildDataColumn(
          Icons.location_pin,
          '${distance.toStringAsFixed(1)} km',
        ),
        StreamBuilder(
          stream: Stream.periodic(const Duration(seconds: 1)),
          builder: (context, snapshot) {
            return Text(
              DateFormat('HH:mm').format(DateTime.now()),
              style: GoogleFonts.inter(fontSize: 20, color: Colors.white),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDataColumn(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        const SizedBox(height: 5),
        Text(text, style: GoogleFonts.inter(fontSize: 20, color: Colors.white)),
      ],
    );
  }

  Widget _buildAnimatedButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showTravelTime = true;
        });
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            _showTravelTime = false;
          });
        });
      },
      child: GlassmorphicContainer(
        width: 200,
        height: 60,
        borderRadius: 30,
        blur: 10,
        alignment: Alignment.center,
        border: 2,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFFFFF).withOpacity(0.1),
            const Color(0xFFFFFFFF).withOpacity(0.05),
          ],
          stops: const [0.1, 1],
        ),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFFFFF).withOpacity(0.5),
            const Color(0xFFFFFFFF).withOpacity(0.5),
          ],
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: _showTravelTime
              ? Text(
                  '00:15:20', // Placeholder for actual traveled time
                  key: const ValueKey('text'),
                  style: GoogleFonts.inter(fontSize: 20, color: Colors.white),
                )
              : const Icon(
                  Icons.access_time_filled,
                  key: ValueKey('icon'),
                  color: Colors.pink,
                  size: 30,
                ),
        ),
      ),
    );
  }
}
