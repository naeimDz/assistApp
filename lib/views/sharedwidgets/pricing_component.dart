import 'package:flutter/material.dart';

class PricingComponent extends StatefulWidget {
  @override
  _PricingComponentState createState() => _PricingComponentState();
}

class _PricingComponentState extends State<PricingComponent> {
  double _pageViews = 1;
  double _price = 16.0;
  bool _yearlyBilling = false;

  void _updatePrice(double pageViews) {
    setState(() {
      _pageViews = pageViews;
      _price = (_pageViews / 1) * 16;
      if (_yearlyBilling) {
        _price *= 0.75; // Apply 25% discount
      }
    });
  }

  void _toggleBillingMode() {
    setState(() {
      _yearlyBilling = !_yearlyBilling;
      _price = (_pageViews / 1) * 16;
      if (_yearlyBilling) {
        _price *= 0.75; // Apply 25% discount
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_pageViews.toInt()} Assistants',
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
            SizedBox(height: 20),
            Text(
              '\$${_price.toStringAsFixed(2)} / month',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Monthly Billing'),
                Switch(
                  value: _yearlyBilling,
                  onChanged: (value) {
                    _toggleBillingMode();
                  },
                ),
                Text('Yearly Billing (25% discount)'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('Start my trial'),
            ),
            SizedBox(height: 20),
            const Column(
              children: [
                ListTile(
                  leading: Icon(Icons.check),
                  title: Text('more accurate'),
                ),
                ListTile(
                  leading: Icon(Icons.check),
                  title: Text('scheduls reports'),
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
