import 'dart:async';
import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class AppViewModel extends ChangeNotifier {
  double _speed = 0;
  double _distance = 0;
  int _batteryLevel = 0;
  Position? _lastPosition;
  StreamSubscription<Position>? _positionStream;

  double get speed => _speed;
  double get distance => _distance;
  int get batteryLevel => _batteryLevel;

  AppViewModel() {
    _listenToBattery();
    _requestLocationPermission();
  }

  void _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      _listenToLocation();
    } else {
      // Handle permission denied
    }
  }

  void _listenToLocation() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 1,
    );
    _positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
          (Position position) {
            _speed = position.speed * 3.6; // Convert from m/s to km/h
            if (_lastPosition != null) {
              _distance +=
                  Geolocator.distanceBetween(
                    _lastPosition!.latitude,
                    _lastPosition!.longitude,
                    position.latitude,
                    position.longitude,
                  ) /
                  1000; // Convert to km
            }
            _lastPosition = position;
            notifyListeners();
          },
        );
  }

  void _listenToBattery() async {
    final battery = Battery();
    _batteryLevel = await battery.batteryLevel;
    notifyListeners();
    battery.onBatteryStateChanged.listen((BatteryState state) async {
      _batteryLevel = await battery.batteryLevel;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }
}
