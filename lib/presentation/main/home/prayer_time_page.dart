import 'dart:async';
import 'package:flutter/material.dart';
import '../../../models/prayer_times_model.dart';
import '../../../services/prayer_times_service.dart';
import '../../resources/app_constants.dart';
import 'widgets/city_dropdown.dart';
import 'widgets/logic_methods.dart';
import 'widgets/prayer_card.dart';

class PrayerTimesPage extends StatefulWidget {
  const PrayerTimesPage({super.key});

  @override
  _PrayerTimesPageState createState() => _PrayerTimesPageState();
}

class _PrayerTimesPageState extends State<PrayerTimesPage> {
  final PrayerTimesService _prayerService = PrayerTimesService();
  PrayerTimesModel? _prayerTimes;
  String _nextPrayer = "";
  String _nextPrayerTime = "";
  Timer? _timer;
  int _selectedIndex = 0;
  String _selectedCity = 'Zagazig';

  @override
  void initState() {
    super.initState();
    _fetchPrayerTimes();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onCityChanged(String newCity) {
    setState(() {
      _selectedCity = newCity;
      _fetchPrayerTimes();
    });
  }

  Future<void> _fetchPrayerTimes() async {
    final times = await LogicMethods.fetchPrayerTimes(_prayerService, _selectedCity);
    if (times != null) {
      setState(() {
        _prayerTimes = times;
        var nextPrayerData = LogicMethods.getNextPrayerTime(times);
        _nextPrayer = nextPrayerData["name"]!;
        _nextPrayerTime = nextPrayerData["time"]!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0faf9),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            CityDropdown(
              selectedCity: _selectedCity,
              cities: AppConstants.cities,
              onCityChanged: _onCityChanged,
            ),
            const SizedBox(height: 20),
            Container(
              height: 180,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF3e6d69),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage('assets/background.png'),
                  fit: BoxFit.cover, 
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _nextPrayer,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _nextPrayerTime,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Prayer Times",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: _buildPrayerCards(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: [for (var item in AppConstants.bottomNavBarData) BottomNavigationBarItem(icon: Icon(item.icon), label: item.label)],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFFA3EBE3),
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }

  List<Widget> _buildPrayerCards() {
    Map<String, String> prayers = {
      "Fajr": _prayerTimes?.fajr ?? "--:--",
      "Dhuhr": _prayerTimes?.dhuhr ?? "--:--",
      "Asr": _prayerTimes?.asr ?? "--:--",
      "Maghrib": _prayerTimes?.maghrib ?? "--:--",
      "Isha": _prayerTimes?.isha ?? "--:--",
    };

    prayers.remove(_nextPrayer);
    List<Color> colors = [
      const Color(0xff714ae5),
      const Color(0xff91d4f6),
      const Color(0xffeba065),
      const Color(0xff714ae5),
    ];

    List<Widget> prayerCards = [];
    int index = 0;
    prayers.forEach((name, time) {
      prayerCards.add(
        PrayerCard(
          name: name,
          time: time,
          color: colors[index % colors.length],
        ),
      );
      index++;
    });

    return prayerCards;
  }
}
