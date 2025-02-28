import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_getways/payment_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   Map<String, dynamic>? paymentIntent;
  PaymentService paymentService = PaymentService();
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
                onPressed: () {
                  makePayment();

                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(200, 50),
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  "Pay",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }

   Future<void> makePayment() async {
     try {
       paymentIntent = await paymentService.createPaymentIntent("20", "USD");
       print("Payment Intent Created: $paymentIntent");

       await Stripe.instance.initPaymentSheet(
         paymentSheetParameters: SetupPaymentSheetParameters(
           paymentIntentClientSecret: paymentIntent!["client_secret"],
           style: ThemeMode.light,
           googlePay: PaymentSheetGooglePay(
             merchantCountryCode: "US",
             currencyCode: "USD",
             testEnv: true,
           ),
           merchantDisplayName: "Sabir's",
         ),
       );
       print("Payment Sheet Initialized");

       displayPaymentSheet();
     } catch (e) {
       print("Error in makePayment: $e");
     }
   }

   Future<void> displayPaymentSheet() async {
     try {
       print("Presenting Payment Sheet");
       await Stripe.instance.presentPaymentSheet();
       print("Payment Sheet Presented Successfully");

       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("Paid Successfully")),
       );
     } on StripeException catch (e) {
       print("StripeException: $e");
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("Canceled")),
       );
     } catch (e) {
       print("Error in displayPaymentSheet: $e");
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("Failed")),
       );
     }
   }
}
