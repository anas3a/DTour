import 'package:flutter/material.dart';
import '../Models/purchase_history.dart';
import '../Models/data_provider.dart';

class HistoryCard extends StatelessWidget {
  final String userEmail;
  const HistoryCard({
    Key? key,
    required this.userEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = DataProvider();
    Future<List<PurchaseHistory>> currentFuture;
    PurchaseHistory purchaseHistory = PurchaseHistory();

    currentFuture = dataProvider.getPurchaseHistory(userEmail);

    return FutureBuilder(
        future: currentFuture,
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          var list = snapshot.data;
          var length = list!.length;
          if (length == 0) {
            return const Center(
              child: Text(
                'No Tour Package purchased yet.',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 12),
              child: ListView.builder(
                itemCount: length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 10, top: 10),
                        child: Column(
                          children: [
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
                                  list[index].destination,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Date:',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  list[index].startDate +
                                      "  -  " +
                                      list[index].endDate,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Total Persons:',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  list[index].totalPerson.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Hotel Type:',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  purchaseHistory
                                      .getHotelTypeByID(list[index].hotelType),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Tranportation Mode:',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  purchaseHistory.getTransportModeByID(
                                      list[index].transportationMode),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Total Cost:',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  list[index].totalCost.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        });
  }
}
