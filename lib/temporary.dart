import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SyncFusion',
      theme: ThemeData.dark(useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<DataPoint> dataPoints = [];
  Timer? timer; // Declare a timer variable

  Future<Map<String, dynamic>> getDataFromFirebase() async {
    String url =
        "https://syncfusion-bc26a-default-rtdb.firebaseio.com/Street%20Light.json"; // Replace with your Firebase URL
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final dynamic jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('Time') &&
          jsonResponse.containsKey('Intensity') &&
          jsonResponse.containsKey('Intensity')) {
        final String time = jsonResponse['Time'].toString();
        final int intensity = jsonResponse['Intensity'] as int;
        final int temperature = jsonResponse['Temperature'] as int;
        return {
          'time': time,
          'intensity': intensity,
          'temperature': temperature
        };
      }
    }
    return {
      'time': '',
      'intensity': 0,
      'temperature': 0
    }; // Return default values if data is missing or invalid
  }

  Future<void> loadDataPoints() async {
    final Map<String, dynamic> data = await getDataFromFirebase();

    setState(() {
      dataPoints.add(DataPoint(
        data['time'],
        data['intensity'],
        data['temperature'],
      ));
      if (dataPoints.length > 10) {
        dataPoints.removeAt(0); // Remove the oldest data point if more than 10
      }
    });
  }

  @override
  void initState() {
    // Set up a timer to refresh the data every second
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      loadDataPoints();
    });
    super.initState();
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed to prevent memory leaks
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          SfCartesianChart(
            plotAreaBorderWidth: 0,
            // onChartTouchInteractionMove: (tapArgs) => dataPoints,

            title: ChartTitle(
              text: 'Intensity Graph',
              alignment: ChartAlignment.near,
              textStyle: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            enableAxisAnimation: true,
            primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
            ),
            primaryYAxis: NumericAxis(
                majorGridLines: const MajorGridLines(width: 0),
                // isVisible: false,
                // axisLine: AxisLine(color: Colors.black),
                minimum: 0,
                maximum: 110,
                interval: 20),
            series: <ChartSeries>[
              SplineAreaSeries<DataPoint, String>(
                markerSettings: MarkerSettings(color: Colors.green),
                animationDuration: 100,
                dataSource: dataPoints,
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(134, 236, 211, 1),
                    Color.fromRGBO(134, 236, 211, 0)
                  ],
                ),
                xValueMapper: (DataPoint data, _) => data.time,
                yValueMapper: (DataPoint data, _) => data.intensity,
              ),
            ],
          ),
          SizedBox(height: 10),
          SfCartesianChart(
            plotAreaBorderWidth: 0,
            // onChartTouchInteractionMove: (tapArgs) => dataPoints,

            title: ChartTitle(
              text: 'Temperature Graph',
              alignment: ChartAlignment.near,
              textStyle: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            enableAxisAnimation: true,
            primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
            ),
            primaryYAxis: NumericAxis(
                majorGridLines: const MajorGridLines(width: 0),
                // isVisible: false,
                // axisLine: AxisLine(color: Colors.black),
                minimum: 0,
                maximum: 110,
                interval: 20),
            series: <ChartSeries>[
              SplineAreaSeries<DataPoint, String>(
                markerSettings: MarkerSettings(color: Colors.green),
                animationDuration: 100,
                dataSource: dataPoints,
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(134, 236, 211, 1),
                    Color.fromRGBO(134, 236, 211, 0)
                  ],
                ),
                xValueMapper: (DataPoint data, _) => data.time,
                yValueMapper: (DataPoint data, _) => data.intensity,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DataPoint {
  DataPoint(this.time, this.intensity, this.temperature);
  final String time;
  final int intensity;
  final int temperature;
}
