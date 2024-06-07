import 'package:flutter/material.dart';
import 'package:one/models/prayer.dart';
import 'package:one/services/api_service.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ApiService apiService = ApiService();
  List<Prayer> prayers = [];

  @override
  void initState() {
    super.initState();
    fetchPrayers();
  }

  void fetchPrayers() async {
    try {
      List<Prayer> fetchedPrayers =
          await apiService.getPrayers(1); // Replace with actual user ID
      setState(() {
        prayers = fetchedPrayers;
      });
    } catch (e) {
      print('Failed to load prayers: $e');
    }
  }

  void togglePrayerStatus(int index) async {
    Prayer prayer = prayers[index];
    try {
      await apiService.savePrayer(1, index + 1,
          !prayer.status); // Replace with actual user ID and prayer ID
      setState(() {
        prayers[index] = Prayer(name: prayer.name, status: !prayer.status);
      });
    } catch (e) {
      print('Failed to update prayer status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prayer Tracker'),
      ),
      body: Column(
        children: [
          Text('User Name'), // User's name fetched from API
          Expanded(
            child: ListView.builder(
              itemCount: prayers.length,
              itemBuilder: (context, index) {
                Prayer prayer = prayers[index];
                return ListTile(
                  title: Text(prayer.name),
                  trailing: Switch(
                    value: prayer.status,
                    onChanged: (bool value) {
                      togglePrayerStatus(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
