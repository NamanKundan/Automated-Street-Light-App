import 'package:flutter/material.dart';
import 'package:sih_app/widgets/charts/temp1_charts.dart';
import 'package:sih_app/widgets/charts/temp2_charts.dart';
import 'package:sih_app/widgets/charts/temp3_chart.dart';

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({super.key});

  @override
  State<MonitoringPage> createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Monitoring",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(),
        elevation: 10.00,
        backgroundColor: Colors.blue[300],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [FirstGraph(), ThirdGraph(), SecondGraph()],
        ),
      ),
    );
  }
}
