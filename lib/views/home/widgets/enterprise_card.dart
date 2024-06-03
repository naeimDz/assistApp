import 'package:assistantsapp/controllers/enterprise/enterprise_provider.dart';
import 'package:assistantsapp/utils/constants/app_colors.dart';
import 'package:assistantsapp/utils/routes/route_name_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/enterprise.dart';

class EnterpriseCard extends StatelessWidget {
  final Enterprise enterprise;
  const EnterpriseCard({super.key, required this.enterprise});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<EnterpriseProvider>(context, listen: false)
            .selectEnterprise(enterprise.enterpriseID)
            .then((_) {
          Navigator.pushNamed(context, RouteNameStrings.enterpriseDetailScreen);
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                enterprise.enterpriseName,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackText),
              ),
              /* SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.business,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 10),
                 Expanded(
                    child: Text(
                      enterprise.description ?? '',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),*/
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.email,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      enterprise.email,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (enterprise.phoneNumber != null) ...[
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        enterprise.phoneNumber != ''
                            ? enterprise.phoneNumber!
                            : "No Phone Number",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.money,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "${enterprise.price ?? 'N/A'} DA",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
