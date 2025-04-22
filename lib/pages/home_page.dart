import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_app/blocs/city_search_bloc/city_search_event.dart';
import 'package:test_flutter_app/pages/weather_page.dart';
import 'package:test_flutter_app/repository/city_repository.dart';
import 'package:test_flutter_app/widgets/city_search_widget.dart';

import '../blocs/city_search_bloc/city_search_bloc.dart';
import '../blocs/city_search_bloc/city_search_state.dart';
import '../model/city.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Stack(
            children: [
              CitySearchWidget(controller: _searchController),
              BlocBuilder<CitySearchBloc, CitySearchState>(
                builder: (context, state) {
                  if (state is CitySearchInitial) {
                    return Column(
                      children: [
                        const SizedBox(height: 80),
                        const Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Weather",
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
                        Divider(thickness: 2, color: Colors.white24),
                        Expanded(
                          child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            itemCount: state.cities.length,
                            itemBuilder: (context, index) {
                              final item = state.cities[index];
                              return _CityCard(
                                city: item,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => WeatherPage(
                                            key: ValueKey(item.name),
                                            city: item,
                                          ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (state is CitySearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CitySearchLoaded) {
                    return Column(
                      children: [
                        const SizedBox(height: 80),
                        const Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Founded cities",
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
                        Divider(thickness: 2, color: Colors.white24),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.cities.length,
                            itemBuilder: (context, index) {
                              final city = state.cities[index];
                              return _CityCard(
                                city: city,
                                onTap: () {
                                  context.read<CitySearchBloc>().add(
                                    AddCity(city),
                                  );
                                  _searchController.clear();
                                  setState(() {});
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (state is CitySearchError) {
                    return Center(child: Text(state.message));
                  } else if (state is MinSymbols) {
                    return Center(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "In text should be at least 3 symblos",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is NothingFound) {
                    return Center(
                      child: Text(
                        "Nothing found",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
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
    return Dismissible(
      key: Key('${city.name}_${city.country}'),
      direction: DismissDirection.endToStart,
      background: _buildSwipeBackground(),
      secondaryBackground: _buildSwipeBackground(isLeft: false),
      confirmDismiss: (_) async {
        return await _showDeleteConfirmation(context);
      },
      onDismissed: (_) {
        context.read<CitySearchBloc>().add(DeleteCity(city));
      },
      child: Container(
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
            child: Column(
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
          ),
        ),
      ),
    );
  }

  Widget _buildSwipeBackground({bool isLeft = true}) {
    return Container(
      color: Colors.red,
      alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Icon(Icons.delete, color: Colors.white),
    );
  }

  Future<bool> _showDeleteConfirmation(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text('Удалить город?'),
                content: Text('Вы уверены, что хотите удалить ${city.name}?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('Отмена'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text('Удалить', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
        ) ??
        false;
  }
}
