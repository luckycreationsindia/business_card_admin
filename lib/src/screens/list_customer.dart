import 'package:business_card_admin/consts.dart';
import 'package:business_card_admin/src/models/customer.dart';
import 'package:business_card_admin/src/screens/preview.dart';
import 'package:business_card_admin/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  int index = 1;
  late List<Customer> _customerList;
  ValueNotifier<dynamic> nfcResultHandler = ValueNotifier(null);

  @override
  void initState() {
    index = 1;
    nfcResultHandler.addListener(() {
      if (kDebugMode) {
        print(nfcResultHandler.value);
      }
      Fluttertoast.showToast(
        msg: nfcResultHandler.value ?? 'NFC Message',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool showDrawer = MediaQuery.of(context).size.width < 1000;
    double? moduleWidth = MediaQuery.of(context).size.width > 850
        ? 850
        : MediaQuery.of(context).size.width;
    if (showDrawer) {
      moduleWidth = double.maxFinite;
    }

    List<DataColumn> listOfColumns = const [
      DataColumn(label: Text("No")),
      DataColumn(label: Text("Image")),
      DataColumn(label: Text("Name")),
      DataColumn(label: Text("Email")),
      DataColumn(label: Text("Status")),
      DataColumn(label: Text("Privacy")),
      DataColumn(label: Text("Action")),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("Customers", style: TextStyle(fontSize: 30)),
        const SizedBox(height: 20),
        FutureBuilder<List<Customer>>(
          future: _loadCustomers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              );
            }
            index = 1;
            _customerList = snapshot.data != null ? snapshot.data! : [];
            return Expanded(
              child: InteractiveViewer(
                constrained: false,
                child: DataTable(
                  dataRowColor:
                      MaterialStateProperty.resolveWith(_getDataRowColor),
                  dividerThickness: 1,
                  showCheckboxColumn: false,
                  showBottomBorder: true,
                  columns: listOfColumns,
                  rows: _customerList
                      .map<DataRow>(
                        (e) => _getRow(
                          index++,
                          e.id ?? "",
                          e.profile ?? "",
                          e.displayName,
                          e.status,
                          e.email != null ? e.email! : "",
                          e,
                          moduleWidth,
                        ),
                      )
                      .toList(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  DataRow _getRow(int index, String cid, String image, String name, bool status,
      String email, Customer customer, double? moduleWidth) {
    List<DataCell> listOfCells = [
      DataCell(Text(index.toString())),
      DataCell(Image.network(image, height: 30, width: 30)),
      DataCell(Text(name)),
      DataCell(Text(email)),
      DataCell(
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: status
                  ? Colors.green.withOpacity(0.5)
                  : Colors.red.withOpacity(0.5),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Text(
              status ? 'Active' : 'Inactive',
              style: TextStyle(
                color: status ? Colors.green : Colors.red,
              ),
            ),
          ),
        ),
      ),
      DataCell(
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: customer.private
                  ? Colors.red.withOpacity(0.5)
                  : Colors.green.withOpacity(0.5),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Text(
              customer.private ? 'Private' : 'Public',
              style: TextStyle(
                color: customer.private ? Colors.red : Colors.green,
              ),
            ),
          ),
        ),
      ),
    ];
    if (kIsWeb) {
      listOfCells.add(DataCell(
        Row(
          children: [
            FilledButton(
              onPressed: () => context.push("/customer/$cid"),
              child: const Icon(Icons.update),
            ),
            const SizedBox(width: 10),
            FilledButton(
              onPressed: () {
                String url =
                    "${Consts.env["WEB_ROOT"] ?? "http://localhost/"}?id=$cid";
                final Uri urlParsed = Uri.parse(url);
                Fluttertoast.showToast(
                    msg: "Launching Link",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    fontSize: 16.0);
                launchUrl(urlParsed, mode: LaunchMode.platformDefault);
              },
              child: const Icon(Icons.link),
            ),
            const SizedBox(width: 10),
            FilledButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      content: SizedBox(
                        width: moduleWidth,
                        child: PreviewPage(
                          title: "Preview",
                          customer: customer,
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Icon(Icons.remove_red_eye),
            ),
          ],
        ),
      ));
    } else {
      listOfCells.add(DataCell(
        Row(
          children: [
            FilledButton(
              onPressed: () => context.push("/customer/$cid").then((value) {
                if (value != null && value is String) {
                  _showDialog(title: "Success", message: value.toString());
                }
              }),
              child: const Icon(Icons.update),
            ),
            const SizedBox(width: 10),
            FilledButton(
              onPressed: () {
                String url =
                    "${Consts.env["WEB_ROOT"] ?? "http://localhost/"}?id=$cid";
                final Uri urlParsed = Uri.parse(url);
                Fluttertoast.showToast(
                    msg: "Launching Link",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    fontSize: 16.0);
                launchUrl(urlParsed, mode: LaunchMode.externalApplication);
              },
              child: const Icon(Icons.link),
            ),
            const SizedBox(width: 10),
            FilledButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      content: SizedBox(
                        width: double.maxFinite,
                        child: PreviewPage(
                          title: "Preview",
                          customer: customer,
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Icon(Icons.remove_red_eye),
            ),
            const SizedBox(width: 10),
            FilledButton(
              onPressed: () async {
                Fluttertoast.showToast(
                  msg: "Tap NFC Card",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  fontSize: 16.0,
                );
                try {
                  String url = "${Consts.env["WEB_ROOT"] ?? "http://localhost/"}?id=$cid";
                  if(customer.shortPath != null && customer.shortPath!.isNotEmpty) {
                    url = "${Consts.env["LINK_ROOT"] ?? "http://localhost/"}${customer.shortPath}";
                  }
                  await Utils().writeToNFCTag(url, nfcResultHandler);
                } catch (err) {
                  Fluttertoast.showToast(
                    msg: err.toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              },
              child: const Icon(Icons.nfc),
            ),
          ],
        ),
      ));
    }
    return DataRow(
      cells: listOfCells,
      onSelectChanged: (isSelected) => {},
    );
  }

  Color? _getDataRowColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };

    if (states.any(interactiveStates.contains)) {
      return const Color(0xFF171B2D);
    }

    return null;
  }

  Future<List<Customer>> _loadCustomers() {
    return CustomerRestClient(Consts.dio).loadAllCustomers();
  }

  Future<void> _showDialog(
      {required String title, required String message}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
