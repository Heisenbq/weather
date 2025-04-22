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
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            hintText: 'Введите город...',
            prefixIcon: Icon(Icons.search
            ),
            filled: true,
            fillColor: Colors.white12,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.white, width: 2)

            ),
          ),
          onChanged: (text) {
            context.read<CitySearchBloc>().add(CityTextChanged(text));
          },
        ),
        Expanded(
          child: BlocBuilder<CitySearchBloc, CitySearchState>(
            builder: (context, state) {
              if (state is CitySearchInitial) {
                // return const Center(child: Text('Начни вводить название города'));
                return Text("");
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
