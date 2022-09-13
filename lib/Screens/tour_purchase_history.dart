import 'package:flutter/material.dart';
import '../Widgets/history_card.dart';

class TourPurchaseHistory extends StatefulWidget {
  const TourPurchaseHistory({Key? key}) : super(key: key);

  @override
  State<TourPurchaseHistory> createState() => _TourPurchaseHistoryState();
}

class _TourPurchaseHistoryState extends State<TourPurchaseHistory> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.travel_explore), onPressed: () {}),
        title: const Text('History'),
      ),
      body: HistoryCard(userEmail: arguments['userEmail']),
    );
  }
}
