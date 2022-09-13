import 'package:flutter/material.dart';
import '../destination_data.dart';

class SpotDetailsPage extends StatefulWidget {
  const SpotDetailsPage({Key? key}) : super(key: key);

  @override
  State<SpotDetailsPage> createState() => _SpotDetailsPageState();
}

class _SpotDetailsPageState extends State<SpotDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final dynamic destinationdata =
        destinationData[arguments["destinationIndex"]];
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(destinationdata["image"]),
                        fit: BoxFit.cover)),
              ),
            ),
            Positioned(
              top: 270,
              child: Container(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 30),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destinationdata["name"],
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.deepPurple),
                        Text(
                          destinationdata["location"],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      destinationdata["description"],
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          label: const Text("Book Trip"),
          onPressed: () {
            Navigator.pushNamed(context, '/tour_input_page',
                arguments: arguments);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
