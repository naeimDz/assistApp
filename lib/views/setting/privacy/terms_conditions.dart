import 'package:flutter/material.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms Conditions'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 17),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                '1. Types of Data We Collect',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We may collect the following types of data:',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                'Personal Information: This includes but is not limited to your name, email address, and other contact details provided during account registration or usage of our services.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                'Usage Information: We may collect information about how you interact with our services, including but not limited to IP addresses, device information, and browsing history.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                'Cookies and Similar Technologies: We use cookies and similar technologies to enhance your experience and gather information about your preferences.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '2. Use of Your Personal Data',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We may use your personal data for the following purposes:',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                'Service Delivery: To provide and maintain our services, including personalized content and features.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                'Communication: To communicate with you, respond to your inquiries, and provide important information about our services.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                'Analytics: To analyze usage patterns, improve our services, and customize content based on user preferences.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '3. Disclosure of Your Personal Data',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We may disclose your personal data in the following situations:',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                'Legal Obligations: To comply with legal obligations, such as responding to lawful requests or court orders.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                'Third-Party Service Providers: We may share your information with third-party service providers who assist us in delivering our services, subject to confidentiality agreements.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                'Business Transactions: In the event of a merger, acquisition, or sale of all or a portion of our assets, your personal data may be transferred as part of the transaction.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
