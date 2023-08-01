import 'package:business_card_admin/src/models/customer.dart';
import 'package:business_card_admin/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                  columns: const [
                    DataColumn(label: Text("No")),
                    DataColumn(label: Text("Name")),
                    DataColumn(label: Text("Email")),
                    DataColumn(label: Text("Status")),
                    DataColumn(label: Text("Action")),
                  ],
                  rows: _customerList
                      .map<DataRow>(
                        (e) => _getRow(
                          index++,
                          e.id ?? "",
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

  DataRow _getRow(
      int index, String cid, String name, bool status, String email) {
    return DataRow(
      cells: [
        DataCell(Text(index.toString())),
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
          FilledButton(
            onPressed: () => context.go("/customer/$cid"),
            child: const Text("Update"),
          ),
        ),
      ],
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
