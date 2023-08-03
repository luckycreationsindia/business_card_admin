import 'package:business_card_admin/consts.dart';
import 'package:business_card_admin/src/models/customer.dart';
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

  @override
  void initState() {
    index = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DataColumn> listOfColumns = const [
      DataColumn(label: Text("No")),
      DataColumn(label: Text("Image")),
      DataColumn(label: Text("Name")),
      DataColumn(label: Text("Email")),
      DataColumn(label: Text("Status")),
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
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
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
      String email) {
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
    ];
    if (kIsWeb) {
      listOfCells.add(DataCell(
        Row(
          children: [
            FilledButton(
              onPressed: () => context.go("/customer/$cid"),
              child: const Icon(Icons.update),
            ),
            FilledButton(
              onPressed: () {
                String url = "${Consts.env["WEB_ROOT"] ?? "http://localhost/"}?id=$cid";
                final Uri urlParsed = Uri.parse(url);
                Fluttertoast.showToast(
                    msg: "Launching Link",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    fontSize: 16.0
                );
                launchUrl(urlParsed, mode: LaunchMode.externalApplication);
              },
              child: const Icon(Icons.link),
            ),
          ],
        ),
      ));
    } else {
      listOfCells.add(DataCell(
        Row(
          children: [
            FilledButton(
              onPressed: () => context.go("/customer/$cid"),
              child: const Icon(Icons.update),
            ),
            const SizedBox(width: 10),
            FilledButton(
              onPressed: () {
                String url = "${Consts.env["WEB_ROOT"] ?? "http://localhost/"}?id=$cid";
                final Uri urlParsed = Uri.parse(url);
                Fluttertoast.showToast(
                    msg: "Launching Link",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    fontSize: 16.0
                );
                launchUrl(urlParsed, mode: LaunchMode.externalApplication);
              },
              child: const Icon(Icons.link),
            ),
            const SizedBox(width: 10),
            FilledButton(
              onPressed: () async {
                Fluttertoast.showToast(
                    msg: "Tap NFC Card",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    fontSize: 16.0
                );
                bool result = await Utils().writeToNFCTag(cid);
                if(result) {
                  Fluttertoast.showToast(
                      msg: "Written to NFC Tag",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      fontSize: 16.0
                  );
                } else {
                  Fluttertoast.showToast(
                      msg: "Failed to write to NFC Tag",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
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
}
