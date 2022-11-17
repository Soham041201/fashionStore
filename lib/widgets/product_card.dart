import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/provider/product_provider.dart';
import 'package:ecommerce/widgets/product_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.onAdd});

  final Product product;
  final Function onAdd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: (() => {
            showDialog(
                context: context,
                builder: (context) => ProductBox(
                      product: product,
                    ))
          }),
      child: Container(
        
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 180,
              width: 165,
              child: InkWell(
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(product.category,
                style: Theme.of(context).textTheme.bodyText2),
            Text(
              product.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$ ${product.price}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w800)),
                IconButton(
                  onPressed: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .addProduct(product);
                    onAdd(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 200),
                        content: Text('Product added to cart'),
                      ),
                    );
                  },
                  icon: SvgPicture.asset(
                    'icons/cart.svg',
                    height: 21,
                    width: 15,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
