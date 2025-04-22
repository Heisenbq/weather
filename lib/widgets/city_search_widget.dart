import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_app/blocs/city_search_bloc/city_search_state.dart';

import '../blocs/city_search_bloc/city_search_bloc.dart';
import '../blocs/city_search_bloc/city_search_event.dart';


class CitySearchWidget extends StatelessWidget {

  const CitySearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
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

    );
  }
}
