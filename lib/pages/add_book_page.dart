import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:clock_hacks_book_reading/models/task_model.dart';
import 'package:clock_hacks_book_reading/network/tasks_apis.dart';
import 'package:clock_hacks_book_reading/store/task_store.dart';
import 'package:clock_hacks_book_reading/store/user_store.dart';
import 'package:clock_hacks_book_reading/utils/app_utils.dart';
import 'package:clock_hacks_book_reading/widgets/login/login_button.dart';
import 'package:clock_hacks_book_reading/widgets/login/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({Key? key}) : super(key: key);

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  List<XFile> files = [];
  final ImagePicker _imagePicker = ImagePicker();

  final _taskNameController = TextEditingController(text: "Test");
  final _taskDurationController = TextEditingController(text: "60");
  String durationType = "minutes";

  bool isNameValid = true;
  bool isDurationValid = true;

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskDurationController.dispose();

    super.dispose();
  }

  validateInputFields() {
    setState(() {
      isNameValid = _taskNameController.text.trim() != "";
      isDurationValid = _taskDurationController.text.trim() != "";
    });
  }

  addImage() async {
    List<XFile> newFiles = await _imagePicker.pickMultiImage();

    setState(() {
      files = newFiles;
    });
  }

  onCameraTapped() async {
    XFile? file = await _imagePicker.pickImage(source: ImageSource.camera);

    if (file == null) {
      return;
    }

    files.add(file);

    setState(() {
      files = files.toList();
    });
  }

  placeholderImage() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      alignment: Alignment.center,
      child: TextButton(
        child: const Text('Add Image'),
        onPressed: () => addImage(),
      ),
    );
  }

  Image xfileToImage(XFile file) {
    final path = file.path;
    final imgFile = File(path);
    return Image.file(imgFile);
  }

  buildCarousel() {
    return Container(
      padding: const EdgeInsets.all(0),
      child: CarouselSlider(
        items: files.map((file) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            child: xfileToImage(file),
          );
        }).toList(),
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.40,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
        ),
      ),
    );
  }

  onSubmitTapped() async {
    validateInputFields();

    if (!isNameValid || !isDurationValid || files.isEmpty) {
      return;
    }

    try {
      AppUtils.showLoading("Adding Book...");

      String token = context.read<UserStore>().currentUser!.token;

      bool uploadSuccessful = await TaskAPI.createTask(
        token,
        _taskNameController.text,
        int.parse(_taskDurationController.text),
        durationType,
        files,
      );

      // if (!uploadSuccessful) {
      //   throw Exception("Failed to create task, please try again later!");
      // }

      AppUtils.dismissLoading();
      // Navigator.pop(context);
      Navigator.pop(context, uploadSuccessful);
    } catch (e) {
      AppUtils.dismissLoading();
      AppUtils.showToast(e.toString());
    }
  }

  final durationTypeList = [
    {
      "label": "Min",
      "value": "minutes",
    },
    {
      "label": "Hours",
      "value": "hours",
    },
    {
      "label": "Days",
      "value": "days",
    },
    {
      "label": "Months",
      "value": "months",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Book'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              files.isEmpty ? placeholderImage() : buildCarousel(),
              const SizedBox(width: 0, height: 10),
              LoginTextField(
                controller: _taskNameController,
                isValid: isNameValid,
                errorText: "taskNameError",
                hintText: "Enter Book Name",
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: LoginTextField(
                      controller: _taskDurationController,
                      isValid: isDurationValid,
                      errorText: "taskDurationError",
                      hintText: "Enter Duration (in Minutes)",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: DropdownButton<String>(
                      items: durationTypeList
                          .map(
                            (e) => DropdownMenuItem(
                              value: e["value"],
                              child: Text(e["label"]!),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          durationType = value ?? durationTypeList[0]["value"]!;
                        });
                      },
                      value: durationType,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              LoginButton(
                text: "SUBMIT",
                onTap: onSubmitTapped,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onCameraTapped(),
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
