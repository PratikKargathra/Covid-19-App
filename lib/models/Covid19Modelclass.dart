class WorldWideData{
  String id;
  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int newRecovered;
  int totalRecovered;
  List countries;
  String date;

  WorldWideData({
    required this.id,
    required this.newConfirmed,
    required this.totalConfirmed,
    required this.newDeaths,
    required this.totalDeaths,
    required this.newRecovered,
    required this.totalRecovered,
    required this.countries,
    required this.date
  });

  factory WorldWideData.fromJSON(Map<String,dynamic> data){
    return WorldWideData(
        id: data['ID'],
        newConfirmed: data['Global']['NewConfirmed'],
        totalConfirmed: data['Global']['TotalConfirmed'],
        newDeaths: data['Global']['NewDeaths'],
        totalDeaths: data['Global']['TotalDeaths'],
        newRecovered: data['Global']['NewRecovered'],
        totalRecovered: data['Global']['TotalRecovered'],
        countries: data['Countries'],
        date: data['Date']
    );
  }
}

class Country{
  String id;
  String country;
  String countryCode;
  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int newRecovered;
  int totalRecovered;

  Country({
    required this.id,
    required this.country,
    required this.countryCode,
    required this.newConfirmed,
    required this.totalConfirmed,
    required this.newDeaths,
    required this.totalDeaths,
    required this.newRecovered,
    required this.totalRecovered
  });
  factory Country.fromJSON(Map<String,dynamic> data){
    return Country(
      id: data['ID'],
      country: data['Country'],
      countryCode: data['CountryCode'],
      newConfirmed: data['NewConfirmed'],
      totalConfirmed: data['TotalConfirmed'],
      newDeaths: data['NewDeaths'],
      totalDeaths: data['TotalDeaths'],
      newRecovered: data['NewRecovered'],
      totalRecovered: data['TotalRecovered'],
    );
  }

}
