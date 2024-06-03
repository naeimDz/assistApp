import 'package:assistantsapp/controllers/enterprise/enterprise_provider.dart';
import 'package:assistantsapp/models/enterprise.dart';
import 'package:assistantsapp/utils/constants/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class EnterpriseDetailScreen extends StatelessWidget {
  const EnterpriseDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Enterprise? enterprise =
        Provider.of<EnterpriseProvider>(context, listen: false)
            .selectedEnterprise;

    if (enterprise == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Enterprise Details'),
        ),
        body: const Center(child: Text('No Enterprise Selected')),
      );
    }
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              // Handle subscribe action
            },
            child: Text(
              'Subscribe Now',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(enterprise.enterpriseName),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                color: AppColors.primary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    enterprise.logoUrl != ""
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(enterprise.logoUrl!),
                          )
                        : const CircleAvatar(
                            radius: 50,
                            child: Icon(
                              Icons.business,
                              size: 50,
                              color: AppColors.secondary,
                            ),
                          ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 17),
                        child: _buildInfoRow(Icons.email, enterprise.email)),
                    if (enterprise.phoneNumber != null &&
                        enterprise.phoneNumber != "")
                      _buildInfoRow(Icons.phone, enterprise.phoneNumber!),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          child: Icon(
                            Icons.location_on,
                            color: AppColors.secondary,
                            size: 40,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              enterprise.address?.province != ""
                                  ? enterprise.address!.province!
                                  : 'N/A',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              enterprise.address?.city != ""
                                  ? enterprise.address!.city!
                                  : 'N/A',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    /*  if (enterprise.description != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        enterprise.description!,
                        style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Owner Information',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    _buildInfoRow(Icons.person,
                        '${enterprise.firstNameOwner ?? ''} ${enterprise.lastNameOwner ?? ''}'),
                    */
                    const SizedBox(height: 20),
                    const Text(
                      'Assistants',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    _buildDocumentList(enterprise.appointments),
                    const SizedBox(height: 20),
                    /*  const Text(
                      'Appointments',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    _buildDocumentList(enterprise.subscriptions),*/
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildInfoRow(IconData icon, String info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: AppColors.secondary),
        const SizedBox(width: 10),
        Center(
          child: Text(
            info,
            style: const TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentList(List<DocumentReference>? documents) {
    if (documents == null || documents.isEmpty) {
      return const Text('No items available.',
          style: TextStyle(color: Colors.grey));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: documents.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.document_scanner),
          title: Text('Document ${index + 1}'),
          onTap: () {
            // Handle document tap
          },
        );
      },
    );
  }
}
