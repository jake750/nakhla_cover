import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:gabes_eco_watch/providers/report_provider.dart';

class HomeMapScreen extends StatefulWidget {
  const HomeMapScreen({super.key});

  @override
  _HomeMapScreenState createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends State<HomeMapScreen> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  static const LatLng _center = LatLng(33.8815, 10.0982); // Gabes coordinates

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  void _loadMarkers() {
    final reportProvider = Provider.of<ReportProvider>(context, listen: false);
    // Assuming reports are loaded, create markers
    // For clustering, use google_maps_cluster_manager
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gabes Eco-Watch'),
        backgroundColor: Color(0xFF005F73),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 12.0,
        ),
        markers: _markers,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/report');
        },
        backgroundColor: Color(0xFFEE9B00),
        child: Icon(Icons.add),
      ),
    );
  }
}