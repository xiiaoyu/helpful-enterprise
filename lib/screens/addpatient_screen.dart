import 'dart:io';

import 'package:flutter/material.dart';
import 'package:helpful_app/constant.dart';
import 'package:helpful_app/services/database.dart';
import 'package:helpful_app/services/storage_service.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:helpful_app/widgets/flexibletextformfield.dart';
import 'package:helpful_app/widgets/patientinfotext.dart';

final fireStore = FirebaseFirestore.instance;

enum Gender { Male, Female }

List<String> _selectedSixDisease = [];
List<String> _selectedRecoveryChoice = [];

class AddPatientScreen extends StatefulWidget {
  @override
  _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final Storage storage = Storage();
  final ImagePicker _picker = ImagePicker();
  String imageFileName;
  List<XFile> _selectedImageList = [];

  void selectUploadImage() async {
    final XFile selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage.path != null) {
      _selectedImageList.add(selectedImage);
    }
    // imagePath = _selectedImageList;
    imageFileName = selectedImage.name;

    setState(() {});
  } //select images from gallery.

  final _formKey = GlobalKey<FormState>();
  final _patientPersonalInfoKey = GlobalKey<FormState>();

  bool showSpinner = false;

  DatabaseService databaseService = DatabaseService();

  Gender _gender = Gender.Male;

  TextEditingController patientNameTextEditingController =
      TextEditingController();
  TextEditingController icNumberTextEditingController = TextEditingController();
  TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  TextEditingController ageTextEditingController = TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();

  TextEditingController maixiangTextEditingController = TextEditingController();
  TextEditingController shexiangTextEditingController = TextEditingController();
  TextEditingController maixiangshexiangbeizhuTextEditingController =
      TextEditingController();

  TextEditingController sixdiseasebeizhuTextEditingController =
      TextEditingController();
  TextEditingController miaosudiseaseTextEditingController =
      TextEditingController();

  TextEditingController recoveryzhenjiubeizhuTextEditingController =
      TextEditingController();
  TextEditingController recoveryyaofangbeizhuTextEditingController =
      TextEditingController();
  TextEditingController recoverychengyaobeizhuTextEditingController =
      TextEditingController();

  String patientName = '';
  String patientIc = '';
  String patientGender = '';
  String patientPhoneNumber = '';
  String patientAge = '';
  String patientAddress = '';
  var patientPhotos;
  String patientMaiXiang = '';
  String patientSheXiang = '';
  String patientMaiXiangSheXiangBeiZhu = '';
  String patientSixDisease = '';
  String patientSixDiseaseBeiZhu = '';
  String patientMiaoSuDisease = '';
  String patientRecoveryChoice = '';
  String patientRecoveryZhenJiuBeiZhu = '';
  String patientRecoveryYaoFangBeiZhu = '';
  String patientRecoveryChengYaoBeiZhu = '';

  int _currentStep = 0;

  String imageUrl;

  // String path;
  // String fileName;
  // String uploadImagePatientIc;

  insertPatientData() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat.yMd().add_jms();
    final String time = formatter.format(now);

    Map<String, dynamic> patientsBasicInfo = {
      'createAt': time,
      'patientName': patientNameTextEditingController.text,
      'patientIc': icNumberTextEditingController.text,
      'patientGender': _gender.toString() == 'Gender.Male' ? '???' : '???',
      'patientPhoneNumber': phoneNumberTextEditingController.text,
      'patientAge': ageTextEditingController.text,
      'patientAddress': addressTextEditingController.text,
    };

    try {
      //set the location of firebase storage where need to store those data.
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('patients')
          .doc(icNumberTextEditingController.text);
      //insert those data to that location.
      documentReference
          .set(patientsBasicInfo)
          .whenComplete(() => print(icNumberTextEditingController.text));
    } catch (e) {
      print(e.toString());
    }

    Map<String, dynamic> patientsCase = {
      'createAt': time,
      'patientName': patientNameTextEditingController.text,
      'patientIc': icNumberTextEditingController.text,
      'patientGender': _gender.toString() == 'Gender.Male' ? '???' : '???',
      'patientAge': ageTextEditingController.text,
      'patientMaiXiang': maixiangTextEditingController.text,
      'patientSheXiang': shexiangTextEditingController.text,
      'patientMaiXiangSheXiangBeiZhu':
          maixiangshexiangbeizhuTextEditingController.text,
      'patientSixDisease': _selectedSixDisease.toString(),
      'patientSixDiseaseBeiZhu': sixdiseasebeizhuTextEditingController.text,
      'patientMiaoSuDisease': miaosudiseaseTextEditingController.text,
      'patientRecoveryChoice': _selectedRecoveryChoice.toString(),
      'patientRecoveryZhenJiuBeiZhu':
          recoveryzhenjiubeizhuTextEditingController.text,
      'patientRecoveryYaoFangBeiZhu':
          recoveryyaofangbeizhuTextEditingController.text,
      'patientRecoveryChengYaoBeiZhu':
          recoverychengyaobeizhuTextEditingController.text,
    };

    try {
      //set the location of firebase storage where need to store those data.
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('patient case')
          .doc(patientIc)
          .collection(time.replaceAll('/', '-'))
          .doc();
      //insert those data to that location.
      documentReference
          .set(patientsCase)
          .whenComplete(() => print(icNumberTextEditingController.text));
    } catch (e) {
      print(e.toString());
    }

    // storage.uploadImage(_selectedImageList, patientIc);

    storage
        .uploadFile(
          _selectedImageList[1].path,
          icNumberTextEditingController.text,
          imageFileName,
        )
        .then(
          (value) => print('done'),
        );
  }

  Future<void> showPatientInformation() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: AlertDialog(
              title: Text(
                '????????????',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.7,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PatientInfoText(
                          infoTitle: '??????', patientInfoValue: patientName),
                      PatientInfoText(
                          infoTitle: '???????????????', patientInfoValue: patientIc),
                      PatientInfoText(
                          infoTitle: '??????',
                          patientInfoValue:
                              _gender.toString() == 'Gender.Male' ? '???' : '???'),
                      PatientInfoText(
                          infoTitle: '????????????',
                          patientInfoValue: patientPhoneNumber),
                      PatientInfoText(
                          infoTitle: '??????', patientInfoValue: patientAge),
                      PatientInfoText(
                          infoTitle: '??????', patientInfoValue: patientAddress),
                      PatientInfoText(
                          infoTitle: '??????', patientInfoValue: patientMaiXiang),
                      PatientInfoText(
                          infoTitle: '??????', patientInfoValue: patientSheXiang),
                      PatientInfoText(
                          infoTitle: '??????',
                          patientInfoValue: patientMaiXiangSheXiangBeiZhu),
                      PatientInfoText(
                          infoTitle: '????????????',
                          patientInfoValue: _selectedSixDisease.toString()),
                      PatientInfoText(
                          infoTitle: '??????',
                          patientInfoValue: patientSixDiseaseBeiZhu),
                      PatientInfoText(
                          infoTitle: '????????????',
                          patientInfoValue: patientMiaoSuDisease),
                      PatientInfoText(
                          infoTitle: '???????????????',
                          patientInfoValue: _selectedRecoveryChoice.toString()),
                      PatientInfoText(
                          infoTitle: '????????????',
                          patientInfoValue: patientRecoveryZhenJiuBeiZhu),
                      PatientInfoText(
                          infoTitle: '????????????',
                          patientInfoValue: patientRecoveryYaoFangBeiZhu),
                      PatientInfoText(
                          infoTitle: '????????????',
                          patientInfoValue: patientRecoveryChengYaoBeiZhu),
                    ],
                  ),
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        //add new patient
                        if (_patientPersonalInfoKey.currentState.validate()) {
                          setState(() {
                            showSpinner = true;
                          });

                          await insertPatientData();

                          setState(() {
                            showSpinner = false;
                          });

                          Navigator.pushNamedAndRemoveUntil(
                              context, 'onBoard', (route) => false);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              action: SnackBarAction(
                                label: '??????',
                                onPressed: () {},
                              ),
                              content: Text('??????????????????!'),
                              width: MediaQuery.of(context).size.width * 0.9,
                              duration: Duration(milliseconds: 2000),
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                      ),
                      child: Text(
                        '??????',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('??????'),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '????????????',
        ),
      ),
      body: Container(
        height: _height,
        width: _width,
        child: Form(
          key: _formKey,
          child: Stepper(
            steps: _mySteps(),
            currentStep: _currentStep,
            controlsBuilder: (BuildContext context,
                {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
              return Row(
                children: [
                  TextButton(
                    onPressed: onStepCancel,
                    child: Text(
                      '?????????',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  _currentStep == 5
                      ? TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            textStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            //??????????????????????????????
                            if (_patientPersonalInfoKey.currentState
                                .validate()) {
                              showPatientInformation();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  action: SnackBarAction(
                                    label: '??????',
                                    onPressed: () {},
                                  ),
                                  content: Text(
                                    '?????????????????????????????????!',
                                    style: TextStyle(
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  duration: Duration(milliseconds: 2000),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              );
                            }
                            print(patientName);
                          },
                          child: Text(
                            '????????????',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2.0,
                            ),
                          ),
                        )
                      : TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            textStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: onStepContinue,
                          child: Text(
                            '?????????',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                ],
              );
            },
            onStepTapped: (step) {
              setState(() {
                _currentStep = step;
              });
            },
            onStepContinue: () {
              setState(() {
                if (_currentStep < _mySteps().length - 1) {
                  _currentStep = _currentStep + 1;
                }
              });
            },
            onStepCancel: () {
              setState(() {
                if (_currentStep > 0) {
                  _currentStep = _currentStep - 1;
                } else {
                  _currentStep = 0;
                }
              });
            },
          ),
        ),
      ),
    );
  }

  List<Step> _mySteps() {
    List<Step> _steps = [
      //---------------??????????????????---------------------
      Step(
        title: Text(
          '????????????',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Form(
          key: _patientPersonalInfoKey,
          child: Column(
            children: [
              FlexibleTextFormField(
                hintText: '??????',
                textEditingController: patientNameTextEditingController,
                onChangeFunction: (value) {
                  patientName = value;
                },
                validatorFunction: (value) {
                  return value.isEmpty ? '???????????????' : null;
                },
              ),
              FlexibleTextFormField(
                hintText: '???????????????',
                textInputType: TextInputType.number,
                textEditingController: icNumberTextEditingController,
                onChangeFunction: (value) {
                  patientIc = value;
                },
                validatorFunction: (value) {
                  return value.isEmpty || value.length != 12
                      ? '?????????????????????12??????'
                      : null;
                },
              ),
              Row(
                children: [
                  Text(
                    '??????:',
                    style: TextStyle(
                      fontSize: kPrimaryTextSize,
                    ),
                  ),
                  Radio(
                      value: Gender.Male,
                      groupValue: _gender,
                      onChanged: (Gender value) {
                        setState(() {
                          _gender = value;
                          print(_gender);
                        });
                      }),
                  Text(
                    '???',
                    style: TextStyle(
                      fontSize: kPrimaryTextSize,
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Radio(
                      value: Gender.Female,
                      groupValue: _gender,
                      onChanged: (Gender value) {
                        setState(() {
                          _gender = value;
                          print(_gender);
                        });
                      }),
                  Text(
                    '???',
                    style: TextStyle(
                      fontSize: kPrimaryTextSize,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  FlexibleTextFormField(
                    flexNumber: 2,
                    hintText: '????????????',
                    textEditingController: phoneNumberTextEditingController,
                    textInputType: TextInputType.number,
                    onChangeFunction: (value) {
                      patientPhoneNumber = value;
                    },
                    validatorFunction: (value) {
                      return value.isEmpty ? '?????????????????????' : null;
                    },
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  FlexibleTextFormField(
                    flexNumber: 1,
                    hintText: '??????',
                    textEditingController: ageTextEditingController,
                    textInputType: TextInputType.number,
                    onChangeFunction: (value) {
                      patientAge = value;
                    },
                    validatorFunction: (value) {
                      return value.isEmpty ? '???????????????' : null;
                    },
                  ),
                ],
              ),
              FlexibleTextFormField(
                hintText: '??????',
                textEditingController: addressTextEditingController,
                onChangeFunction: (value) {
                  patientAddress = value;
                },
                validatorFunction: (value) {
                  return value.isEmpty ? '???????????????' : null;
                },
              ),
            ],
          ),
        ),
        isActive: _currentStep >= 0,
      ),
      //---------------??????/??????---------------------
      Step(
        title: Text(
          '????????????',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              children: [
                //upload images and videos

                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: selectUploadImage,
                ),
                Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: _selectedImageList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.file(
                                File(_selectedImageList[index].path),
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                right: -10,
                                top: -10,
                                child: Container(
                                  child: IconButton(
                                    onPressed: () {
                                      _selectedImageList.removeAt(index);
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.delete_forever),
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
        isActive: _currentStep >= 1,
      ),
      //---------------???????????????---------------------
      Step(
        title: Text(
          '???????????????',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          children: [
            FlexibleTextFormField(
              hintText: '??????',
              textEditingController: maixiangTextEditingController,
              onChangeFunction: (value) {
                patientMaiXiang = value;
              },
            ),
            FlexibleTextFormField(
              hintText: '??????',
              textEditingController: shexiangTextEditingController,
              onChangeFunction: (value) {
                patientSheXiang = value;
              },
            ),
            FlexibleTextFormField(
              hintText: '??????',
              textEditingController:
                  maixiangshexiangbeizhuTextEditingController,
              onChangeFunction: (value) {
                patientMaiXiangSheXiangBeiZhu = value;
              },
            )
          ],
        ),
        isActive: _currentStep >= 2,
      ),
      //---------------????????????---------------------
      Step(
        title: Text(
          '????????????',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          children: [
            FlexibleTextFormField(
              hintText: '??????',
              textEditingController: miaosudiseaseTextEditingController,
              onChangeFunction: (value) {
                patientMiaoSuDisease = value;
              },
            )
          ],
        ),
        isActive: _currentStep >= 3,
      ),

      //---------------????????????---------------------
      Step(
        title: Text(
          '????????????',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          children: [
            Wrap(
              spacing: 3.0,
              children: [
                SixDiseaseFilterChipWidget(
                  chipName: '?????????',
                ),
                SixDiseaseFilterChipWidget(
                  chipName: '?????????',
                ),
                SixDiseaseFilterChipWidget(
                  chipName: '?????????',
                ),
                SixDiseaseFilterChipWidget(
                  chipName: '?????????',
                ),
                SixDiseaseFilterChipWidget(
                  chipName: '?????????',
                ),
                SixDiseaseFilterChipWidget(
                  chipName: '?????????',
                ),
              ],
            ),
            FlexibleTextFormField(
              hintText: '??????',
              textEditingController: sixdiseasebeizhuTextEditingController,
              onChangeFunction: (value) {
                patientSixDiseaseBeiZhu = value;
              },
            ),
          ],
        ),
        isActive: _currentStep >= 4,
      ),

      //---------------???????????????---------------------
      Step(
        title: Text(
          '???????????????',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 30.0,
              children: [
                RecoveryChoiceFilterChip(
                  chipName: '??????',
                  chipChild: FlexibleTextFormField(
                    hintText: '????????????',
                    textEditingController:
                        recoveryzhenjiubeizhuTextEditingController,
                    onChangeFunction: (value) {
                      patientRecoveryZhenJiuBeiZhu = value;
                    },
                  ),
                ),
                RecoveryChoiceFilterChip(
                  chipName: '??????',
                  chipChild: FlexibleTextFormField(
                    hintText: '????????????',
                    textEditingController:
                        recoveryyaofangbeizhuTextEditingController,
                    onChangeFunction: (value) {
                      patientRecoveryYaoFangBeiZhu = value;
                    },
                  ),
                ),
                RecoveryChoiceFilterChip(
                  chipName: '??????',
                  chipChild: Visibility(
                    child: FlexibleTextFormField(
                      hintText: '????????????',
                      textEditingController:
                          recoverychengyaobeizhuTextEditingController,
                      onChangeFunction: (value) {
                        patientRecoveryChengYaoBeiZhu = value;
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            // FlexibleTextFormField(
            //   hintText: '??????',
            //   textEditingController: recoveryBeiZhuTextEditingController,
            //   onChangeFunction: (value) {
            //     patientRecoveryBeiZhu = value;
            //   },
            // ),
          ],
        ),
        isActive: _currentStep >= 5,
      ),
    ];
    return _steps;
  }
}

class SixDiseaseFilterChipWidget extends StatefulWidget {
  final String chipName;

  SixDiseaseFilterChipWidget({this.chipName});

  @override
  _SixDiseaseFilterChipWidgetState createState() =>
      _SixDiseaseFilterChipWidgetState();
}

class _SixDiseaseFilterChipWidgetState
    extends State<SixDiseaseFilterChipWidget> {
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(
        color: Colors.black,
        fontSize: kPrimaryTextSize,
      ),
      selected: _selectedSixDisease.contains(widget.chipName),
      backgroundColor: Colors.grey,
      onSelected: (selectedValue) {
        setState(() {
          if (_selectedSixDisease.contains(widget.chipName)) {
            _selectedSixDisease.remove(widget.chipName);
          } else {
            _selectedSixDisease.add(widget.chipName);
          }
        });
      },
      selectedColor: kPrimaryColor,
    );
  }
}

class RecoveryChoiceFilterChip extends StatefulWidget {
  final String chipName;
  final Widget chipChild;

  RecoveryChoiceFilterChip({this.chipName, this.chipChild});
  @override
  _RecoveryChoiceFilterChipState createState() =>
      _RecoveryChoiceFilterChipState();
}

class _RecoveryChoiceFilterChipState extends State<RecoveryChoiceFilterChip> {
  bool selectedValues = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilterChip(
          label: Text(widget.chipName),
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: kPrimaryTextSize,
          ),
          selected: _selectedRecoveryChoice.contains(widget.chipName),
          backgroundColor: Colors.grey,
          onSelected: (selectedValue) {
            setState(() {
              if (_selectedRecoveryChoice.contains(widget.chipName)) {
                _selectedRecoveryChoice.remove(widget.chipName);
                selectedValues = false;
              } else {
                _selectedRecoveryChoice.add(widget.chipName);
                selectedValues = true;
              }
            });
          },
          selectedColor: kPrimaryColor,
        ),
        Visibility(
          visible: selectedValues,
          child: widget.chipChild,
        )
      ],
    );
  }
}
