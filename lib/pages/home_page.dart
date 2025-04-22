import 'package:flutter/material.dart';
import 'package:test_flutter_app/pages/weather_page.dart';
import 'package:test_flutter_app/repository/city_repository.dart';
import 'package:test_flutter_app/widgets/city_search_widget.dart';

import '../model/city.dart';

class HomePage extends StatefulWidget {

  final CityRepository cityRepository;

  const HomePage({super.key, required this.cityRepository});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    List<City> cities = widget.cityRepository.cities;
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 70),
                  const Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            "Погода",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      itemCount: cities.length,
                      itemBuilder: (context, index) {
                        final item = cities[index];
                        return _CityCard(
                          city: item,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WeatherPage(
                                  key: ValueKey(item.name),
                                  city: item.name,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),

              Positioned(
                top: 8,
                left: 8,
                right: 8,
                child: SizedBox(
                  height: 1000,
                  child: CitySearchWidget(
                    onCitySelected: (city) {
                      widget.cityRepository.addCity(city);
                      setState(() {});
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _CityCard extends StatelessWidget {
  final City city;
  final VoidCallback onTap;

  const _CityCard({required this.city, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.lightBlue,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 8),
              Text(
                city.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                city.country,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
