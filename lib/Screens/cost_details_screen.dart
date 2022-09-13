import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../Models/purchase_history.dart';
import '../destination_data.dart';
import '../Models/data_provider.dart';

class CostDetailsPage extends StatelessWidget {
  const CostDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    final PurchaseHistory purchaseHistory = arguments["purchaseHistory"];
    final dynamic destinationdata =
        destinationData[purchaseHistory.destinationID!];
    int personCost = destinationdata["transportMode"]
            [purchaseHistory.transportationMode] +
        (purchaseHistory.duration! *
            destinationdata["hotelCost"][purchaseHistory.hotelType]!);
    int totalCost = personCost * purchaseHistory.totalPerson!;
    purchaseHistory.totalCost = totalCost;
    DataProvider dataProvider = DataProvider();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.travel_explore), onPressed: () {}),
        title: const Text('Cost Breakdown'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Divider(),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Tour Details',
                      style: TextStyle(color: Colors.purple)),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Text(
                      'Destination:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      purchaseHistory.destination!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    const Text(
                      'No. of Persons:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      purchaseHistory.totalPerson!.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    const Text(
                      'Check-in Date:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      purchaseHistory.startDate!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    const Text(
                      'Check-out Date:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      purchaseHistory.endDate!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    const Text(
                      'Total Duration:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${purchaseHistory.duration} Day(s)',
                      style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    const Text(
                      'Hotel Type:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      purchaseHistory
                          .getHotelTypeByID(purchaseHistory.hotelType!),
                      style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    const Text(
                      'Transportation Mode:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      purchaseHistory.getTransportModeByID(
                          purchaseHistory.transportationMode!),
                      style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Cost Details',
                      style: TextStyle(color: Colors.purple)),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Text(
                      'Per Person Cost:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '$personCost Taka',
                      style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    const Text(
                      'Total Cost:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '$totalCost Taka',
                      style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 80,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      var snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Thank You!',
                          message:
                              'Your payment is successful, have a safe journey!',
                          contentType: ContentType.success,
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      dataProvider.addPurchaseHistory(purchaseHistory);
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    child: const Text('Pay Now'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
