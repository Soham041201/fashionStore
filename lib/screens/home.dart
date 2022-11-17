import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/screens/checkout.dart';
import 'package:ecommerce/services/product.dart';
import 'package:ecommerce/services/sqlf.dart';
import 'package:ecommerce/widgets/product_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/bottom_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  int limit = 10;
  bool isLoading = true;
  List<Product> products = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    /* 
    Checking if the data if fetched from the API. If not,
    then return the cached data.
    */

    if (isLoading) {
      ProductDatabase.instance.readAllProducts().then((value) => {
            setState(() {
              products = value;
            })
          });
    }

    ProductService.getProducts(limit: 10).then((value) async {
      /*
      If the data is fetched from the API, then try it to the cache database.
      (If the data is already in the database, then it will be ignored)
      */

      try {
        await ProductDatabase.instance.addAll(value);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      setState(() {
        isLoading = false;
        products = value;
      });
    });

    setState(() {
      currentIndex = 0;
    });

    /*
      Add's a listener to the scroll controller which
      controlls the pagination in the home page
     */

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        setState(() {
          limit += 10;
        });

        ProductService.getProducts(limit: limit).then((value) {
          /* 
          Since the mock API contains only the option to limit (and not skip, as in the case of pagination),
          I had to get a little bit creative here. I'm not sure if this is the best way to do it, but it works.
          */

          List<Product> fetchedList = value;
          List<Product> uList = fetchedList
              .where((element) => fetchedList.indexOf(element) > limit - 11)
              .toList();

          setState(() {
            products.addAll(uList);
          });
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    ProductDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              padding: const EdgeInsets.only(left: 20),
              onPressed: () {},
              icon: SvgPicture.asset(
                'icons/drawer.svg',
                color: const Color(0xFF1C1C19),
                width: 24,
                height: 24,
              ),
            ),
            actions: [
              IconButton(
                padding: const EdgeInsets.only(right: 20),
                onPressed: () {},
                icon: SvgPicture.asset(
                  'icons/search.svg',
                  color: const Color(0xFF1C1C19),
                  width: 20,
                  height: 20,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.5, 1],
                  colors: [
                    const Color(0xFFF3F4F6),
                    const Color(0xFFF3F4F6).withOpacity(0.9)
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text(
                      'New Arrivals',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ],
                ),
              ),
            )),
        body: GridView.builder(
          controller: scrollController,
          itemBuilder: (context, index) => ProductCard(
            product: products[index],
            onAdd: (product) => {
              //Removing the product from the list if it's already in the cart!
              setState(() {
                products.remove(product);
              })
            },
          ),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.5, crossAxisSpacing: 1),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Checkout(),
                ),
              );
            } else {
              setState(() {
                currentIndex = index;
              });
            }
          },
          elevation: 10,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'icons/home.svg',
                color: const Color(0xFF1C1C19),
                width: 20,
                height: 20,
              ),
              activeIcon: const ActiveBottomTab(),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'icons/cart.svg',
                color: const Color(0xFFAFBEC4),
                width: 20,
                height: 20,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
