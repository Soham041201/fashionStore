import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';

class ProductBox extends StatelessWidget {
  const ProductBox({super.key, required this.product});

  final Product product;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        product.title,
        style: Theme.of(context).textTheme.headline1,
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: double.maxFinite,
        child: ListView(
          children: [
            Text(
              product.category.toUpperCase(),
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 15,
            ),
            CachedNetworkImage(
              imageUrl: product.image,
              width: 200,
              height: 200,
              alignment: Alignment.center,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              product.description,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
            ),
            const SizedBox(
              height: 12,
            ),
            Stack(alignment: Alignment.center, children: [
              Opacity(
                opacity: 0.1,
                child: Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6B718B),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
              Text(
                '\$${product.price}',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
