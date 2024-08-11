import 'package:alternance_flutter/utils/OnboardingUtils.dart';
import 'package:alternance_flutter/views/OnboardingPage.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bool isOnboardingDone = await OnboardingUtils.isOnboardingDone();

  runApp(MyApp(isOnboardingDone: isOnboardingDone));
}

class MyApp extends StatelessWidget {
  final bool isOnboardingDone;

  const MyApp({super.key, required this.isOnboardingDone});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isOnboardingDone
          ? const MyHomePage(title: "hello")
          : const OnboardingPage(),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          children: [Text("hello wolrd")],
        ),
      ),
    );
  }
}
