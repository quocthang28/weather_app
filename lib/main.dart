import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:weather_app/bloc/network_connectivity_bloc/network_connectivity_bloc.dart';
import 'package:weather_app/di/service_locator.dart';
import 'package:weather_app/ui/common_widgets/glass_container.dart';
import 'package:weather_app/ui/common_widgets/loading_indicator.dart';
import 'package:weather_app/ui/search.dart';

void main() {
  ServiceLocator.setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider<NetworkConnectivityBloc>(create: (context) => NetworkConnectivityBloc()..add(InitializeConCheckerEvent())),
      ], child: const MyHomePage(title: 'Flutter Demo Home Page')),
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
  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkConnectivityBloc, NetworkConnectivityState>(
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
      child: Scaffold(
        body: Container(
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                (context.mq.viewPadding.top * 2).heightBox,
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: Colors.grey.shade50, size: 22),
                    4.widthBox,
                    'Ho Chi Minh City'.text.bold.size(22).gray50.make(),
                    const Spacer(),
                    Icon(Icons.search_outlined, color: Colors.grey.shade50, size: 30).pOnly(right: 8).onTap(() {
                      showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(),
                      );
                    }),
                  ],
                ).px(16),
                20.heightBox,
                Row(
                  children: [
                    GlassContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          '33°'.text.bold.size(70).gray50.make(),
                          'Partly Cloudy'.text.size(15).gray50.make(),
                          '34° / 25° Feels like 39°'.text.size(15).gray50.make(),
                        ],
                      ).p12(),
                    ).pOnly(left: 16),
                    const Spacer(),
                    Lottie.asset('assets/sun-raining.json', width: 120, height: 120),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () async {
            if (await Permission.locationWhenInUse.request().isGranted) {
              LocationData locationData = await Location().getLocation();
              print(locationData.latitude);
              print(locationData.longitude);
            } else {
              Fluttertoast.showToast(
                  msg: 'Please allow location permission in order to get weather data of your current place.',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  textColor: Colors.grey,
                  fontSize: 12.0
              );
            }
          },
          backgroundColor: Colors.grey.shade50,
          child: const Icon(Icons.location_searching_outlined),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}