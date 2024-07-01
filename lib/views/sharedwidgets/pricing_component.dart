import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';

class PricingComponent extends StatefulWidget {
  const PricingComponent({super.key});

  @override
  PricingComponentState createState() => PricingComponentState();
}

class PricingComponentState extends State<PricingComponent> {
  double _numberClients = 10.0;
  double _priceSubscription = 25000.00;
  double _price = 1600.0;
  bool _yearlyBilling = false;
  int _numberAssistants = 10;
  double discount = 0.8; //20% discount

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userStream = FirestoreService().getCurrentUserDataStream();
    if (userStream != null) {
      final snapshot = await userStream;
      if (snapshot.exists) {
        final userData = snapshot.data()!;
        setState(() {
          List<String> assistants =
              userData['assistants']?.cast<String>() ?? [];
          _numberAssistants = assistants.length;
          if (_numberAssistants > 10) {
            _numberClients = _numberAssistants.toDouble();
            _updatePrice(_numberClients);
          } else {
            _updatePrice(10);
          }
        });
      }
    }
  }

  void _updatePrice(double pageViews) {
    setState(() {
      _numberClients = pageViews;
      _price = (_numberClients / 50) * _priceSubscription;
      if (_yearlyBilling) {
        _price *= discount; // Apply discount
      }
    });
  }

  void _toggleBillingMode() {
    setState(() {
      _yearlyBilling = !_yearlyBilling;
      _updatePrice(_numberClients);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have $_numberAssistants Clients',
              style: const TextStyle(fontSize: 24),
            ),
            Slider(
              value: _numberClients,
              min: 10,
              max: 200,
              divisions: 19,
              label: _numberClients.round().toString(),
              onChanged: (double value) {
                _updatePrice(value);
              },
            ),
            const SizedBox(height: 20),
            Text(
              '\DZD ${_price.toStringAsFixed(2)} / month',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Monthly Billing'),
                Switch(
                  value: _yearlyBilling,
                  onChanged: (value) {
                    _toggleBillingMode();
                  },
                ),
                const Text('Yearly Billing (20% discount)'),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Pay Now'),
            ),
            const SizedBox(height: 20),
            const Column(
              children: [
                ListTile(
                  leading: Icon(Icons.check),
                  title: Text('More accurate'),
                ),
                ListTile(
                  leading: Icon(Icons.check),
                  title: Text('Schedules reports'),
                ),
                ListTile(
                  leading: Icon(Icons.check),
                  title: Text('Unlimited scheduling'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
