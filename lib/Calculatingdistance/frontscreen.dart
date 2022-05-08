import 'package:firbaseauth/Calculatingdistance/geomethods.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:firbaseauth/Calculatingdistance/geoservice.dart';

class GetCurrentLocation extends StatefulWidget {
  @override
  _GetCurrentLocationState createState() => _GetCurrentLocationState();
}

class _GetCurrentLocationState extends State<GetCurrentLocation> {
  late LocationData _currentPosition;
  late Location location = Location();
  final GeoService geoService = GeoService();
  final GeoMethod geoMethod = GeoMethod();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await geoService.addLocationToFirebase();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.location_history, color: Colors.white),
                      Text('Push My Location',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await geoService.retriveInRadius();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.location_history, color: Colors.white),
                      Text('Retrive in this location',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await geoMethod.convertToAddress(0, 0);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.location_history, color: Colors.white),
                      Text('Show me the address',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
