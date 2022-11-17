import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/provider/product_provider.dart';
import 'package:ecommerce/widgets/checkout_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  List<Product> products = [];
  double total = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      products =
          Provider.of<ProductProvider>(context, listen: false).getProducts();
      products.map((e) => total += e.price * e.quantity).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'icons/back.svg',
            color: const Color(0xFF1C1C19),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Your Cart',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: ListView.builder(
          itemCount: products.length,
          itemBuilder: ((context, index) => ProductCheckoutTile(
                product: products[index],
                // Handles the quantity change in the product card
                onAdd: () => {
                  setState(() {
                    total += products[index].price;
                  }),
                  Provider.of<ProductProvider>(context, listen: false)
                      .increaseQuantity(products[index].id, true)
                },
                onRemove: () => {
                  setState(() {
                    total -= products[index].price;
                  }),
                  Provider.of<ProductProvider>(context, listen: false)
                      .increaseQuantity(products[index].id, false)
                },
              ))),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Price:',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  '\$ ${total.toStringAsFixed(2)}',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 24),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 24.0, right: 24, bottom: 24, top: 16),
            child: MaterialButton(
              minWidth: double.infinity,
              color: Colors.black,
              onPressed: () {},
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              child: Text('Payment',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
