import 'package:flutter/material.dart';
import 'models/Weather.dart';
import 'service/WeatherService.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService("e6143be2354ca4702a6ced97c547261c");
  Weather? _weather;
  String _selectedUnit = 'metric'; // Celsius or Fahrenheit
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();

  static TextStyle textStyle = GoogleFonts.pressStart2p(
    fontSize: 18,
    color: const Color.fromARGB(255, 0, 181, 236),
  );

  Future<void> _fetchWeatherByCity() async {
    try {
      final weather = await _weatherService.getWeatherByCity(
          _cityController.text, _selectedUnit);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _fetchWeatherByZip() async {
    try {
      final weather = await _weatherService.getWeatherByZip(
          _zipController.text, _selectedUnit);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
        color: Colors.black,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: Colors.lightBlue.shade50,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildCityNameField(),
                    const SizedBox(height: 20),
                    _buildZipCodeField(),
                    const SizedBox(height: 20),
                    _buildUnitSelector(),
                    const SizedBox(height: 30),
                    if (_weather != null) _buildWeatherInfo(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCityNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            'assets/images/weather_logo.jfif',
            width: 250,
            height: 250,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 8),
        _buildTextFieldWithButton(
          controller: _cityController,
          label: 'Enter City Name',
          buttonText: 'Search',
          onPressed: _fetchWeatherByCity,
        ),
      ],
    );
  }

  Widget _buildZipCodeField() {
    return _buildTextFieldWithButton(
      controller: _zipController,
      label: 'Enter Zip Code',
      buttonText: 'Search',
      onPressed: _fetchWeatherByZip,
    );
  }

  Widget _buildTextFieldWithButton({
    required TextEditingController controller,
    required String label,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue.shade50,
            foregroundColor: const Color.fromARGB(255, 0, 181, 236),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(buttonText),
        ),
      ],
    );
  }

  Widget _buildUnitSelector() {
    return DropdownButton<String>(
      value: _selectedUnit,
      items: const [
        DropdownMenuItem(value: 'metric', child: Text('Celsius (°C)')),
        DropdownMenuItem(value: 'imperial', child: Text('Fahrenheit (°F)')),
      ],
      onChanged: (value) {
        setState(() {
          _selectedUnit = value!;
        });
      },
    );
  }

  Widget _buildWeatherInfo() {
    String unitSymbol = _selectedUnit == 'metric' ? '°C' : '°F';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'City: ${_weather!.cityName}',
            style: textStyle,
          ),
          const SizedBox(height: 10),
          Lottie.asset(
            _getWeatherAnimation(_weather!.mainCondition),
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 10),
          Text(
            'Temperature: ${_weather!.tempurature.round()}$unitSymbol',
            style: textStyle,
          ),
          Text(
            'Condition: ${_weather!.mainCondition}',
            style: textStyle,
          ),
        ],
      ),
    );
  }

  String _getWeatherAnimation(String? mainCondition) {
    switch (mainCondition?.toLowerCase()) {
      case "clouds":
        return "assets/animation/Animation_1.json";
      case "fog":
      case "mist":
      case "smoke":
      case "haze":
      case "drizzle":
      case "rain":
        return "assets/animation/Animation_2rain.json";
      case "thunderstorm":
        return "assets/animation/Animation_4thunder.json";
      default:
        return "assets/animation/Animation_3sun.json";
    }
  }
}
