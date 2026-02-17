// lib/data/location_data.dart
class LocationData {
  static final Map<String, dynamic> data = {
    "countries": [
      {
        "name": "India",
        "code": "IN",
        "states": [
          {
            "name": "Maharashtra",
            "cities": [
              "Mumbai",
              "Pune",
              "Nagpur",
              "Thane",
              "Nashik",
              "Aurangabad",
              "Solapur",
              "Kolhapur"
            ]
          },
          {
            "name": "Delhi",
            "cities": [
              "New Delhi",
              "North Delhi",
              "South Delhi",
              "East Delhi",
              "West Delhi"
            ]
          },
          {
            "name": "Karnataka",
            "cities": [
              "Bangalore",
              "Mysore",
              "Hubli",
              "Mangalore",
              "Belgaum",
              "Gulbarga"
            ]
          },
          {
            "name": "Tamil Nadu",
            "cities": [
              "Chennai",
              "Coimbatore",
              "Madurai",
              "Tiruchirappalli",
              "Salem",
              "Tirunelveli"
            ]
          },
          {
            "name": "Gujarat",
            "cities": [
              "Ahmedabad",
              "Surat",
              "Vadodara",
              "Rajkot",
              "Bhavnagar",
              "Jamnagar"
            ]
          },
          {
            "name": "Uttar Pradesh",
            "cities": [
              "Lucknow",
              "Kanpur",
              "Agra",
              "Varanasi",
              "Meerut",
              "Allahabad"
            ]
          },
          {
            "name": "West Bengal",
            "cities": [
              "Kolkata",
              "Howrah",
              "Durgapur",
              "Asansol",
              "Siliguri"
            ]
          },
          {
            "name": "Rajasthan",
            "cities": [
              "Jaipur",
              "Jodhpur",
              "Udaipur",
              "Kota",
              "Ajmer",
              "Bikaner"
            ]
          },
        ]
      },
      {
        "name": "United States",
        "code": "US",
        "states": [
          {
            "name": "California",
            "cities": [
              "Los Angeles",
              "San Francisco",
              "San Diego",
              "San Jose",
              "Sacramento",
              "Fresno"
            ]
          },
          {
            "name": "New York",
            "cities": [
              "New York City",
              "Buffalo",
              "Rochester",
              "Albany",
              "Syracuse"
            ]
          },
          {
            "name": "Texas",
            "cities": [
              "Houston",
              "Dallas",
              "Austin",
              "San Antonio",
              "Fort Worth",
              "El Paso"
            ]
          },
          {
            "name": "Florida",
            "cities": [
              "Miami",
              "Orlando",
              "Tampa",
              "Jacksonville",
              "Fort Lauderdale"
            ]
          },
        ]
      },
      {
        "name": "United Kingdom",
        "code": "GB",
        "states": [
          {
            "name": "England",
            "cities": [
              "London",
              "Manchester",
              "Birmingham",
              "Liverpool",
              "Leeds",
              "Sheffield"
            ]
          },
          {
            "name": "Scotland",
            "cities": ["Edinburgh", "Glasgow", "Aberdeen", "Dundee"]
          },
          {
            "name": "Wales",
            "cities": ["Cardiff", "Swansea", "Newport", "Wrexham"]
          },
        ]
      },
      {
        "name": "Canada",
        "code": "CA",
        "states": [
          {
            "name": "Ontario",
            "cities": [
              "Toronto",
              "Ottawa",
              "Mississauga",
              "Hamilton",
              "London"
            ]
          },
          {
            "name": "Quebec",
            "cities": ["Montreal", "Quebec City", "Laval", "Gatineau"]
          },
          {
            "name": "British Columbia",
            "cities": ["Vancouver", "Victoria", "Surrey", "Burnaby"]
          },
        ]
      },
      {
        "name": "Australia",
        "code": "AU",
        "states": [
          {
            "name": "New South Wales",
            "cities": ["Sydney", "Newcastle", "Wollongong", "Canberra"]
          },
          {
            "name": "Victoria",
            "cities": ["Melbourne", "Geelong", "Ballarat", "Bendigo"]
          },
          {
            "name": "Queensland",
            "cities": ["Brisbane", "Gold Coast", "Cairns", "Townsville"]
          },
        ]
      },
    ]
  };

  static List<String> getCountries() {
    return (data['countries'] as List)
        .map((country) => country['name'] as String)
        .toList();
  }

  static List<String> getStates(String country) {
    final countryData = (data['countries'] as List).firstWhere(
      (c) => c['name'] == country,
      orElse: () => {'states': []},
    );
    return (countryData['states'] as List)
        .map((state) => state['name'] as String)
        .toList();
  }

  static List<String> getCities(String country, String state) {
    final countryData = (data['countries'] as List).firstWhere(
      (c) => c['name'] == country,
      orElse: () => {'states': []},
    );
    final stateData = (countryData['states'] as List).firstWhere(
      (s) => s['name'] == state,
      orElse: () => {'cities': []},
    );
    return (stateData['cities'] as List).cast<String>();
  }
}
