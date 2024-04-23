import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/provider.dart';

void uploadProvidersToFirestore(List<Provider> providers) async {
  print("okay im here what next");
  CollectionReference providersCollection =
      FirebaseFirestore.instance.collection('providers');

  for (Provider provider in providers) {
    await providersCollection.doc(provider.id).set(provider.toMap());
  }
}
