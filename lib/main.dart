import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:weather_app/bloc/geocoding_bloc/geocoding_bloc.dart';
import 'package:weather_app/bloc/network_connectivity_bloc/network_connectivity_bloc.dart';
import 'package:weather_app/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app/di/dependencies_locator.dart';
import 'package:weather_app/repository/geocoding_repository.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/ui/common_widgets/app_toast.dart';
import 'package:weather_app/ui/common_widgets/glass_container.dart';
import 'package:weather_app/ui/common_widgets/loading_indicator.dart';
import 'package:weather_app/ui/search.dart';

void main() {
  ServiceLocator.setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<NetworkConnectivityBloc>(create: (context) => NetworkConnectivityBloc()..add(InitializeConCheckerEvent())),
          BlocProvider<WeatherBloc>(create: (context) => WeatherBloc(weatherRepository: GetIt.I<IWeatherRepository>())),
          BlocProvider<GeocodingBloc>(create: (context) => GeocodingBloc(geocodingRepository: GetIt.I<IGeocodingRepository>())),
        ],
        child: const MyHomePage(title: ''),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String currentLocation = '';
  String userInputLocation = '';
  bool once = true;

  void getWeatherDataOnStartup() async {
    showLoadingIndicator(context);
    LocationData locationData = await Location().getLocation();
    var q = "${locationData.latitude}+${locationData.longitude}";
    context.read<GeocodingBloc>().add(GetCoordWithLocationName(locationName: q));
  }

  @override
  void didChangeDependencies() {
    Future.delayed(Duration.zero, () {
      if (once) {
        getWeatherDataOnStartup();
        once = false;
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NetworkConnectivityBloc, NetworkConnectivityState>(
          listener: (context, state) async {
            if (state is ConnectionLostState) {
              ScaffoldMessenger.of(context).showMaterialBanner(
                const MaterialBanner(
                  elevation: 0,
                  content: Text('Connection lost. Weather information might not be accurate.'),
                  leading: Icon(Icons.wifi_off),
                  backgroundColor: Colors.redAccent,
                  actions: [SizedBox.shrink()],
                ),
              );
            } else if (state is ConnectionRestoredState) {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              ScaffoldMessenger.of(context).showMaterialBanner(
                const MaterialBanner(
                  elevation: 0,
                  content: Text('Connection restored.'),
                  leading: Icon(Icons.wifi),
                  backgroundColor: Colors.greenAccent,
                  actions: [SizedBox.shrink()],
                ),
              );
              await Future.delayed(const Duration(seconds: 3), () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner());
            }
          },
        ),
        BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state.status == WeatherForecastApiStatus.loaded) {
              Navigator.pop(context);
            } else if (state.status == WeatherForecastApiStatus.error) {
              Navigator.pop(context);
              showToast('Error fetching weather data');
            }
          },
        ),
        BlocListener<GeocodingBloc, GeocodingState>(
          listener: (context, state) {
            if (state.status == GeocodingApiStatus.emptyResponse) {
              Navigator.pop(context);
              showToast('Please enter a valid location');
            } else if (state.status == GeocodingApiStatus.loaded) {
              var coord = state.geoData!.split("|");
              context.read<WeatherBloc>().add(GetWeatherForecastEvent(lat: coord[0], long: coord[1]));
              if (coord.length == 3) {
                if (coord[2] != "null") {
                  setState(() {
                    currentLocation = coord[2];
                  });
                } else {
                  setState(() {
                    currentLocation = userInputLocation;
                  });
                }
              }
            } else if (state.status == GeocodingApiStatus.error) {
              Navigator.pop(context);
              showToast('Error fetching weather data');
            }
          },
        ),
      ],
      child: Scaffold(
        body: Container(
          height: context.mq.size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.lightBlue.shade200,
                Colors.lightBlue.shade400,
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                (context.mq.viewPadding.top * 2).heightBox,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_on_outlined, color: Colors.grey.shade50, size: 22),
                    4.widthBox,
                    currentLocation.text.bold.size(22).gray50.make(),
                    const Spacer(),
                  ],
                ).px(16),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state.status == WeatherForecastApiStatus.loaded) {
                      var todayForecast = state.weatherForecasts?.first;

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          20.heightBox,
                          Row(
                            children: [
                              GlassContainer(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    '${todayForecast?.temperature?.toInt()}°'.text.bold.size(70).gray50.make(),
                                    '${todayForecast?.weatherDescription}'.text.size(15).gray50.make(),
                                    'UV index: ${todayForecast?.uvIndexDescription}'.text.size(15).gray50.make(),
                                  ],
                                ).p12(),
                              ).pOnly(left: 16),
                              const Spacer(),
                              Lottie.asset('assets/${todayForecast?.weatherCode ?? 1000}.json', width: 120, height: 120),
                              const Spacer(),
                            ],
                          ),
                          12.heightBox,
                          GlassContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    WeatherDetail(
                                      icon: Icons.water_drop_outlined,
                                      label: 'Humidity:',
                                      value: "${todayForecast?.humidity?.round()}%",
                                    ),
                                    5.heightBox,
                                    WeatherDetail(
                                      icon: Icons.percent,
                                      label: 'Chance of rain:',
                                      value: "${todayForecast?.chanceOfRain?.round()}%",
                                    ),
                                    5.heightBox,
                                    WeatherDetail(icon: Icons.air_outlined, label: 'Wind speed:', value: "${todayForecast?.windSpeed?.round()}km/h"),
                                    5.heightBox,
                                    WeatherDetail(
                                        icon: Icons.sunny,
                                        label: 'Sunrise:',
                                        value: "${todayForecast?.sunriseTime?.hour}:${todayForecast?.sunriseTime?.minute}"),
                                    5.heightBox,
                                    WeatherDetail(
                                        icon: Icons.sunny_snowing,
                                        label: 'Sunset:',
                                        value: "${todayForecast?.sunsetTime?.hour}:${todayForecast?.sunsetTime?.minute}"),
                                  ],
                                ),
                              ],
                            ).p12(),
                          ).p16(),
                          12.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                state.weatherForecasts?.length ?? 0,
                                (index) => GlassContainer(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      5.heightBox,
                                      '${state.weatherForecasts?[index].time?.day} / ${state.weatherForecasts?[index].time?.month}'
                                          .text
                                          .bold
                                          .size(14)
                                          .gray50
                                          .make(),
                                      12.heightBox,
                                      Lottie.asset('assets/${state.weatherForecasts?[index].weatherCode ?? 1000}.json', width: 30, height: 30),
                                      '${state.weatherForecasts?[index].temperature?.round()}°'.text.bold.size(18).gray50.make(),
                                      Row(
                                        children: <Widget>[
                                          const Icon(Icons.water_drop_outlined, color: Colors.white, size: 14),
                                          "${state.weatherForecasts?[index].humidity?.round()}%".text.size(16).gray50.make(),
                                        ],
                                      ),
                                    ],
                                  ).p(12),
                                ).pOnly(left: 16, right: index + 1 == state.weatherForecasts?.length ? 16 : 0),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () async {
            String? location = await showTextFieldDialog(context);
            print(location ?? " ");
            if (location != null) {
              userInputLocation = location;
              showLoadingIndicator(context);
              context.read<GeocodingBloc>().add(GetCoordWithLocationName(locationName: location));
            }
          },
          backgroundColor: Colors.grey.shade50,
          child: const Icon(Icons.search_outlined),
        ),
      ),
    );
  }
}

class WeatherDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const WeatherDetail({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 15),
        5.widthBox,
        label.text.size(16).gray50.make(),
        const Spacer(),
        value.text.size(16).gray50.make(),
      ],
    );
  }
}
