// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors, use_build_context_synchronously, sized_box_for_whitespace, prefer_const_constructors_in_immutables

import 'package:FarmIOT/backend/db.dart';
import 'package:FarmIOT/components/snackbar.dart';
import 'package:FarmIOT/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:FarmIOT/components/dialog_box.dart';
import 'package:FarmIOT/constants.dart';
import 'package:FarmIOT/screens/generally_used/my_crops/add_crops.dart';
import 'package:provider/provider.dart';

class MyCrops extends StatefulWidget {
  MyCrops({Key? key}) : super(key: key);

  static const String id = 'my_crops';

  static MyCrops myCrops = MyCrops();

  @override
  State<MyCrops> createState() => _MyCropsState();
}

class _MyCropsState extends State<MyCrops> {
  @override
  Widget build(BuildContext context) {
    // initialize the providder because it is where crop data will be gotten
    final cropData = Provider.of<UserData?>(context);

    // access list of crops from user data
    List userCrops = cropData?.crops ?? [];

    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding.copyWith(top: 30.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // TOP BAR
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'My Crops Dashboard',
                        style: kOtherTextStyle,
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: IconButton(
                        onPressed: () {
                          // Show Dialog Box
                          showDialogBox(
                            dialogText:
                                'This is a list of crops you are currently planting.\n\nYou will receive crucial information as to whether the soil conditions are favourable for your crop and you will be advised on the appropriate action to take.',
                            context: context,
                          );
                        },
                        icon: Icon(FontAwesomeIcons.circleInfo),
                        color: kInfoColor,
                        iconSize: kIconSizeSmall,
                      ),
                    ),
                  ],
                ),
                userCrops.isEmpty
                    ? SizedBox(height: 180.0)
                    : SizedBox(height: 30.0),

                // Body
                // display crops on the screen
                userCrops.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            Container(
                              width: 130.0,
                              height: 130.0,
                              child: Image(
                                image: AssetImage('assets/images/plant.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'You have no crops on your dashboard.',
                              style: kNormalTextStyle,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 180.0),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          // Text that states how may crops a user has added on their dashboard
                          Text(
                            userCrops.length == 1
                                ? 'You have ${userCrops.length} crop on your dashboard'
                                : 'You have ${userCrops.length} crops on your dashboard',
                            style: kNormalTextStyle.copyWith(
                                color: kInfoColor.withOpacity(0.9)),
                          ),

                          SizedBox(height: 20.0),

                          Column(
                            // loop through the list and display on the screen
                            children: userCrops.map((crop) {
                              // function to redirect to appropriate page
                              return GestureDetector(
                                onTap: () {
                                  /* I used the name of the crop from the crop
                                  list in firestore as the name of the route.
                                  That is why I just used 'crop' as the
                                  routeName here. */
                                  Navigator.pushNamed(context, crop);
                                },
                                child: Crops(
                                  cropName: crop,
                                  image: 'assets/images/$crop.jpg',

                                  // function to delete crop from dashboard
                                  delete: () async {
                                    // get current user
                                    FirebaseAuth auth = FirebaseAuth.instance;
                                    String userId = auth.currentUser!.uid;

                                    dynamic result = await Database(uid: userId)
                                        .deleteCrop(crop);

                                    displaySnackBar(context, result);
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),

                // Add Crop Button
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 2,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 0,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AddCrops.id);
                        },
                        color: kBrownButton,
                        minWidth: MediaQuery.of(context).size.width * 0.01,
                        height: 50.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              FontAwesomeIcons.plus,
                              color: kTextColor,
                            ),
                            SizedBox(width: 5.0),
                            Text('Add Crop', style: kButtonTextStyle),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Crop container widget
class Crops extends StatelessWidget {
  String cropName;
  String image;
  Function() delete;

  Crops({
    required this.cropName,
    required this.image,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 70.0,
          decoration: BoxDecoration(
            color: kBottomSheetBackgroundColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: kAppPadding,
            child: Row(
              children: [
                Expanded(
                  flex: 0,
                  child: CircleAvatar(
                    backgroundColor: kTextFieldContainerBorderColor,
                    backgroundImage: AssetImage(image),
                    radius: 25.0,
                  ),
                ),
                SizedBox(width: 25.0),
                Expanded(
                  flex: 2,
                  child: Text(
                    cropName,
                    style: kNormalTextStyle,
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: IconButton(
                    onPressed: delete,
                    icon: Icon(Icons.delete),
                    color: kInfoColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.0)
      ],
    );
  }
}
