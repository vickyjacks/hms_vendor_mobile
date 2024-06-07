import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_vender_app/utils/helpers/helper.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
    String dropdownValue = 'Select';
  var items = [
    'HTL55FDS',
    'HTL56QFJ',
    'HTL13GDF',
    'HTL13DFS',
    'HT5WRATH',
  ];
  @override
  Widget build(BuildContext context) {
    final dark = myHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 2.4,
        scrolledUnderElevation: 2,
        leading: Builder(
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 5),
              child: GestureDetector(
                child: Icon(
                  Icons.widgets_outlined,
                  color: dark ? Colors.white : Colors.black,
                ),
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            );
          },
        ),
        title: Row(
          children: [
            Icon(
              Icons.diversity_1_outlined,
              color: dark ? Colors.white : Colors.black,
              size: 40,
            )
          ],
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () async {
                //  materialPageRoute(context, const DemoPage());
                //  CommonDialog().addHotelStaffDialog(context);
              },
              child: const Icon(Iconsax.notification_bing),
            ),
          ),
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return items.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
            onSelected: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            icon: const Icon(Icons.more_vert),
          ),

        ],
      ),
      body: Column(
        children: [
              Padding(
            padding:   EdgeInsets.only(left: 15.0,right: 15.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: dark ? Colors.white:Colors.black)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network("https://images.oyoroomscdn.com/uploads/hotel_image/200979/large/amfawnshtfjv.jpg",height: 80,width: 80,fit: BoxFit.fill,),
                        )
                      ],
                    ),
                     const SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Mannat Hotels",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 3,),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(28),
                                border: Border.all(color: dark ? Colors.white:Colors.black)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0,top: 2,bottom: 2,right: 8),
                              child: Text(
                                "Pending",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          SizedBox(height:3,),
                          const Text(
                            maxLines: 2,
                            " Add - 37 Lowther road, near adarsha hospital Bharat petrol pump George Town Prayagraj",
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
// DropdownButton(
// underline: const SizedBox(),
// value: dropdownvalue,
// icon: const Icon(Icons.keyboard_arrow_down),
// items: items.map((String items) {
// return DropdownMenuItem(
// value: items,
// child: Text(items),
// );
// }).toList(),
// onChanged: (String? newValue) {
// setState(() {
// dropdownvalue = newValue!;
// });
// },
// );
