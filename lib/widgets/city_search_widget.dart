import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/city_search_bloc/city_search_bloc.dart';
import '../blocs/city_search_bloc/city_search_event.dart';
import '../blocs/city_search_bloc/city_search_state.dart';
import '../model/city.dart';


class CitySearchWidget extends StatelessWidget {
  final void Function(City city)? onCitySelected;

  const CitySearchWidget({super.key, this.onCitySelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            hintText: 'Введите город...',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (text) {
            context.read<CitySearchBloc>().add(CityTextChanged(text));
          },
        ),
        Expanded(
          child: BlocBuilder<CitySearchBloc, CitySearchState>(
            builder: (context, state) {
              if (state is CitySearchInitial) {
                return const Center(child: Text('Начни вводить название города'));
              } else if (state is CitySearchLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CitySearchLoaded) {
                return ListView.builder(
                  itemCount: state.cities.length,
                  itemBuilder: (context, index) {
                    final city = state.cities[index];
                    return ListTile(
                      title: Text('${city.name}, ${city.country}'),
                      onTap: () => onCitySelected?.call(city),
                    );
                  },
                );
              } else if (state is CitySearchError) {
                return Center(child: Text(state.message));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        )
      ],
    );
  }
}
