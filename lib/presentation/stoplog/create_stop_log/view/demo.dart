import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:lukethompson/core/platform/gps_service.dart';
import 'package:lukethompson/core/widgets/app_card.dart';

class DemoLocationScreen extends StatefulWidget {
  const DemoLocationScreen({super.key});

  @override
  State<DemoLocationScreen> createState() => _DemoLocationScreenState();
}

class _DemoLocationScreenState extends State<DemoLocationScreen> {
  final _latCtrl = TextEditingController();
  final _lngCtrl = TextEditingController();
  final _radiusCtrl = TextEditingController(text: "1");

  bool _loading = false;
  String? _error;
  Position? _currentPosition;
  double? _distanceMeters;
  double? _radiusMeters;

  @override
  void dispose() {
    _latCtrl.dispose();
    _lngCtrl.dispose();
    _radiusCtrl.dispose();
    super.dispose();
  }

  Future<void> _computeDistance() async {
    final lat = double.tryParse(_latCtrl.text.trim());
    final lng = double.tryParse(_lngCtrl.text.trim());
    final radius = double.tryParse(_radiusCtrl.text.trim());

    setState(() {
      _loading = true;
      _error = null;
      _distanceMeters = null;
      _radiusMeters = radius;
    });

    final pos = await GpsService.getCurrentPosition();
    if (!mounted) return;

    if (pos == null) {
      setState(() {
        _loading = false;
        _error = 'Could not get current position. Check location permissions.';
      });
      return;
    }

    if (lat == null || lng == null) {
      setState(() {
        _loading = false;
        _currentPosition = pos;
        _error = 'Enter a valid destination latitude and longitude.';
      });
      return;
    }

    final distance = GpsService.distanceInMeters(
      currentLat: pos.latitude,
      currentLon: pos.longitude,
      destinationLat: lat,
      destinationLon: lng,
    );

    setState(() {
      _loading = false;
      _currentPosition = pos;
      _distanceMeters = distance;
    });
  }

  String _formatDistance(double meters) {
    if (meters >= 1000) {
      return '${(meters / 1000).toStringAsFixed(2)} km';
    }
    return '${meters.toStringAsFixed(1)} m';
  }

  @override
  Widget build(BuildContext context) {
    final distance = _distanceMeters;
    final within =
        distance != null && _radiusMeters != null && distance <= _radiusMeters!;

    return Scaffold(
      appBar: AppBar(title: const Text('Distance Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _latCtrl,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Destination Latitude',
                hintText: 'e.g. 33.94790707492137',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _lngCtrl,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Destination Longitude',
                hintText: 'e.g. -84.33782194131719',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _radiusCtrl,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              decoration: const InputDecoration(
                labelText: 'Arrival Radius (meters)',
                hintText: 'e.g. 50',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _loading ? null : _computeDistance,
              icon: _loading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.near_me),
              label: Text(_loading ? 'Locating...' : 'Get My Distance'),
            ),
            const SizedBox(height: 24),
            if (_error != null)
              Text(
                _error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            if (_currentPosition != null) ...[
              const Divider(),
              Text(
                'Current position: '
                '${_currentPosition!.latitude.toStringAsFixed(6)}, '
                '${_currentPosition!.longitude.toStringAsFixed(6)}',
              ),
            ],
            if (distance != null) ...[
              const SizedBox(height: 16),
              AppCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatDistance(distance),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Text('Distance from destination'),
                      const SizedBox(height: 8),
                      if (_radiusMeters != null)
                        Text('Within radius: ${within ? "Yes" : "No"}'),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

