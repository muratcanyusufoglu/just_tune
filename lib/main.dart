import 'package:drum_machine/product/screen/add_drim/provider/add_trim_provider.dart';
import 'package:drum_machine/product/screen/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();
final directory = await getApplicationDocumentsDirectory();
Hive.init(directory.path);

  await Hive.openBox('audioBox');
  runApp(MultiProvider(providers: [ChangeNotifierProvider<AddTrimProvider>(create: (_) => AddTrimProvider())], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(primary: Colors.white, secondary: Colors.white54, seedColor: Colors.red, background: Colors.black),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
        ),
        textTheme: TextTheme(bodySmall: TextStyle(fontSize: 15.0,color: Theme.of(context).colorScheme.primary), titleMedium: TextStyle(fontSize: 15.0,color: Theme.of(context).colorScheme.background), titleLarge: TextStyle(fontSize: 20.0,color: Theme.of(context).colorScheme.primary))
      ),
      home: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
