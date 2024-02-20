import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solis_flutterproject/Views/models/tripmodel.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

const LatLng currentLocation = LatLng(18.57751, 74.00377);
// Your list of data
List _myData = [
  TripData(
      iconsimage: 'assets/images/icdistance.png',
      headertext: 'Distance',
      subheadertext: '8',
      unittext: ' km'),
  TripData(
      iconsimage: 'assets/images/icrightplay.png',
      headertext: 'Trip Time',
      subheadertext: '130',
      unittext: ' sec'),
  TripData(
      iconsimage: 'assets/images/icavgspeed.png',
      headertext: 'Avg Speed',
      subheadertext: '60',
      unittext: ' kmph'),
  TripData(
      iconsimage: 'assets/images/icleftplay.png',
      headertext: 'Idle Time',
      subheadertext: '70',
      unittext: ' sec')
];

class LiveMapsView extends StatefulWidget {
  const LiveMapsView({super.key});

  @override
  State<LiveMapsView> createState() => _LiveMapsViewState();
}

class _LiveMapsViewState extends State<LiveMapsView> {
  bool isContainer1Tapped = false;
  // bool isContainer2Tapped = false;

  // late GoogleMapController mapController;

  // final Map<String, Marker> _markers = {};

  int _selectedIndex = 0;
  late GoogleMapController _controller;
  LatLng _currentLocation = const LatLng(18.577456557847658, 74.00349281054935);

  @override
  void initState() {
    super.initState();
    _initSocketConnection();
  }

  void _initSocketConnection() {
    final socket = io.io('http://64.227.137.118:3031');

    socket.on('location', (data) {
      setState(() {
        _currentLocation = LatLng(data[18.577456557847658], data[74.00349281054935]);
        print(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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

          // GoogleMap Integration Code
          Expanded(
            child: Stack(children: [
              GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                trafficEnabled: true,
                initialCameraPosition:
                     CameraPosition(target: _currentLocation, zoom: 14),
                onMapCreated: (controller) {
                  setState(() {
                    _controller = controller;
                  });
                },
                markers: {
           Marker(
            markerId:const MarkerId('currentLocation'),
            position: _currentLocation,
            infoWindow:const InfoWindow(title: 'Current Location'),
          ),}
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
                          isContainer1Tapped = false;
                          // Reset other container
                          _showBottomPopup(context);
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
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/iclunch.png',
                height: 30,
              ),
              backgroundColor: Colors.white,
              label: '',
            ),
            BottomNavigationBarItem(
                icon: Image.asset('assets/images/icbuilding.png', height: 25),
                backgroundColor: Colors.white,
                label: ''),
            BottomNavigationBarItem(
                icon: Image.asset('assets/images/icpetrolpump.png', height: 30),
                backgroundColor: Colors.white,
                label: ''),
            BottomNavigationBarItem(
                icon: Image.asset('assets/images/iclocation.png', height: 30),
                backgroundColor: Colors.white,
                label: '')
          ],
          selectedIconTheme: const IconThemeData(
            color: Color.fromARGB(255, 25, 45, 159),
          ),
          unselectedItemColor: Colors.black,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }

//   addMarker(String id, LatLng location) {
//     var marker = Marker(markerId: MarkerId(id), position: location);

//     _markers[id] = marker;
//   }
// }

void _showBottomPopup(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.black,
    builder: (BuildContext context) {
      return SizedBox(
          height: 350, // Adjust the height as needed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, bottom: 10, right: 30, top: 20),
                    child: Wrap(spacing: -30, children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Trip Details',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Align(
                                alignment: AlignmentDirectional.topStart,
                                child: IconButton(
                                  icon: Image.asset(
                                      'assets/images/icoutlinearrow.png',
                                      height: 30),
                                  onPressed: () {},
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Konark Plaza to Camp',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              Wrap(
                                spacing: -15,
                                children: [
                                  IconButton(
                                    icon: Image.asset(
                                        'assets/images/icrightplay.png',
                                        height: 25),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Image.asset(
                                        'assets/images/icleftplay.png',
                                        height: 25),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Image.asset(
                                        'assets/images/icplaypause.png',
                                        height: 28),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
              Container(
                  alignment: AlignmentDirectional.bottomEnd,
                  height: 230,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.9,
                                  mainAxisSpacing: 0,
                                  crossAxisSpacing: 10),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _myData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.only(top: 25),
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                                color: Colors.white,
                              ),
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Image.asset(
                                        _myData[index].iconsimage,
                                        height: 25,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Center(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              _myData[index].headertext,
                                              style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  _myData[index].subheadertext,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Text(
                                                  _myData[index].unittext,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ))
            ],
          ));
    },
  );
}
}