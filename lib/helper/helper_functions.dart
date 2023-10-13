import 'package:latlong2/latlong.dart';
import 'package:mytradeasia/features/data/model/cart_models/cart_models.dart';
import 'package:mytradeasia/features/domain/entities/product_entities/product_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

dynamic parseDoubleToIntegerIfNecessary(double input) {
  String inputString = input.toString();

  // Check if the input string ends with ".0"
  if (inputString.endsWith('.0')) {
    return int.parse(inputString.split('.').first);
  } else {
    return input;
  }
}

CartModel castProductEntityToCartModel(
    {required ProductEntity product,
    required double quantity,
    required String unit}) {
  return CartModel(
      productName: product.productname,
      productImage: product.productimage,
      hsCode: product.hsCode,
      casNumber: product.casNumber,
      seoUrl: product.seoUrl,
      quantity: quantity,
      unit: unit);
}

LatLng listDoubleToLatLng(List<double> list) {
  return LatLng(list.first, list.last);
}

List<LatLng> toListLatLng(List<List<double>> list) {
  List<LatLng> newList = [];
  for (var element in list) {
    newList.add(LatLng(element.first, element.last));
  }
  return newList;
}

Future<bool> canCallApi() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int lastCall = prefs.getInt('lastApiCall') ?? 0;
  int now = DateTime.now().millisecondsSinceEpoch;
  int oneDay = 24 * 60 * 60 * 1000; // Milliseconds in a day

  if (now - lastCall >= oneDay) {
    prefs.setInt('lastApiCall', now); // Update the last call time
    return true; // More than a day has passed since the last call
  }
  return false; // Less than a day has passed since the last call
}
