import 'dart:convert';
import 'dart:math';

import 'package:chapasdk/chapasdk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/payment_method.dart';
import '../../../../core/constants/assets.dart';

class PaymentMethodScreen extends StatefulWidget {
  final double amount;

  const PaymentMethodScreen({
    Key? key,
    required this.amount,
  }) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  // Mock payment methods - replace with actual data later
  final List<PaymentMethod> paymentMethods = [
    PaymentMethod(
      id: '1',
      name: 'Pay with Chapa',
      icon: 'assets/icons/chapa.png',
      isChapa: true,
      isSelected: true,
    ),
    PaymentMethod(
      id: '2',
      name: 'Cash on Delivery',
      icon: 'assets/icons/cash.png',
      isCashOnDelivery: true,
      codFee: 24.00,
    ),
  ];

  PaymentMethod? selectedMethod;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    selectedMethod = paymentMethods.first;
  }
  // Future<void> verify() async {
  //   Map<String, dynamic> verificationResult =
  //       await Chapa.getInstance.verifyPayment(
  //     txRef: TxRefRandomGenerator.gettxRef,
  //   );
  //   if (kDebugMode) {
  //     print(verificationResult);
  //   }
  // }

  // Future<void> pay() async {
  //   try {
  //     // Generate a random transaction reference with a custom prefix
  //     String txRef = TxRefRandomGenerator.generate(prefix: 'linat');

  //     // Access the generated transaction reference
  //     String storedTxRef = TxRefRandomGenerator.gettxRef;

  //     // Print the generated transaction reference and the stored transaction reference
  //     if (kDebugMode) {
  //       print('Generated TxRef: $txRef');
  //       print('Stored TxRef: $storedTxRef');
  //     }
  //     await Chapa.getInstance.startPayment(
  //       context: context,
  //       onInAppPaymentSuccess: (successMsg) {
  //         print(successMsg);
  //         // Handle success events
  //       },
  //       onInAppPaymentError: (errorMsg) {
  //         print(errorMsg);
  //         // Handle error
  //       },
  //       amount: '1000',
  //       currency: 'ETB',
  //       txRef: storedTxRef,
  //     );
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  // }

  Future<void> _handleChapaPayment() async {
    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      final txRef = 'tx-${DateTime.now().millisecondsSinceEpoch}';

      // await Chapa.paymentParameters(
      //   context: context,
      //   publicKey:
      //       'CHAPUBK_TEST-vPyKZqPxPWCT6EPYB1wPZ6QvPuJSpBrU', // Replace with your public key
      //   currency: 'ETB',
      //   amount: widget.amount.toString(),
      //   email: 'customer@email.com', // Replace with actual customer email
      //   firstName: 'John', // Replace with actual customer first name
      //   lastName: 'Doe', // Replace with actual customer last name
      //   txRef: txRef,
      //   phone: '0911223344', // Replace with actual customer phone
      //   title: 'Order Payment',
      //   desc: 'Payment for order #$txRef',
      //   namedRouteFallBack: '/home',
      // );
      //  print(result);
      // final ret = jsonDecode(result)['status'];

      // if (ret == 'error') {
      //   throw Exception(result['message']);
      // }
      // final status = result['status'] ?? 'error';
      // if (status == 'error') {
      //   throw Exception(result['message']);
      // }
      // Handle success
      if (mounted) {
        print("mounted");
        print(mounted);
        Navigator.pop(context, {
          'method': selectedMethod,
          'txRef': txRef,
          'status': 'success',
          'amount': widget.amount,
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Payment method'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: paymentMethods.map((method) {
                final isSelected = method.id == selectedMethod?.id;
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: ChoiceChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          method.isCashOnDelivery
                              ? Icons.payments_outlined
                              : Icons.payment,
                          size: 20,
                          color: isSelected ? Colors.white : Colors.grey[700],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          method.name,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      if (selected) {
                        setState(() {
                          selectedMethod = method;
                        });
                      }
                    },
                    selectedColor: Theme.of(context).primaryColor,
                    backgroundColor: Colors.grey[100],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                if (selectedMethod?.isChapa == true) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/koricha/chapa.png',
                        height: 200,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Pay with Chapa',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          'Choose from multiple payment methods including telebirr, cbebirr, mpesa and ebirr.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (selectedMethod?.isCashOnDelivery == true) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/Illustration/PayWithCash_lightTheme.png',
                        height: 200,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Cash on Delivery',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          children: [
                            Text(
                              'A fee of \$${selectedMethod?.codFee?.toStringAsFixed(2)} will be added to your order for Cash on Delivery.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey[600],
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Total amount to pay: \$${(widget.amount + (selectedMethod?.codFee ?? 0)).toStringAsFixed(2)}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              // height: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedMethod?.isChapa == true) {
                    var r = Random();

                    const chars =
                        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                    String transactionRef = List.generate(
                        10, (index) => chars[r.nextInt(chars.length)]).join();

                    Chapa.paymentParameters(
                      context: context, // context
                      publicKey:
                          'CHAPUBK_TEST-Z3Dt5ZOlmG8Fmm9SDjJTSn4ykGfIQ2ms',
                      currency: 'ETB',
                      amount: widget.amount.toString(),
                      email: 'fetan@chapa.co',
                      phone: '0964001822',
                      firstName: 'Israel',
                      nativeCheckout: true,
                      lastName: 'Goytom',
                      txRef: transactionRef,
                      title: 'Test Payment',
                      desc: 'Text Payment',
                      namedRouteFallBack: "",
                      showPaymentMethodsOnGridView: true,
                      // availablePaymentMethods: [
                      //   'mpesa',
                      //   'cbebirr',
                      //   'telebirr',
                      //   'ebirr',
                      // ],
                      onPaymentFinished: (message, reference, amount) {
                        print(message);
                        print(reference);
                        print(amount);
                        Navigator.pop(context);
                      },
                    );
                  } else {
                    Navigator.pop(context, selectedMethod);
                  }
                },
                // _isProcessing
                // ? null
                // : () {
                //     if (selectedMethod?.isChapa == true) {
                //       _handleChapaPayment();
                //     } else {
                //       Navigator.pop(context, selectedMethod);
                //     }
                //   },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isProcessing
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        selectedMethod?.isChapa == true ? 'Pay Now' : 'Confirm',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
