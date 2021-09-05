import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quicksell_android_task/presentation/screens/list_screen.dart';
import 'package:quicksell_android_task/presentation/screens/paginated_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaginatedListScreen(),
    );
  }
}
