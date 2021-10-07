import 'package:flutter/material.dart';
import 'package:helpful_app/constant.dart';
import 'package:helpful_app/services/database.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _patientPersonalInfoKey = GlobalKey<FormState>();

  bool showSpinner = false;

  DatabaseService databaseService = DatabaseService();

  Gender _gender = Gender.Male;

  TextEditingController patientNameTextEditingController = TextEditingController();
  TextEditingController icNumberTextEditingController = TextEditingController();
  TextEditingController phoneNumberTextEditingController = TextEditingController();
  TextEditingController ageTextEditingController = TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();

  TextEditingController maixiangTextEditingController = TextEditingController();
  TextEditingController shexiangTextEditingController = TextEditingController();
  TextEditingController maixiangshexiangbeizhuTextEditingController = TextEditingController();

  TextEditingController sixdiseasebeizhuTextEditingController = TextEditingController();
  TextEditingController miaosudiseaseTextEditingController = TextEditingController();

  TextEditingController recoveryzhenjiubeizhuTextEditingController = TextEditingController();
  TextEditingController recoveryyaofangbeizhuTextEditingController = TextEditingController();
  TextEditingController recoverychengyaobeizhuTextEditingController = TextEditingController();

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

  insertPatientData() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat.yMd().add_jms();
    final String time = formatter.format(now);

    Map<String, dynamic> patientsBasicInfo = {
      'createAt': time,
      'patientName': patientNameTextEditingController.text,
      'patientIc': icNumberTextEditingController.text,
      'patientGender': _gender.toString() == 'Gender.Male' ? '男' : '女',
      'patientPhoneNumber': phoneNumberTextEditingController.text,
      'patientAge': ageTextEditingController.text,
      'patientAddress': addressTextEditingController.text,
    };

    try {
      //set the location of firebase storage where need to store those data.
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('patients').doc(icNumberTextEditingController.text);
      //insert those data to that location.
      documentReference.set(patientsBasicInfo).whenComplete(() => print(icNumberTextEditingController.text));
    } catch (e) {
      print(e.toString());
    }

    Map<String, dynamic> patientsCase = {
      'createAt': time,
      'patientName': patientNameTextEditingController.text,
      'patientIc': icNumberTextEditingController.text,
      'patientGender': _gender.toString() == 'Gender.Male' ? '男' : '女',
      'patientAge': ageTextEditingController.text,
      'patientMaiXiang': maixiangTextEditingController.text,
      'patientSheXiang': shexiangTextEditingController.text,
      'patientMaiXiangSheXiangBeiZhu': maixiangshexiangbeizhuTextEditingController.text,
      'patientSixDisease': _selectedSixDisease.toString(),
      'patientSixDiseaseBeiZhu': sixdiseasebeizhuTextEditingController.text,
      'patientMiaoSuDisease': miaosudiseaseTextEditingController.text,
      'patientRecoveryChoice': _selectedRecoveryChoice.toString(),
      'patientRecoveryZhenJiuBeiZhu': recoveryzhenjiubeizhuTextEditingController.text,
      'patientRecoveryYaoFangBeiZhu': recoveryyaofangbeizhuTextEditingController.text,
      'patientRecoveryChengYaoBeiZhu': recoverychengyaobeizhuTextEditingController.text,
    };

    try {
      //set the location of firebase storage where need to store those data.
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('patient case')
          .doc(patientIc)
          .collection(time.replaceAll('/', '-'))
          .doc();
      //insert those data to that location.
      documentReference.set(patientsCase).whenComplete(() => print(icNumberTextEditingController.text));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> showPatientInformation() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: AlertDialog(
              title: Text(
                '病人資訊',
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
                      PatientInfoText(infoTitle: '姓名', patientInfoValue: patientName),
                      PatientInfoText(infoTitle: '身份證號碼', patientInfoValue: patientIc),
                      PatientInfoText(
                          infoTitle: '性別', patientInfoValue: _gender.toString() == 'Gender.Male' ? '男' : '女'),
                      PatientInfoText(infoTitle: '電話號碼', patientInfoValue: patientPhoneNumber),
                      PatientInfoText(infoTitle: '年齡', patientInfoValue: patientAge),
                      PatientInfoText(infoTitle: '地址', patientInfoValue: patientAddress),
                      PatientInfoText(infoTitle: '圖片/影片', patientInfoValue: patientPhotos),
                      PatientInfoText(infoTitle: '脈象', patientInfoValue: patientMaiXiang),
                      PatientInfoText(infoTitle: '舌象', patientInfoValue: patientSheXiang),
                      PatientInfoText(infoTitle: '備註', patientInfoValue: patientMaiXiangSheXiangBeiZhu),
                      PatientInfoText(infoTitle: '診斷病證', patientInfoValue: _selectedSixDisease.toString()),
                      PatientInfoText(infoTitle: '備註', patientInfoValue: patientSixDiseaseBeiZhu),
                      PatientInfoText(infoTitle: '描述病情', patientInfoValue: patientMiaoSuDisease),
                      PatientInfoText(infoTitle: '配藥的配方', patientInfoValue: _selectedRecoveryChoice.toString()),
                      PatientInfoText(infoTitle: '針灸備註', patientInfoValue: patientRecoveryZhenJiuBeiZhu),
                      PatientInfoText(infoTitle: '藥方備註', patientInfoValue: patientRecoveryYaoFangBeiZhu),
                      PatientInfoText(infoTitle: '成藥備註', patientInfoValue: patientRecoveryChengYaoBeiZhu),
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

                          Navigator.pushNamedAndRemoveUntil(context, 'onBoard', (route) => false);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              action: SnackBarAction(
                                label: '關閉',
                                onPressed: () {},
                              ),
                              content: Text('病人新增成功!'),
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
                        '新增',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('返回'),
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
          '新增病人',
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
            controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
              return Row(
                children: [
                  TextButton(
                    onPressed: onStepCancel,
                    child: Text(
                      '上一步',
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
                            //再次確認然後上傳資料
                            if (_patientPersonalInfoKey.currentState.validate()) {
                              showPatientInformation();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  action: SnackBarAction(
                                    label: '關閉',
                                    onPressed: () {},
                                  ),
                                  content: Text(
                                    '個人資料欄位不符合規格!',
                                    style: TextStyle(
                                      letterSpacing: 1.0,
                                    ),
                                  ),
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
                            print(patientName);
                          },
                          child: Text(
                            '確認新增',
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
                            '下一步',
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
      //---------------個人資料欄位---------------------
      Step(
        title: Text(
          '個人資料',
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
                hintText: '姓名',
                textEditingController: patientNameTextEditingController,
                onChangeFunction: (value) {
                  patientName = value;
                },
                validatorFunction: (value) {
                  return value.isEmpty ? '姓名不能空' : null;
                },
              ),
              FlexibleTextFormField(
                hintText: '身份證號碼',
                textInputType: TextInputType.number,
                textEditingController: icNumberTextEditingController,
                onChangeFunction: (value) {
                  patientIc = value;
                },
                validatorFunction: (value) {
                  return value.isEmpty || value.length != 12 ? '身份證號碼只能12個字' : null;
                },
              ),
              Row(
                children: [
                  Text(
                    '性別:',
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
                    '男',
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
                    '女',
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
                    hintText: '電話號碼',
                    textEditingController: phoneNumberTextEditingController,
                    textInputType: TextInputType.number,
                    onChangeFunction: (value) {
                      patientPhoneNumber = value;
                    },
                    validatorFunction: (value) {
                      return value.isEmpty ? '電話號碼不能空' : null;
                    },
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  FlexibleTextFormField(
                    flexNumber: 1,
                    hintText: '年齡',
                    textEditingController: ageTextEditingController,
                    textInputType: TextInputType.number,
                    onChangeFunction: (value) {
                      patientAge = value;
                    },
                    validatorFunction: (value) {
                      return value.isEmpty ? '年齡不能空' : null;
                    },
                  ),
                ],
              ),
              FlexibleTextFormField(
                hintText: '地址',
                textEditingController: addressTextEditingController,
                onChangeFunction: (value) {
                  patientAddress = value;
                },
                validatorFunction: (value) {
                  return value.isEmpty ? '地址不能空' : null;
                },
              ),
            ],
          ),
        ),
        isActive: _currentStep >= 0,
      ),
      //---------------圖片/影片---------------------
      Step(
        title: Text(
          '圖片/影片',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          children: [
            //upload images and videos
            IconButton(icon: Icon(Icons.add), onPressed: () {}),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
        isActive: _currentStep >= 1,
      ),
      //---------------脈象，舌象---------------------
      Step(
        title: Text(
          '脈象，舌象',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          children: [
            FlexibleTextFormField(
              hintText: '脈象',
              textEditingController: maixiangTextEditingController,
              onChangeFunction: (value) {
                patientMaiXiang = value;
              },
            ),
            FlexibleTextFormField(
              hintText: '舌象',
              textEditingController: shexiangTextEditingController,
              onChangeFunction: (value) {
                patientSheXiang = value;
              },
            ),
            FlexibleTextFormField(
              hintText: '備註',
              textEditingController: maixiangshexiangbeizhuTextEditingController,
              onChangeFunction: (value) {
                patientMaiXiangSheXiangBeiZhu = value;
              },
            )
          ],
        ),
        isActive: _currentStep >= 2,
      ),
      //---------------描述病情---------------------
      Step(
        title: Text(
          '描述病情',
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          children: [
            FlexibleTextFormField(
              hintText: '病情',
              textEditingController: miaosudiseaseTextEditingController,
              onChangeFunction: (value) {
                patientMiaoSuDisease = value;
              },
            )
          ],
        ),
        isActive: _currentStep >= 3,
      ),

      //---------------診斷病證---------------------
      Step(
        title: Text(
          '診斷病證',
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
                  chipName: '太陽病',
                ),
                SixDiseaseFilterChipWidget(
                  chipName: '少陽病',
                ),
                SixDiseaseFilterChipWidget(
                  chipName: '陽明病',
                ),
                SixDiseaseFilterChipWidget(
                  chipName: '太陰病',
                ),
                SixDiseaseFilterChipWidget(
                  chipName: '少陰病',
                ),
                SixDiseaseFilterChipWidget(
                  chipName: '厥陰病',
                ),
              ],
            ),
            FlexibleTextFormField(
              hintText: '備註',
              textEditingController: sixdiseasebeizhuTextEditingController,
              onChangeFunction: (value) {
                patientSixDiseaseBeiZhu = value;
              },
            ),
          ],
        ),
        isActive: _currentStep >= 4,
      ),

      //---------------配藥的配方---------------------
      Step(
        title: Text(
          '配藥的配方',
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
                  chipName: '針灸',
                  chipChild: FlexibleTextFormField(
                    hintText: '針灸備註',
                    textEditingController: recoveryzhenjiubeizhuTextEditingController,
                    onChangeFunction: (value) {
                      patientRecoveryZhenJiuBeiZhu = value;
                    },
                  ),
                ),
                RecoveryChoiceFilterChip(
                  chipName: '藥方',
                  chipChild: FlexibleTextFormField(
                    hintText: '藥方備註',
                    textEditingController: recoveryyaofangbeizhuTextEditingController,
                    onChangeFunction: (value) {
                      patientRecoveryYaoFangBeiZhu = value;
                    },
                  ),
                ),
                RecoveryChoiceFilterChip(
                  chipName: '成藥',
                  chipChild: Visibility(
                    child: FlexibleTextFormField(
                      hintText: '成藥備註',
                      textEditingController: recoverychengyaobeizhuTextEditingController,
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
            //   hintText: '備註',
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
  _SixDiseaseFilterChipWidgetState createState() => _SixDiseaseFilterChipWidgetState();
}

class _SixDiseaseFilterChipWidgetState extends State<SixDiseaseFilterChipWidget> {
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
  _RecoveryChoiceFilterChipState createState() => _RecoveryChoiceFilterChipState();
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
