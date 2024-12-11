import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/invoice_controller.dart';

class InvoiceView extends GetView<InvoiceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Invoice Generator")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    final product = controller.products[index];
                    return Row(
                      children: [
                        Expanded(child: Text(product.name)),
                        Expanded(
                          child: Column(
                            children: [
                              Text("Price: ${product.price.toStringAsFixed(2)} €"),
                              Text("GST: ${product.gstInPercent}%"),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () => controller.decrementProductAmount(product),
                              ),
                              Text(product.amount.toString()),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => controller.incrementProductAmount(product),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text("GST"), Obx(() => Text("${controller.vat.toStringAsFixed(2)} €"))],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text("Total"), Obx(() => Text("${controller.total.toStringAsFixed(2)} €"))],
            ),
            Center(
              child: ElevatedButton(
                onPressed: controller.generateInvoice,
                child: const Text("Create Invoice"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
