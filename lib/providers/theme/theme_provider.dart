import 'package:equatable/equatable.dart';

import '../../constants/constants.dart';
import '../weather/weather_provider.dart';

part 'theme_state.dart';

class ThemeProvider {
  final WeatherProvider wp;
  ThemeProvider({
    required this.wp,
  });

  ThemeState get state {
    if (wp.state.weather.temp > kWarmOrNot) {
      return ThemeState();
    } else {
      return ThemeState(appTheme: AppTheme.dark);
    }
  }
}
