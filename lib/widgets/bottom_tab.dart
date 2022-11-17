import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActiveBottomTab extends StatelessWidget {
  const ActiveBottomTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Opacity(
        opacity: 0.1,
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
            color: const Color(0xFF6B718B),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(
            'icons/home.svg',
            color: Colors.black,
            width: 20,
            height: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Text('Home', style: Theme.of(context).textTheme.bodyText1),
        ],
      ),
    ]);
  }
}
