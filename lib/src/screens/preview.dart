import 'package:business_card_admin/src/models/customer.dart';
import 'package:business_card_admin/src/widgets/BottomNavButton.dart';
import 'package:business_card_admin/src/widgets/ContactData.dart';
import 'package:business_card_admin/src/widgets/ModuleCard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PreviewPage extends StatefulWidget {
  final Customer customer;

  const PreviewPage({Key? key, required this.title, required this.customer})
      : super(key: key);
  final String title;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final addressKey = GlobalKey();
  final gstKey = GlobalKey();
  final galleryKey = GlobalKey();
  final productKey = GlobalKey();
  final serviceKey = GlobalKey();
  final contactKey = GlobalKey();
  final paymentKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    bool showDrawer = MediaQuery.of(context).size.width < 1000;
    double moduleWidth = MediaQuery.of(context).size.width > 750
        ? 750
        : MediaQuery.of(context).size.width;
    if(showDrawer) {
      moduleWidth = MediaQuery.of(context).size.width > 450
          ? 450
          : MediaQuery.of(context).size.width;
      if(kIsWeb) {
        if(moduleWidth < 500) moduleWidth = 500;
      }
    }
    Customer customer = widget.customer;
    Color mainColor = colorFromHex(customer.mainColor)!;
    final fullWidth = MediaQuery.of(context).size.width;
    double margins = (fullWidth - moduleWidth) / 2;
    if(margins < 0) margins = 0;

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        decoration: BoxDecoration(
          color: mainColor,
        ),
        padding: EdgeInsets.symmetric(horizontal: margins),
        child: Scaffold(
          backgroundColor: const Color(0xFFE2E3E4),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Card(
                  key: homeKey,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: SizedBox(
                    width: moduleWidth,
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundImage: customer.profile != null &&
                                    customer.profile!.isNotEmpty
                                ? NetworkImage(customer.profile!)
                                : Image.asset('assets/images/img_avatar.png')
                                    .image,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          customer.displayName,
                          textAlign: TextAlign.center,
                        ),
                        customer.jobTitle != null &&
                                customer.jobTitle!.isNotEmpty
                            ? Text(
                                customer.jobTitle!,
                                textAlign: TextAlign.center,
                              )
                            : Container(),
                        customer.company != null && customer.company!.isNotEmpty
                            ? Text(
                                customer.company!,
                                textAlign: TextAlign.center,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ModuleCard(
                  pageKey: contactKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: getContactData(customer, mainColor),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Save Contact",
                          style: TextStyle(
                            color: mainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                customer.about != null && customer.about!.isNotEmpty
                    ? ModuleCard(
                        pageKey: aboutKey,
                        child: Column(
                          children: [
                            const Text(
                              "About",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SelectableText(
                              customer.about!,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : Container(),
                const SizedBox(height: 10),
                customer.address != null && customer.address!.isNotEmpty
                    ? ModuleCard(
                        pageKey: addressKey,
                        child: Column(
                          children: [
                            const Text(
                              "Address",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SelectableText(
                              customer.address!,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : Container(),
                const SizedBox(height: 10),
                customer.gst != null && customer.gst!.isNotEmpty
                    ? ModuleCard(
                        pageKey: gstKey,
                        child: Column(
                          children: [
                            const Text(
                              "GST No.",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SelectableText(
                              customer.gst!,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : Container(),
                const SizedBox(height: 10),
                (customer.bankDetails != null &&
                            customer.bankDetails!.isNotEmpty) ||
                        (customer.upi != null && customer.upi!.isNotEmpty)
                    ? ModuleCard(
                        pageKey: paymentKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                "Payment Details",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 10),
                            customer.bankDetails != null &&
                                    customer.bankDetails!.isNotEmpty
                                ? Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Text(
                                        "Bank Details:\n${customer.bankDetails!}"),
                                  )
                                : Container(),
                            customer.upi != null && customer.upi!.isNotEmpty
                                ? Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: SizedBox(
                                                height: 15,
                                                child: Image.asset(
                                                  "assets/images/upi_payment.png",
                                                ),
                                              ),
                                            ),
                                            TextSpan(
                                              text: "  ${customer.upi!}",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BottomNavButton(
                    pageKey: homeKey,
                    icon: Icons.home_outlined,
                    title: "Home",
                    mainColor: mainColor,
                  ),
                  BottomNavButton(
                    pageKey: contactKey,
                    icon: Icons.contact_mail_outlined,
                    title: "Contact",
                    mainColor: mainColor,
                  ),
                  BottomNavButton(
                    pageKey: aboutKey,
                    icon: Icons.info_outline_rounded,
                    title: "About",
                    mainColor: mainColor,
                  ),
                  BottomNavButton(
                    pageKey: paymentKey,
                    icon: Icons.payment_outlined,
                    title: "Payment",
                    mainColor: mainColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getContactData(Customer customer, Color mainColor) {
    List<Widget> result = [];
    if (customer.contacts != null && customer.contacts!.isNotEmpty) {
      result.add(
        ContactData(
          title: "Call",
          icon: Icons.call_outlined,
          mainColor: mainColor,
          onClick: () {},
        ),
      );
    }
    if (customer.whatsapp != null && customer.whatsapp!.isNotEmpty) {
      result.add(
        ContactData(
          title: "WhatsApp",
          icon: FontAwesomeIcons.whatsapp,
          mainColor: mainColor,
          onClick: () {},
        ),
      );
    }
    if (customer.email != null && customer.email!.isNotEmpty) {
      result.add(
        ContactData(
          title: "Mail",
          icon: Icons.mail_outline,
          mainColor: mainColor,
          onClick: () {},
        ),
      );
    }
    if (customer.website != null && customer.website!.isNotEmpty) {
      result.add(
        ContactData(
          title: "Website",
          icon: Icons.language_outlined,
          mainColor: mainColor,
          onClick: () {},
        ),
      );
    }
    if (customer.address != null && customer.address!.isNotEmpty) {
      result.add(
        ContactData(
          title: "Location",
          icon: Icons.location_on_outlined,
          mainColor: mainColor,
          onClick: () {},
        ),
      );
    }
    return result;
  }
}
