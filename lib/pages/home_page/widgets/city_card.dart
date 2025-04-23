import 'package:flutter/material.dart';

import '../../../model/city.dart';

class CityCard extends StatelessWidget {
  const CityCard({
    super.key,
    required this.onTap,
    required this.city,
  });

  final VoidCallback onTap;
  final City city;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE3F2FD), // светло-голубой
            Color(0xFFFCE4EC), // нежно-розовый
            Color(0xFFFFF8E1), // светло-жёлтый
          ],
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 8),

                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            city.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            city.country,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                right: 10,
                top: 8,
                child:
                city.favorite
                    ? Icon(Icons.star, color: Colors.yellow, size: 40)
                    : Icon(
                  Icons.star,
                  color: Colors.yellow.withAlpha(0),
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
