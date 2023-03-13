// ignore_for_file: avoid_print

import 'package:FarmIOT/models/sensors.dart';
import 'package:FarmIOT/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Database {
  /* 
  Create and initialize a variable that servses as reference to id of the 
  current user gotten through authentication and can be used in any other 
  functionality
  */

  final String? uid;
  Database({this.uid});

  // initialize firestore and create a collection
  FirebaseFirestore db = FirebaseFirestore.instance;

  // USERS COLLECTION

  // adding user data to firestore collection functionality
  Future addUserData(String email, String firstName, String lastName) async {
    try {
      // User collection reference
      CollectionReference userCollection = db.collection('users');

      // User document rrfefernce
      DocumentReference userDoc = userCollection.doc(uid);

      /* add data to user collection by creating a document to store the data
    uid is a reference to the uid created above */
      await userDoc.set({
        // data that will be provided by the user upon signing up (compulsory data)

        'firstName': firstName,
        'lastName': lastName,
        'email': email,

        // set default data that should show upon signing up (optional data)

        'profilePic':
            'https://as2.ftcdn.net/v2/jpg/02/17/34/67/1000_F_217346782_7XpCTt8bLNJqvVAaDZJwvZjm0epQmj6j.jpg',
        'crops': [],
        'connected': false,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  /* Fuctionality to update user data

  Here i used .update() instead of .set() on the document so it doesn't
  overwrite what is already in the database 
  */

  Future updateUserData(
      {String? email, String? firstName, String? lastName}) async {
    try {
      // initialize firebase authentication
      FirebaseAuth auth = FirebaseAuth.instance;

      // reference user collection so you can add data to it
      CollectionReference userCollection = db.collection('users');

      // get current user and updaate their email
      await auth.currentUser!.updateEmail(email!);

      return await userCollection.doc(uid).update({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  /* Functionality to update profile picture url in firestore. Here you have to 
  set option merge as true to avoid overwriting the data in firestore */

  Future addProfilePicture(String profilePicUrl) async {
    try {
      // reference user collection
      CollectionReference userCollection = db.collection('users');

      return await userCollection.doc(uid).update({
        'profilePic': profilePicUrl,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // function to toggle connection to sensors

  Future toggleConnection({bool connected = false}) async {
    try {
      // collection reference
      CollectionReference userCollection = db.collection('users');
      // document reference
      DocumentReference userDoc = userCollection.doc(uid);

      return await userDoc.update({
        'connected': connected ? false : true,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // update crop data
  Future addCrops(String crop) async {
    try {
      // reference user collection
      CollectionReference userCollection = db.collection('users');

      /* 
    
      Run a query to check if an item exists in the array
      for a specific user already

      If you don't add a where clause for the user id, any change a user makes
      to the data specified will affect all other users

      NOTE: As long as it involves adding stuff or retrieving stuff from a
      database that is specific to a user or a user's choice, ensure you
      refeernce the user's id in the where clause

      Basically this query says SELECT * FROM userCollection WHERE uid = current
      user uid AND crops = crop field 
      
      */

      final QuerySnapshot userCropsQuery = await userCollection
          .where('uid', isEqualTo: uid)
          .where('crops', arrayContains: crop)
          .get(); // .get() basically runs the query

      /* 
    
      Check if the 'document' result gotten back from the query above is empty
      or not

      NOTE: The result of a query from a QuerySnapshot is in documents just
      like in normal sql where the result gotten from a query is in records/rows.

      In normal sql it will be like the records gotten after a query is run but
      in this case it is documents since collectiosn are like tables and documents
      are like records /rows in normal sql 
      
      */

      if (userCropsQuery.docs.isEmpty) {
        // get the specific document and update it
        await userCollection.doc(uid).update({
          'crops': FieldValue.arrayUnion([crop])
        });

        return '$crop added to dashboard';
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // remove particular crop from user dashboard and database
  Future deleteCrop(String crop) async {
    try {
      CollectionReference userCollection = db.collection('users');

      await userCollection.doc(uid).update({
        'crops': FieldValue.arrayRemove([crop])
      });

      return '$crop removed from dashboard';
    } catch (e) {
      print(e.toString());
    }
  }

  // create custom user data from UserData model from document snaoshot

  UserData _userDataFromDocumentSnapshot(DocumentSnapshot? snapshot) {
    // check if snapshot exists
    if (snapshot == null || !snapshot.exists) {
      return UserData(
        uid: '',
        firstName: '',
        lastName: '',
        email: '',
        profilePic: '',
        crops: [],
        connected: false,
      );
    }

    /* 
    VERY IMPORTNAT TO NOTE!!!

    Any time you want to make your stream  nullable by using the ? in a context 
    like this Stream<UserData?>, ensure that the place you are getting your data
    from eg this function, has ?? '' (null aware operator) so as to avoid 
    issue of null safety when running your code. 

    VERY IMPORTANT!!!
    */

    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return UserData(
      uid: uid ?? '',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      email: data['email'] ?? '',
      profilePic: data['profilePic'] ?? '',
      crops: data['crops'] ?? [],
      connected: data['connected'] ?? false,
    );
  }

  // stream for specific user document to get the user data

  Stream<UserData?> get userData {
    // collection reference
    CollectionReference userCollection = db.collection('users');
    return userCollection
        .doc(uid)
        .snapshots()
        .map(_userDataFromDocumentSnapshot);
  }

  // REALTIME DATABASE FOR SENSORS

  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  // add sensor data functionality
  Future addSensorData() async {
    try {
      // database reference
      DatabaseReference sensorDatabase = firebaseDatabase.ref();

      return await sensorDatabase.child('User $uid').set({
        'soilMoisture': 0.1,
        'temperature': 0.1,
        'humidity': 0.1,
        'nitrogen': 0.1,
        'phosphorus': 0.1,
        'potassium': 0.1,
        'userId': uid,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // function to update sensor data as user connects to the sensors
  Future updateSensorDataOnConnection() async {
    try {
      DatabaseReference ref = firebaseDatabase.ref().child('User $uid');

      // query to check for current uid
      final snapshotQuery = await ref.orderByChild('User $uid').equalTo(uid).get();

      // return _sensorDataFromDocumentSnapshot(snapshotQuery);

      // if (userSensorQuery.docs.isNotEmpty) {
      //   // store the query result which is a document snapshot in a variable
      //   List<DocumentSnapshot> docs = userSensorQuery.docs;

      //   // loop through the list
      //   for (var doc in docs) {
      //     // convert document data into a map
      //     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      //     // update sensor data
      //     return await sensorCollection.doc('User-$uid').update({
      // 'soilMoisture': data['soilMoisture'],
      // 'temperature': data['temperature'],
      // 'humidity': data['humidity'],
      // 'nitrogen': data['nitrogen'],
      // 'phosphorus': data['phosphorus'],
      // 'potassium': data['potassium'],
      //     });
      //   }
      // } else {
      //   return null;
      // }
    } catch (e) {
      print(e.toString());
    }
  }

  // create custom model to accept sensor data
  SensorData _sensorDataFromDocumentSnapshot(DataSnapshot snapshot) {
    Map<String, dynamic> data = snapshot as Map<String, dynamic>;

    return SensorData(
      soilMoisture: data['soilMoisture'],
      temperature: data['temperature'],
      humidity: data['humidity'],
      nitrogen: data['nitrogen'],
      phosphorus: data['phosphorus'],
      potassium: data['potassium'],
      userId: uid!,
    );
  }

  // create stream for sensor data
  // Stream<SensorData> get sensorData {
  //   // collection reference
  //   DatabaseReference ref = firebaseDatabase.ref()
  //   return ref
  //       .child('User-$uid')
  //       .snapshots()
  //       .map(_sensorDataFromDocumentSnapshot);
  // }
}
