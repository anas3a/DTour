import 'package:flutter/material.dart';
import '../../destination_data.dart';

class DestinationCard extends StatelessWidget {
  final int destinationIndex;
  final String userEmail;

  const DestinationCard({
    Key? key,
    required this.destinationIndex,
    required this.userEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic destinationdata = destinationData[destinationIndex];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/spot_details_page', arguments: {
              'userEmail': userEmail,
              'destinationIndex': destinationIndex
            });
          },
          child: Ink(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          destinationdata["image"],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      destinationdata["name"],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
