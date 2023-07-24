import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:goldvault/Constants/GlobalVariable.dart';
import 'package:goldvault/Models/BuyGoldListModel.dart';
import 'package:goldvault/Screens/OrderReview.dart';
import 'package:goldvault/Widgets/CustomAppBar.dart';
import 'package:goldvault/Widgets/CustomButton.dart';
import 'package:goldvault/Widgets/CustomSnackBar.dart';
import 'package:goldvault/Widgets/CustomTexts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final BuyGoldListModelResult selectedGold;
  const MapScreen({Key? key, required this.selectedGold}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng? _tappedLocation;
  Set<Marker> _markers = {};
  Position? _currentPosition;

  @override
  void initState() {
    getValidationData();
    setState(() {

    });
    super.initState();
  }
  getValidationData() async {
    await _getCurrentLocation();
    getAddress();
  }

  Future<Position> _getCurrentLocation() async {
    bool isPermissionGranted = await requestPermission();
    print(isPermissionGranted);
    if (isPermissionGranted) {
      // setState(() async{
      _currentPosition = await Geolocator.getCurrentPosition();
      currentLat = _currentPosition!.latitude;
      currentLon = _currentPosition!.longitude;
      _addMarker(LatLng(currentLat, currentLon));
      return _currentPosition!;
    } else {
      throw requestPermission();    }
  }

  Future<bool> requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: appBar(context: context, title: "Order review"),
        body: Container(
          width: width,
          child: Container(
            child: Stack(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                      children: [
                        _currentPosition==null?CircularProgressIndicator():
                        Container(
                            width:width,
                            height: height*0.6,
                            child:
                            Stack(
                              children: [
                                GoogleMap(
                                  zoomControlsEnabled: false,
                                  mapType: MapType.normal,
                                //  markers: controller.markers,
                                  // onCameraMove: controller.onCameraMove,
                                  markers: _markers,
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(currentLat, currentLon),
                                    zoom: 20,),
                                  onMapCreated: (GoogleMapController controller){
                                    _controller.complete(controller);
                                  },
                                  myLocationEnabled: true,
                                  onTap: _onMapTapped,
                                  // onCameraIdle: () async {
                                  //   controller.getMoveCamera();
                                  // },
                                ),
                                // Image.asset('assets/images/mapsImage.png',width:width,
                                //   height: height*0.5,),
                                Positioned(
                                  right: 10,
                                    top: 100,
                                    child: Column(
                                  children: [
                                    SvgPicture.asset('assets/images/DirectionIcon.svg'),
                                    SvgPicture.asset('assets/images/TargetIcon.svg'),
                                    SvgPicture.asset('assets/images/AddLocationIcon.svg'),
                                  ],
                                ))
                              ],
                            )),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        ListTile(
                          leading: SvgPicture.asset('assets/images/LocationIcon.svg'),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MainHeadingText(
                                text: 'Current Address',
                                fontSize: 18,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              currentAddress==null?Container():
                              ParagraphText(
                                text: currentAddress,
                                color: Colors.black,
                              )
                            ],
                          ),
                        )
                      ],
                    )
                    // Container(
                    //   width: width,
                    //   height: height,
                    //   child: Align(
                    //     alignment: Alignment.topCenter,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         SvgPicture.asset('assets/images/LeftArrowIcon.svg'),
                    //         Container(
                    //             height: height * 0.2,
                    //             width: width*0.5,
                    //             child: Image.asset(
                    //               'assets/images/GoldBuiscuitImg.png',
                    //               fit: BoxFit.fill,
                    //             )),
                    //         SvgPicture.asset('assets/images/RightArrowIcon.svg'),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    ),
                Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: width - 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(
                              text: "CONFIRM ADDRESS",
                              width: width - 40,
                              onTap: () {
                                currentAddress==null?showSnackbar(context, "address not found"):
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OrderReview(selectedGold: widget.selectedGold,)));
                              },
                            ),
                            // SvgPicture.asset(
                            //   "assets/images/MoreButton.svg",
                            //   height: 50,
                            // )
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
  void _onMapTapped(LatLng location) {
    setState(() {
      _tappedLocation = location;
      currentLat = _tappedLocation!.latitude;
      currentLon = _tappedLocation!.longitude;
      _addMarker(location);
      getAddress();
      setState(() {});
      print("current lat is...$currentLat");
    });
  }
  void _addMarker(LatLng location) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('marker_id'),
          position: location,
          //Icons.location_on_sharp
        ),
      );
    });
  }
  getAddress() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(currentLat, currentLon);
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        currentAddress = '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}, ${placemark.postalCode}';
        setState(() {
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
