import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/controllers/home_screen_controller.dart';
import 'package:shopping/main.dart';
import 'package:shopping/view/cart_screen/cart_screen.dart';
import 'package:shopping/view/product_details_screen/product_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => context.read<HomeScreenController>().getcategory());
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSelectedIndex(int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    final categoryWidth = screenWidth /
        3; // Adjust this width based on the item width (container + padding)
    final targetOffset =
        (index * categoryWidth) - (screenWidth / 2) + (categoryWidth / 2);

    _scrollController.animateTo(
      targetOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Discover",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ));
                },
                icon: Icon(Icons.shopping_bag)),
            Stack(
              children: [
                Icon(
                  Icons.notifications_none,
                  color: Colors.black,
                  size: 40,
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.black,
                    child: Text(
                      "1",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        body: Consumer<HomeScreenController>(
          builder: (context, homecontroler, child) => Column(
            children: [
              // #1
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(.2)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Search anything",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 16,
              ),
              SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: List.generate(
                      homecontroler.categoryLst.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {
                            _scrollToSelectedIndex(index);
                          },
                          child: InkWell(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              height: 45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: homecontroler.selectedCategoryIndex==index?Colors.white:Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                homecontroler.categoryLst[index],
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: homecontroler.selectedCategoryIndex==index?Colors.white:Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(
                  child: GridView.builder(
                itemCount: 100,
                padding: EdgeInsets.all(20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  mainAxisExtent: 250,
                ),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(),
                        ));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(.2),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://images.pexels.com/photos/28518049/pexels-photo-28518049/free-photo-of-winter-wonderland-by-a-frozen-river.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"))),
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.7),
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.favorite_outline,
                            size: 30,
                          ),
                        ),
                      ),
                      Text(
                        maxLines: 1,
                        "title",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text("price".toString()),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ));
  }
}