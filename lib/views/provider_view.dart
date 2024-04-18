import 'package:assistantsapp/controllers/provider_controller.dart';
import 'package:assistantsapp/models/provider.dart';

class ProviderView {
  final ProviderController _controller = ProviderController();

  Future<Provider?> getProvider(String id) async {
    try {
      Provider provider = await _controller.getProviderById(id);
      return provider;
    } catch (e) {
      print('Failed to get provider: $e');
      return null;
    }
  }
}
