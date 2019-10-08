import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

const kGooglePlaceAPI = "AIzaSyCDRASMUc5PVK-oz1v-Q_lnizWRsqSckXY";
final _places = GoogleMapsPlaces(apiKey: kGooglePlaceAPI);

class Maps extends StatefulWidget {
  Maps({Key key, @required this.userLoc}) : super(key: key);
  final Position userLoc;
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  List<Marker> allMarkers = [];
  List<PlacesSearchResult> places = [];
  Completer<GoogleMapController> _controller = Completer();

  // @override _MapsState get widget => super.widget;

  // final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(0.0,0.0),
  //   zoom: 14.4746,
  // );

  @override
  void initState() {
    super.initState();

    allMarkers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId('home'),
      position: LatLng(widget.userLoc.latitude, widget.userLoc.longitude),
      infoWindow: InfoWindow(
        title: 'Really cool place',
        snippet: '5 Star Rating',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Maps'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                refresh();
              },
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target:
                    LatLng(widget.userLoc.latitude, widget.userLoc.longitude),
                zoom: 19.151926040649414,
                // tilt: 59.440717697143555,
                bearing: 192.8334901395799,
              ),
              markers: Set.from(allMarkers),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            // FloatingActionButton(onPressed: ,)
          ],
        ));
  }

  void refresh() async {
    final center = await _getPosition();
    getNearbyPlaces(center);   
  }

  Future<LatLng> _getPosition() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        bearing: 192.8334901395799,
        // tilt: 59.440717697143555,
        zoom: 17.151926040649414)));

        return LatLng(position.latitude, position.longitude);
      
  }

  void getNearbyPlaces(LatLng center) async {
    final location = Location(center.latitude, center.longitude);
    final result = await _places.searchNearbyWithRadius(location, 1500, type: "restaurant");
    setState(() {
      // this.isLoading = false;
      if (result.status == "OK") {
        this.places = result.results;
        result.results.forEach((f) {
          allMarkers.add(Marker(
              markerId: MarkerId(f.name),
              position:
                  LatLng(f.geometry.location.lat, f.geometry.location.lng),
              infoWindow: InfoWindow(
                title: f.name,
                snippet: f.rating.toString()
              )));
        });
      } else {
        // this.errorMessage = result.errorMessage;
        print("error: ${result.errorMessage}");
      }
    });
  }
}
