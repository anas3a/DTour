import 'package:flutter/material.dart';
import '../destination_data.dart';
import '../Widgets/destination_card.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.travel_explore), onPressed: () {}),
        title: const Text('Travel Guide'),
        actions: [
          IconButton(
              icon: const Icon(Icons.history),
              tooltip: 'History',
              onPressed: () {
                Navigator.pushNamed(context, '/purchase_history_page',
                    arguments: {'userEmail': arguments['userEmail']});
              }),
          IconButton(
              icon: const Icon(Icons.logout_rounded),
              tooltip: 'Log Out',
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/');
              }),
        ],
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: Column(
          children: [
            Container(
              height: screenSize.height * 0.12,
              width: screenSize.width,
              decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36))),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Country',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Bangladesh',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: ListView.builder(
                    itemCount: destinationData.length,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return DestinationCard(
                        destinationIndex: index,
                        userEmail: arguments["userEmail"],
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
