import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




 Future<Timestamp> getTimestamp() async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('chats')
      .limit(1) // Limit the query to one document
      .get();

  if (snapshot.docs.isNotEmpty) {
    // Assuming 'timestamp_field' is the field where your timestamp is stored
    return snapshot.docs.first.get('Timestap') as Timestamp;
  } else {
    // Handle case when there are no documents in the collection
    throw Exception('No documents found in the collection');
  }
}
class TimestampWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getTimestamp(), // Call the function to get timestamp
      builder: (BuildContext context, AsyncSnapshot<Timestamp> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show loader while fetching data
        } else {
          // Format the timestamp using intl package
          String formattedTimestamp = DateFormat('yyyy-MM-dd HH:mm:ss')
              .format(snapshot.data.toDate()); // Assuming timestamp is in milliseconds

          return Text(timestamp:formattedTimestamp); // Display the formatted timestamp
        }
      },
    );
  }
}
