import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:intl/intl.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../destination_data.dart';
import '../Models/purchase_history.dart';

class TourInputPage extends StatefulWidget {
  const TourInputPage({Key? key}) : super(key: key);

  @override
  State<TourInputPage> createState() => _TourInputPageState();
}

class _TourInputPageState extends State<TourInputPage> {
  int hotelTag = 0;
  List<String> hotelOptions = ['Budget Friendly', 'Moderate', 'Luxury'];

  int transportTag = 1;
  List<String> transportOptions = ['By Air', 'By Car', 'By Bus'];

  DateTime startDate = DateTime.now().add(const Duration(days: 1));
  DateTime endDate = DateTime.now().add(const Duration(days: 3));
  TextEditingController dateRangeInput = TextEditingController();
  late PurchaseHistory purchaseHistory;

  void _selectDate() async {
    final DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: startDate,
        end: endDate,
      ),
      firstDate: DateTime.now(),
      lastDate: DateTime(3022),
      helpText: 'Select a date range',
    );
    if (newDateRange != null) {
      setState(() {
        startDate = newDateRange.start;
        endDate = newDateRange.end;
        purchaseHistory.startDate =
            DateFormat('dd MMM yyyy').format(startDate).toString();
        purchaseHistory.endDate =
            DateFormat('dd MMM yyyy').format(endDate).toString();
        purchaseHistory.duration =
            (endDate.difference(startDate).inHours / 24).round() + 1;
        dateRangeInput.text =
            "${purchaseHistory.startDate!}  -  ${purchaseHistory.endDate!}";
      });
    }
  }

  @override
  void initState() {
    purchaseHistory = PurchaseHistory();
    purchaseHistory.totalPerson = 0;
    purchaseHistory.hotelType = hotelTag;
    purchaseHistory.transportationMode = transportTag;
    purchaseHistory.startDate =
        DateFormat('dd MMM yyyy').format(startDate).toString();
    purchaseHistory.endDate =
        DateFormat('dd MMM yyyy').format(endDate).toString();
    purchaseHistory.duration =
        (endDate.difference(startDate).inHours / 24).round() + 1;
    dateRangeInput.text =
        "${purchaseHistory.startDate!}  -  ${purchaseHistory.endDate!}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final dynamic destinationdata =
        destinationData[arguments["destinationIndex"]];

    purchaseHistory.userEmail = arguments["userEmail"];
    purchaseHistory.destinationID = arguments["destinationIndex"];
    purchaseHistory.destination = destinationdata["name"];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.travel_explore), onPressed: () {}),
        title: const Text('Add Tour Info'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Number of Persons',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.confirmation_number_sharp,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    purchaseHistory.totalPerson = int.parse(value);
                  });
                },
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: dateRangeInput,
                onTap: () async {
                  _selectDate();
                },
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Departure and Arrival date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.date_range),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                indent: 16,
                endIndent: 16,
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Hotel Type",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ChipsChoice<int>.single(
                value: hotelTag,
                onChanged: (val) => setState(() {
                  hotelTag = val;
                  purchaseHistory.hotelType = val;
                }),
                choiceItems: C2Choice.listFrom<int, String>(
                  source: hotelOptions,
                  value: (i, v) => i,
                  label: (i, v) => v,
                ),
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                choiceActiveStyle: const C2ChoiceStyle(
                  color: Colors.purple,
                ),
                choiceStyle: const C2ChoiceStyle(
                  showCheckmark: true,
                  color: Colors.black,
                  backgroundColor: Colors.white,
                  borderColor: Color.fromARGB(255, 36, 25, 187),
                ),
                wrapped: false,
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                indent: 16,
                endIndent: 16,
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Transportation Mode",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ChipsChoice<int>.single(
                value: transportTag,
                onChanged: (val) => setState(() {
                  transportTag = val;
                  purchaseHistory.transportationMode = val;
                }),
                choiceItems: C2Choice.listFrom<int, String>(
                  source: transportOptions,
                  value: (i, v) => i,
                  label: (i, v) => v,
                ),
                choiceActiveStyle: const C2ChoiceStyle(
                  color: Colors.purple,
                ),
                choiceStyle: const C2ChoiceStyle(
                  showCheckmark: true,
                  color: Colors.black,
                  backgroundColor: Colors.white,
                  borderColor: Color.fromARGB(255, 36, 25, 187),
                ),
                wrapped: false,
              ),
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    if (purchaseHistory.totalPerson == 0) {
                      var snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Wrong Information!',
                          message: 'Number of Person can\'t be empty',
                          contentType: ContentType.failure,
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      Navigator.pushNamed(
                        context,
                        '/cost_details_page',
                        arguments: {
                          'userEmail': arguments['userEmail'],
                          'purchaseHistory': purchaseHistory
                        },
                      );
                    }
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  child: const Text('Confrim'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
