import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shopnbuy/core/models/product.dart';
import 'package:shopnbuy/core/services/api.dart';
import 'package:shopnbuy/core/viewmodels/product_list_model.dart';
import 'package:shopnbuy/helpers/dependency_assembly.dart';

class MockAPI extends Mock implements API {}

// TODO 5: Declare a Mock Product

void main() {
  ProductListModel productListViewModel;

  setUp(() {
    ///The test suite runs separately from main() in main.dart,
    ///so you need to call setupDependencyAssembler() to inject your dependencies.
    setupDependencyAssembler();

    ///You create an instance of ProductListModel using GetIt.
    productListViewModel = dependencyAssembler<ProductListModel>();

    /// You create and assign an instance of the MockAPI class you defined above.
    productListViewModel.api = MockAPI();
  });

  // TODO 6: Inject Cart View Model

  // TODO 4: Write Product List Page Test Cases
  group("getProductList", () {
    final productList = [
      Product(
        id: 1,
        name: "MacBook Pro 16-inch model",
        price: 2399,
        imageUrl: "imageUrl",
      ),
      Product(
        id: 2,
        name: "AirPods Pro",
        price: 249,
        imageUrl: "imageUrl",
      ),
    ];
    test("should load a list of products from firebase", () async {
      // arrange
      when(() => productListViewModel.api.getProducts())
          .thenAnswer((invocation) async => productList);
      // act
      /// Since the function passed to the test method is marked as async,
      /// each line in the closure runs synchronously, so you start by
      /// calling getProducts().
      await productListViewModel.getProducts();
      // assert
      verify(() => productListViewModel.api.getProducts());

      /// You then assert the length of the list based on the mock
      /// data you supplied in the MockAPI.
      expect(productListViewModel.products.length, 2);

      ///Finally, you assert each product’s name and price.
      expect(
          productListViewModel.products[0].name, 'MacBook Pro 16-inch model');
      expect(productListViewModel.products[0].price, 2399);
      expect(productListViewModel.products[1].name, 'AirPods Pro');
      expect(productListViewModel.products[1].price, 249);
    });
  });

  // TODO 7: Write Add to Cart Logic Test Case
}
