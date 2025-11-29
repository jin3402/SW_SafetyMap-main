import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(37.739, 127.081),
    zoom: 15.0,
  );

  LatLng? _currentPosition;
  bool _isLocationLoading = true;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _setLoading(false);
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _setLoading(false);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _setLoading(false);
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // 마운트 되었는지 확인 후 setState 호출 (안전성 강화)
      if (!mounted) return;

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _addMarker();
        _isLocationLoading = false;
      });
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition!, 15.0),
      );
    } catch (e) {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    if (mounted) setState(() => _isLocationLoading = value);
  }

  void _addMarker() {
    _markers.clear();
    if (_currentPosition != null) {
      setState(() {
        _markers.add(
          Marker(
            markerId: const MarkerId('blueDot'),
            position: _currentPosition!,
            infoWindow: const InfoWindow(title: '현재 위치'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 하단 바 코드 삭제됨. 오직 지도와 앱바만 표시
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2567E8),
        elevation: 0,
        title: const Text('SafeMap', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => Navigator.pushReplacementNamed(context, '/splash'),
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (GoogleMapController controller) {
              if (!_controller.isCompleted) {
                _controller.complete(controller);
              }
              _mapController = controller;
            },
            markers: _markers,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: true,
          ),
          if (_isLocationLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}