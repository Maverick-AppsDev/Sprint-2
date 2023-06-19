import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprint1/components/constant.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:sprint1/pages/customer/order_page_cust.dart';

class PaymentPage extends StatefulWidget {
  final String email;
  final int tableNum;
  final double totalPrice;

  const PaymentPage({Key? key, required this.email, required this.tableNum, required this.totalPrice})
      : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0xfffd2e6),
        title: Text("Payment Page"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Image.asset("lib/images/payment.png", height: 100),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 150,
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[300],
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      // Logic for paying in the counter
                      showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    title:
                                        Text("Total Amount: RM${widget.totalPrice.toStringAsFixed(2)}"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Done"),
                                      ),
                                    ]);
                              });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("lib/images/cash-machine.png", height: 50),
                        SizedBox(height: 10),
                        Text("Pay in the Counter"),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 150,
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[300],
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      // Logic for paying using TNG
                      // Open e-wallet or redirect to TNG payment page
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("lib/images/tng.png", height: 50),
                        SizedBox(height: 10),
                        Text("Pay using TNG"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 150,
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[300],
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async {
                      // Logic for paying using sandbox card
                      // Wait for a short delay (optional)
                      await Future.delayed(Duration(milliseconds: 500));

                      // Start the Square payment flow
                      InAppPayments.setSquareApplicationId(
                          'sq0idp-drWydbdJHlAH4cNJ8H7TBQ');
                      await InAppPayments.startCardEntryFlow(
                        onCardNonceRequestSuccess: _onCardNonceRequestSuccess,
                        onCardEntryCancel: _onCardEntryCancel,
                        collectPostalCode: false,
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("lib/images/atm-card.png", height: 50),
                        SizedBox(height: 10),
                        Text("Pay using Card"),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 150,
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[300],
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      // Logic for navigating to the order tracking page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderPage(email: widget.email)),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("lib/images/food.png", height: 50),
                        SizedBox(height: 10),
                        Text("Track Order Page"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Not complete yet
  void _onCardNonceRequestSuccess(CardDetails cardDetails) {
    // Handle the card nonce request success
    // Use the card details to process the payment
    // ...
    InAppPayments.completeCardEntry(onCardEntryComplete: _onCardEntryComplete);

    print('Card nonce: ${cardDetails.nonce}');
  }

  void _onCardEntryComplete() {
    // Handle the card entry completion
    // Perform any necessary cleanup or navigation
    // ...

    print('Card entry complete');
  }

  void _onCardEntryCancel() {
    // Handle the card entry cancellation
    // Perform any necessary cleanup or navigation
    // ...

    print('Card entry canceled');
  }
}