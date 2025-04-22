

class City implements Comparable<City>{
  final String name;
  final String country;
  final bool favorite;

  City({
    required this.name,
    required this.country,
    required this.favorite
  });


  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'] ?? '',
      country: json['sys']['country'] ?? '',
      favorite: false
    );
  }

  @override
  String toString() => '$name, $country';

  @override
  int compareTo(City other) {
    // return name.compareTo(other.name);

      if (favorite && !other.favorite) {
        return 1;
      } else if (!favorite && other.favorite) {
        return -1;
      } else {
        return name.compareTo(other.name);
      }

  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is City &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              country == other.country;

  // @override
  // int get hashCode {
  //   return super.hashCode();
  // }


}