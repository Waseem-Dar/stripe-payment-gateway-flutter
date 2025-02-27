import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stripe Payment"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                 fixedSize: Size(200, 50),
                  backgroundColor: Colors.green,
                ),
                child: Text("Pay",style: TextStyle(color: Colors.white),))
          ],
        ),
      ),
    );
  }
}
