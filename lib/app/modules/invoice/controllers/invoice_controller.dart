import 'package:get/get.dart';
import '../../../data/models/product.dart';
import '../../../data/services/pdf_invoice_service.dart';

class InvoiceController extends GetxController {
  final PdfInvoiceService _pdfInvoiceService = PdfInvoiceService();

  var products = <Product>[
  Product(name: "Membership", price: 9.99, gstInPercent: 19),
  Product(name: "Nails", price: 0.30, gstInPercent: 19),
  Product(name: "Hammer", price: 26.43, gstInPercent: 19),
  Product(name: "Hamburger", price: 5.99, gstInPercent: 7),
].obs;


  var invoiceNumber = 0.obs;

  double get total => products.fold(
      0.0, (sum, product) => sum + (product.price * product.amount));

  double get vat => products.fold(
      0.0,
      (sum, product) =>
          sum + (product.price / 100 * product.gstInPercent * product.amount));

  Future<void> generateInvoice() async {
    final data = await _pdfInvoiceService.createInvoice(products);
    await _pdfInvoiceService.savePdfFile("invoice_${invoiceNumber.value}", data);
    invoiceNumber.value++;
  }

  void incrementProductAmount(Product product) {
    product.amount++;
    products.refresh();
  }

  void decrementProductAmount(Product product) {
    if (product.amount > 0) {
      product.amount--;
      products.refresh();
    }
  }
}
