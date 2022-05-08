import 'package:geocoding/geocoding.dart';

class GeoMethod {
  Future convertToAddress(double lat, double long) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(16.673528, 74.206284);
    print(placemarks.toString());
    print(placemarks);
    Placemark p = placemarks[0];
    print("Only first");
    print(p.toString());
    print(p.postalCode);
  }
}
