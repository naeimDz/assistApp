import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';

class PricingComponent extends StatefulWidget {
  const PricingComponent({super.key});

  @override
  PricingComponentState createState() => PricingComponentState();
}

class PricingComponentState extends State<PricingComponent> {
  double _pageViews = 1.0;
  double _priceSubscription = 1600.0;
  double _price = 1600.0;
  bool _yearlyBilling = false;
  int _numberAssistants = 1;

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
          if (_numberAssistants != 0) {
            _pageViews = _numberAssistants.toDouble();
            _updatePrice(_pageViews);
          } else {
            _updatePrice(1);
          }
        });
      }
    }
  }

  void _updatePrice(double pageViews) {
    setState(() {
      _pageViews = pageViews;
      _price = (_pageViews / 1) * _priceSubscription;
      if (_yearlyBilling) {
        _price *= 0.75; // Apply 25% discount
      }
    });
  }

  void _toggleBillingMode() {
    setState(() {
      _yearlyBilling = !_yearlyBilling;
      _updatePrice(_pageViews);
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
              'You have $_numberAssistants Assistants',
              style: const TextStyle(fontSize: 24),
            ),
            Slider(
              value: _pageViews,
              min: 1,
              max: 16,
              divisions: 15,
              label: _pageViews.round().toString(),
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
                const Text('Yearly Billing (25% discount)'),
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
