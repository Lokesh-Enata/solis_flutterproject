import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng currentLocation = LatLng(18.57751, 74.00377);

class LiveMapsView extends StatefulWidget {
  const LiveMapsView({super.key});

  @override
  State<LiveMapsView> createState() => _LiveMapsViewState();
}

class _LiveMapsViewState extends State<LiveMapsView> {
  bool isContainer1Tapped = false;
  // bool isContainer2Tapped = false;

  late GoogleMapController mapController;

  final Map<String, Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 45, 159),
        toolbarHeight: 80,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Image.asset(
                "assets/images/ic_sidebar.png",
                height: 30,
              ), // Menu icon
              onPressed: () {
                // Handle menu button press
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text(
          "Dashboard",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 15),
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Solis 4215 4WD",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    "MH1288998877676787",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(children: [
              GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                trafficEnabled: true,
                initialCameraPosition:
                    const CameraPosition(target: currentLocation, zoom: 14),
                onMapCreated: (controller) {
                  mapController = controller;
                  addMarker('test', currentLocation);
                },
                markers: _markers.values.toSet(),
              ),
              Positioned(
                top: 30,
                right: 5,
                left: 5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isContainer1Tapped = true; // Reset other container
                        });
                      },
                      child: Container(
                        height: 60,
                        width: 160,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: isContainer1Tapped
                                    ? const Color.fromARGB(255, 25, 45, 159)
                                    : Colors.transparent),
                            color: isContainer1Tapped
                                ? Colors.white
                                : const Color.fromARGB(255, 25, 45, 159),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'MAX VEH SPEED',
                            style: TextStyle(
                                color: isContainer1Tapped
                                    ? const Color.fromARGB(255, 25, 45, 159)
                                    : Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isContainer1Tapped = false; // Reset other container
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: isContainer1Tapped
                                ? const Color.fromARGB(255, 25, 45, 159)
                                : Colors.white,
                            border: Border.all(
                                color: isContainer1Tapped
                                    ? Colors.white
                                    : const Color.fromARGB(255, 25, 45, 159)),
                            borderRadius: BorderRadius.circular(10)),
                        height: 60,
                        width: 160,
                        child: Center(
                          child: Text(
                            'PARAMETER',
                            style: TextStyle(
                                color: isContainer1Tapped
                                    ? Colors.white
                                    : const Color.fromARGB(255, 25, 45, 159),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            backgroundColor: Colors.white,
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black),
              backgroundColor: Colors.white,
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black),
              backgroundColor: Colors.white,
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black),
              backgroundColor: Colors.white,
              label: 'Home')
        ],
      ),
    );
  }

  addMarker(String id, LatLng location) {
    var marker = Marker(markerId: MarkerId(id), position: location);

    _markers[id] = marker;
  }
}
