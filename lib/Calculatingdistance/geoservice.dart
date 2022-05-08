import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';

class GeoService {
  // Future<List<Address>> _getAddress(double lat, double lang) async {
  //   final coordinates = new Coordinates(lat, lang);
  //   List<Address> add =
  //       await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //   return add;
  // }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference hostels = FirebaseFirestore.instance.collection('Hostel');
  Geoflutterfire geo = Geoflutterfire();
  Location location = Location();
  final _firestore = FirebaseFirestore.instance;

  //To add location in firebase document
  Future addLocationToFirebase() async {
    var pos = await location.getLocation();
    double latitude = pos.latitude as double;
    double longitude = pos.longitude as double;
    GeoFirePoint point = geo.point(latitude: 16.654403, longitude: 74.262568);

    return hostels
        .doc(_auth.currentUser!.uid)
        .update({
          'position': point.data, // John Doe
          'name': 'Mandar'
        })
        .then((value) => print("Location User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  //To retrive specific documents
  Future retriveInRadius() async {
    print("Inside");
    var collectionReference = _firestore.collection('Hostel');
    var geoRef = geo.collection(collectionRef: collectionReference);

    // Create a geoFirePoint
    GeoFirePoint center = geo.point(latitude: 16.667886, longitude: 74.206037);

    double radius = 1;
    String field = 'position';

    Stream<List<DocumentSnapshot>> stream = geo
        .collection(collectionRef: collectionReference)
        .within(center: center, radius: radius, field: field);

    stream.listen((List<DocumentSnapshot> documentList) {
      // doSomething()
      documentList.forEach((DocumentSnapshot document) {
        Map<String, dynamic> myHostel = document.data() as Map<String, dynamic>;

        GeoPoint pos = myHostel['position']['geopoint'];
        print(myHostel['username']);
        var distance = center.kmDistance(lat: pos.latitude, lng: pos.longitude);
        print(distance);

        print("pos");
        print(pos.latitude);
        print(pos.longitude);
      });
    });
  }
}
