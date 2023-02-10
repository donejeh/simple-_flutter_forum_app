import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:testing/views/home.dart';
import 'package:testing/views/register.dart';
import 'views/login.dart';
import 'package:get/get.dart';
void main(){
  runApp(MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Forum App',
       home: token == null ? const LoginPage() : const HomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


