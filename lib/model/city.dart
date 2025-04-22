

class City implements Comparable<City>{
  final String name;
  final String country;
  bool favorite;

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

    if (favorite != other.favorite) {
      return other.favorite ? 1 : -1;
    }
    return name.compareTo(other.name);

  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is City &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              country == other.country;

  @override
  int get hashCode => name.hashCode ^ country.hashCode;


}