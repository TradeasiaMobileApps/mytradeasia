import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/domain/entities/detail_product_entities/detail_product_entities.dart';
import 'package:mytradeasia/features/domain/usecases/detail_product_usecases/get_detail_product.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockDetailProductRepository mockDetailProductRepository;
  late GetDetailProduct getDetailProduct;

  setUp(() {
    mockDetailProductRepository = MockDetailProductRepository();
    getDetailProduct = GetDetailProduct(mockDetailProductRepository);
  });

  String seoUrl = "https://tradeasia.sg/en/Acrylonitrile";

  test('Should get DataSuccess containing product detail', () async {
    //arrange
    when(mockDetailProductRepository.getDetailProductRepo(seoUrl)).thenAnswer(
        (_) async => const DataSuccess(DetailsProductEntity(
            detailProduct: DetailProduct(
                productname: "productname",
                productimage: "productimage",
                iupacName: "iupacName",
                casNumber: "casNumber",
                hsCode: "hsCode",
                formula: "formula",
                description: "description",
                application: "application",
                packagingName: "packagingName"),
            listIndustry: [],
            listCategory: [],
            relatedProducts: [])));

    //act
    final result = await getDetailProduct.call(param: seoUrl);

    //assert
    expect(result is DataSuccess, true);
  });
}
