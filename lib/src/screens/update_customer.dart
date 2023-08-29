import 'dart:io';

import 'package:business_card_admin/consts.dart';
import 'package:business_card_admin/src/models/customer.dart';
import 'package:business_card_admin/src/widgets/CheckHandler.dart';
import 'package:business_card_admin/src/widgets/CustomeThemePicker.dart';
import 'package:business_card_admin/src/widgets/SectorTagsHandler.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class UpdateCustomerScreen extends StatefulWidget {
  final String id;

  const UpdateCustomerScreen({super.key, required this.id});

  @override
  State<UpdateCustomerScreen> createState() => _UpdateCustomerScreenState();
}

class _UpdateCustomerScreenState extends State<UpdateCustomerScreen> {
  Color currentColor = colorFromHex(Consts.DEFAULT_COLOR)!;
  bool isLoading = false;
  bool isPrivate = false;
  bool customerStatus = true;
  XFile? selectedImage;
  final formKey = GlobalKey<FormState>();
  Customer? oldData;
  List<Widget> allTextInput = [];
  List<String> sectorList = [];

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _whatsAppController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _linkedInController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _twitterController = TextEditingController();
  final TextEditingController _upiController = TextEditingController();
  final TextEditingController _bankDetailsController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _shortPathController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FocusTraversalGroup(
        policy: OrderedTraversalPolicy(),
        child: FutureBuilder<Customer>(
          future: _loadCustomer(),
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
            if (snapshot.hasData && snapshot.data != null) {
              oldData = snapshot.data!;
              _initOldValues();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("Update Customer", style: TextStyle(fontSize: 30)),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            FilledButton(
                              onPressed: () {
                                _pickImage().then((value) {
                                  setState(() {
                                    selectedImage = value;
                                  });
                                }).catchError((_) {});
                              },
                              child: const Text("Select Image"),
                            ),
                            selectedImage != null
                                ? kIsWeb
                                    ? Image.network(
                                        selectedImage!.path,
                                        height: 100,
                                        width: 100,
                                      )
                                    : Image.file(
                                        File(selectedImage!.path),
                                        height: 100,
                                        width: 100,
                                      )
                                : oldData!.profile != null
                                    ? Image.network(
                                        oldData!.profile!,
                                        height: 100,
                                        width: 100,
                                      )
                                    : const SizedBox(),
                          ],
                        ),
                        ...allTextInput,
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  isLoading
                      ? const CircularProgressIndicator()
                      : FilledButton(
                          onPressed: () {
                            bool formStatus =
                                formKey.currentState?.validate() ?? false;
                            if (!formStatus) {
                              if (kDebugMode) {
                                print("Form Data Missing");
                              }
                              return;
                            }
                            formKey.currentState?.deactivate();
                            setState(() {
                              isLoading = true;
                              _updateCustomer().then((value) {
                                context.pop("Customer Updated Successfully");
                              }).catchError((err) {
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            });
                          },
                          child: const Text('Update Customer'),
                        ),
                ],
              );
            } else {
              return const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Text("Error Loading Customer"),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _initOldValues() {
    currentColor = colorFromHex(oldData!.mainColor)!;
    isPrivate = oldData!.private;
    customerStatus = oldData!.status;
    _firstNameController.text = oldData!.first_name;
    _lastNameController.text = oldData!.last_name ?? '';
    _contactController.text =
        oldData!.contacts != null ? oldData!.contacts!.first : '';
    _whatsAppController.text = oldData!.whatsapp ?? '';
    _emailController.text = oldData!.email ?? '';
    _companyController.text = oldData!.company ?? '';
    _jobTitleController.text = oldData!.jobTitle ?? '';
    _addressController.text = oldData!.address ?? '';
    _gstController.text = oldData!.gst ?? '';
    _cityController.text = oldData!.city ?? '';
    _stateController.text = oldData!.state ?? '';
    _countryController.text = oldData!.country ?? '';
    _pincodeController.text = oldData!.pincode?.toString() ?? '';
    _longitudeController.text = oldData!.longitude?.toString() ?? '';
    _latitudeController.text = oldData!.latitude?.toString() ?? '';
    _websiteController.text = oldData!.website ?? '';
    _facebookController.text = oldData!.facebook ?? '';
    _instagramController.text = oldData!.instagram ?? '';
    _linkedInController.text = oldData!.linkedin ?? '';
    _githubController.text = oldData!.github ?? '';
    _twitterController.text = oldData!.twitter ?? '';
    _upiController.text = oldData!.upi ?? '';
    _bankDetailsController.text = oldData!.bankDetails ?? '';
    _aboutController.text = oldData!.about ?? '';
    _notesController.text = oldData!.notes ?? '';
    _shortPathController.text = oldData!.shortPath ?? '';
    sectorList = oldData!.sectors ?? [];

    allTextInput = [
      const SizedBox(height: 20),
      _getTextField(
        label: "First name",
        controller: _firstNameController,
        keyboardType: TextInputType.name,
        required: true,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "Last name",
        controller: _lastNameController,
        keyboardType: TextInputType.name,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "Contact",
        controller: _contactController,
        keyboardType: TextInputType.phone,
        required: true,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "WhatsApp",
        controller: _whatsAppController,
        keyboardType: TextInputType.phone,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "Email",
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "Password",
        controller: _passwordController,
        obscureText: true,
        lines: 1,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "Company",
        controller: _companyController,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "Job Title",
        controller: _jobTitleController,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "Website",
        controller: _websiteController,
        keyboardType: TextInputType.url,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "Address",
        controller: _addressController,
        keyboardType: TextInputType.multiline,
        lines: 3,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "GST No.",
        controller: _gstController,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "City",
        controller: _cityController,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "State",
        controller: _stateController,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "Country",
        controller: _countryController,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "Pincode",
        controller: _pincodeController,
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "Latitude",
        controller: _latitudeController,
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "Longitude",
        controller: _longitudeController,
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "Facebook",
        controller: _facebookController,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "Instagram",
        controller: _instagramController,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "LinkedIn",
        controller: _linkedInController,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "GitHub",
        controller: _githubController,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "Twitter",
        controller: _twitterController,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "UPI",
        controller: _upiController,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "Bank Details",
        controller: _bankDetailsController,
        keyboardType: TextInputType.multiline,
        lines: 3,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "Notes",
        controller: _notesController,
        keyboardType: TextInputType.multiline,
        lines: 3,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "About",
        controller: _aboutController,
        keyboardType: TextInputType.multiline,
        lines: 3,
      ),
      const SizedBox(height: 20),
      _getTextField(
        label: "Short Path",
        controller: _shortPathController,
      ),
      const SizedBox(height: 20),
      SectorTagsHandler(
        sectorList: sectorList,
        callback: (result) {
          sectorList = result;
        },
      ),
      const SizedBox(height: 20),
      CheckHandler(
        checked: isPrivate,
        title: "Is Private",
        callback: (value) {
          isPrivate = value;
          oldData!.private = value;
        },
      ),
      const SizedBox(height: 20),
      CheckHandler(
        checked: customerStatus,
        title: "Status",
        callback: (value) {
          customerStatus = value;
          oldData!.status = value;
        },
      ),
      const SizedBox(height: 20),
      CustomerThemePicker(
        currentColor: currentColor,
        callback: (color) {
          currentColor = color;
          oldData?.mainColor = colorToHex(color);
        },
      ),
    ];
  }

  Widget _getTextField({
    required String label,
    required TextEditingController controller,
    String? hint,
    int? lines,
    TextInputType keyboardType = TextInputType.text,
    bool required = false,
    bool obscureText = false,
  }) {
    hint ??= label;
    return SizedBox(
      width: 400,
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: const Color(0xFF171B2D),
        ),
        minLines: lines,
        maxLines: lines,
        keyboardType: keyboardType,
        obscureText: obscureText,
        controller: controller,
        validator: (value) {
          if (required && (value == null || value.isEmpty)) {
            String message = "$label is required";
            return message;
          }
          return null;
        },
      ),
    );
  }

  Future<Customer> _updateCustomer() async {
    Customer customer = Customer(
      id: oldData!.id,
      first_name: _firstNameController.text,
      last_name: _lastNameController.text,
      contacts: [],
      whatsapp: _whatsAppController.text,
      email: _emailController.text,
      address: _addressController.text,
      gst: _gstController.text,
      latitude: num.tryParse(_latitudeController.text),
      longitude: num.tryParse(_longitudeController.text),
      company: _companyController.text,
      jobTitle: _jobTitleController.text,
      upi: _upiController.text,
      about: _aboutController.text,
      bankDetails: _bankDetailsController.text,
      facebook: _facebookController.text,
      github: _githubController.text,
      instagram: _instagramController.text,
      linkedin: _linkedInController.text,
      notes: _notesController.text,
      twitter: _twitterController.text,
      website: _websiteController.text,
      city: _cityController.text,
      state: _stateController.text,
      country: _countryController.text,
      profile: oldData!.profile,
      shortPath: _shortPathController.text,
      sectors: sectorList,
      pincode: num.tryParse(_pincodeController.text),
      status: customerStatus,
      private: isPrivate,
      mainColor: "#${colorToHex(currentColor)}",
      password: _passwordController.text,
    );
    if (_contactController.text.isNotEmpty) {
      customer.contacts = [_contactController.text];
    }
    if (selectedImage != null) {
      List<int> fileBytes = (await selectedImage!.readAsBytes()).toList();
      String uploadedPath = await uploadImage(fileBytes, selectedImage!.name);
      customer.profile = uploadedPath;
    }
    Customer result =
        await CustomerRestClient(Consts.dio).update(customer.id!, customer);
    return Future.value(result);
  }

  Future<dynamic> uploadImage(List<int> file, String fileName) async {
    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(file, filename: fileName),
    });
    var response = await Consts.dio.post("/f/upload", data: formData);
    return response.data;
  }

  Future<XFile?> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.gallery);
  }

  Future<Customer> _loadCustomer() async {
    if (oldData != null) return Future.value(oldData);
    return await CustomerRestClient(Consts.dio).loadCustomer(widget.id);
  }
}
