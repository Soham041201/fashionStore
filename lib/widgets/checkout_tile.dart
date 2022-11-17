import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';

class ProductCheckoutTile extends StatelessWidget {
  const ProductCheckoutTile(
      {Key? key,
      required this.product,
      required this.onAdd,
      required this.onRemove})
      : super(key: key);

  final Product product;
  final Function onAdd;
  final Function onRemove;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      visualDensity: VisualDensity.comfortable,
      horizontalTitleGap: 5,
      minVerticalPadding: 10,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      leading: CachedNetworkImage(
        imageUrl: product.image,
        width: 80,
        height: 80,
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                product.title,
                overflow: TextOverflow.clip,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            Text(
              '\$ ${product.price}',
              style: Theme.of(context).textTheme.headline1,
            ),
          ],
        ),
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Size:',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(width: 5),
              Text('M',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.w800)),
            ],
          ),
          Row(
            children: [
              Text(
                'Color:',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2)),
              ),
            ],
          ),
          ProductQuantity(
            price: product.price,
            onQuantityDecrease: onRemove,
            onQuantityIncrease: onAdd,
            quantity: product.quantity,
          )
        ],
      ),
    );
  }
}

class ProductQuantity extends StatefulWidget {
  const ProductQuantity(
      {super.key,
      required this.price,
      required this.onQuantityIncrease,
      required this.onQuantityDecrease,
      this.quantity});

  final double price;
  final Function onQuantityIncrease;
  final Function onQuantityDecrease;
  final int? quantity;

  @override
  State<ProductQuantity> createState() => _ProductQuantityState();
}

class _ProductQuantityState extends State<ProductQuantity> {
  int tempQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              tempQuantity = widget.quantity!;
              if (tempQuantity > 1) {
                setState(() {
                  tempQuantity--;
                });
                widget.onQuantityDecrease();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFAFBEC4)),
              ),
              child: const Icon(
                Icons.remove,
                size: 14,
                color: Color(0xFF1C1C19),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            widget.quantity != null
                ? widget.quantity.toString()
                : tempQuantity.toString(),
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                tempQuantity++;
              });
              widget.onQuantityIncrease();
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFAFBEC4)),
              ),
              child: const Icon(
                Icons.add,
                size: 14,
                color: Color(0xFF1C1C19),
              ),
            ),
          ),
        ]);
  }
}
