import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fl_chart/fl_chart.dart';

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

  int _selectedIndex = 0;
  static Map<int, int> miles = const {
    0: 42,
    1: 43,
    2: 44,
    3: 45,
  };

  static Map<int, int> speed = const {
    0: 140,
    1: 150,
    2: 160,
    3: 170,
    4: 180,
    5: 190,
    6: 200,
  };

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

  addMarker(String id, LatLng location) {
    var marker = Marker(markerId: MarkerId(id), position: location);

    _markers[id] = marker;
  }
}

void _showBottomPopup(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
          height: 500, // Adjust the height as needed
          child:const Text('data'));
    },
  );
}

//  LineChartData mainData() {
    return const LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color.fromARGB(100, 100, 100, 100),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color.fromARGB(100, 100, 100, 100),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (_, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            String? month = monthMap[value.toInt()];
            if (month == null) {
              return '';
            }
            return month;
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (_, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            String? money = moneyMap[value.toInt()];
            if (money == null) {
              return '';
            }
            return money;
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots:const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData:const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            
          ),
        ),
      ],
    );
  }
