import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_app/blocs/city_search_bloc/city_search_event.dart';
import 'package:test_flutter_app/pages/home_page/widgets/city_card.dart';
import 'package:test_flutter_app/pages/home_page/widgets/text_info.dart';
import 'package:test_flutter_app/pages/weather_page/weather_page.dart';
import 'package:test_flutter_app/pages/home_page/widgets/city_search_widget.dart';

import '../../blocs/city_search_bloc/city_search_bloc.dart';
import '../../blocs/city_search_bloc/city_search_state.dart';
import '../../model/city.dart';

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
                  return switch (state) {
                    CitySearchInitial() => _buildStorageCities(state.cities),
                    CitySearchLoading() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    CitySearchLoaded() => _buildFondedCities(state.cities),
                    CitySearchError() => Center(child: Text(state.message)),
                    MinSymbols() => TextInfo(text: "In text should be at least 3 symblos"),
                    NothingFound() => TextInfo(text: "Nothing found"),
                    _ => const SizedBox.shrink(),
                  };
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStorageCities(List<City> cities) {
    return Column(
      children: [
        const SizedBox(height: 80),
        const Row(
          children: [
            Expanded(
              child: TextInfo(text: "Weather"),
            ),
          ],
        ),
        Divider(thickness: 2, color: Colors.white24),
        Expanded(
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            itemCount: cities.length,
            itemBuilder: (context, index) {
              final item = cities[index];
              return _DismissibleCityCard(
                city: item,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              WeatherPage(key: ValueKey(item.name), city: item),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFondedCities(List<City> cities) {
    return Column(
      children: [
        const SizedBox(height: 80),
        const Row(
          children: [
            Expanded(
              child: Center(
                child: TextInfo(text: "Founded cities"),
              ),
            ),
          ],
        ),
        Divider(thickness: 2, color: Colors.white24),
        Expanded(
          child: ListView.builder(
            itemCount: cities.length,
            itemBuilder: (context, index) {
              final city = cities[index];
              return CityCard(
                city: city,
                onTap: () {
                  context.read<CitySearchBloc>().add(AddCity(city));
                  _searchController.clear();
                  setState(() {});
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DismissibleCityCard extends StatelessWidget {
  final City city;
  final VoidCallback onTap;

  const _DismissibleCityCard({required this.city, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('${city.name}_${city.country}'),
      direction: DismissDirection.endToStart,
      background: _buildSwipeBackground(),
      secondaryBackground: _buildSwipeBackground(),
      confirmDismiss: (_) async {
        return await _showDeleteConfirmation(context);
      },
      onDismissed: (_) {
        context.read<CitySearchBloc>().add(DeleteCity(city));
      },
      child: CityCard(onTap: onTap, city: city),
    );
  }

  Widget _buildSwipeBackground() {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
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

