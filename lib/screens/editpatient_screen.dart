import 'package:flutter/material.dart';
import 'package:helpful_app/constant.dart';
import 'package:helpful_app/screens/patient_screen.dart';
import 'package:helpful_app/widgets/patientbasicinfolisttile.dart';
import 'package:helpful_app/widgets/patienteditbasicinfowidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

TextEditingController patientNameEditingController = TextEditingController();
TextEditingController patientPhoneEditingController = TextEditingController();
TextEditingController patientAgeEditingController = TextEditingController();
TextEditingController patientAddressEditingController = TextEditingController();

enum Gender { Male, Female }
bool showSpinner = false;

class EditPatientScreen extends StatefulWidget {
  @override
  _EditPatientScreenState createState() => _EditPatientScreenState();
}

class _EditPatientScreenState extends State<EditPatientScreen> {
  Gender _gender = Gender.Male;
  String receiveGender;
  final _formKey = GlobalKey<FormState>();

  void getUpdateData() {
    patientNameEditingController.text = patientName;
    receiveGender = patientGender;
    print(receiveGender);
    patientPhoneEditingController.text = patientPhone;
    patientAgeEditingController.text = patientAge;
    patientAddressEditingController.text = patientAddress;
  }

  void receiveGenderData(String gender) {
    if (gender == '男') {
      _gender = Gender.Male;
    } else if (gender == '女') {
      _gender = Gender.Female;
    }
  }

  Future updatePatientData() async {
    //update patient data
    if (patientNameEditingController.text != null) {
      try {
        Map<String, dynamic> patientsUpdatedData = {
          'patientName': patientNameEditingController.text,
          'patientGender': _gender.toString() == 'Gender.Male' ? '男' : '女',
          'patientPhoneNumber': patientPhoneEditingController.text,
          'patientAge': patientAgeEditingController.text,
          'patientAddress': patientAddressEditingController.text,
        };

        DocumentReference documentReference = FirebaseFirestore.instance.collection('patients').doc(patientIc);

        await documentReference.update(patientsUpdatedData);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            action: SnackBarAction(
              label: '關閉',
              onPressed: () {},
            ),
            content: Text('成功!'),
            width: MediaQuery.of(context).size.width * 0.9,
            duration: Duration(milliseconds: 2000),
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
      } catch (e) {
        print(e.toString());
      }
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUpdateData(); //1.must receive all data 1st.
    receiveGenderData(receiveGender); //2.only can receive gender data.
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('編輯資料'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Container(
            height: _height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 100,
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.supervisor_account,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        PatientEditBasicInfoWidget(
                          title: '姓名',
                          valueTextFormField: TextFormField(
                            controller: patientNameEditingController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Text(
                              '身份證號碼: $patientIc',
                              style: TextStyle(
                                letterSpacing: 1.0,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Text(
                              '性別: ',
                              style: TextStyle(
                                letterSpacing: 1.0,
                                fontSize: 18.0,
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
                        PatientEditBasicInfoWidget(
                          title: '電話號碼',
                          valueTextFormField: TextFormField(
                            controller: patientPhoneEditingController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '電話號碼不能空';
                              }
                              return null;
                            },
                          ),
                        ),
                        PatientEditBasicInfoWidget(
                          title: '年齡',
                          valueTextFormField: TextFormField(
                            controller: patientAgeEditingController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '年齡不能空';
                              }
                              return null;
                            },
                          ),
                        ),
                        PatientEditBasicInfoWidget(
                          title: '地址',
                          valueTextFormField: TextFormField(
                            controller: patientAddressEditingController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '地址不能空';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextButton(
                      onPressed: () async {
                        //update patient data

                        setState(() {
                          showSpinner = true;
                        });

                        if (!_formKey.currentState.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('全部欄位一定要符合規格')));
                        } else {
                          await updatePatientData().whenComplete(() {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PatientScreen(
                                          patientIc: patientIc,
                                        )),
                                (route) => false);
                          });
                        }

                        setState(() {
                          showSpinner = false;
                        });

                        // Navigator.of(context).pushNamed("patientScreen").then((value) => setState(() {}));

                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        //   return PatientScreen(
                        //     patientIc: patientIc,
                        //   );
                        // }));

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => PatientScreen(
                        //       patientIc: patientIc,
                        //     ),
                        //   ),
                        // );

                        // Future.delayed(Duration(seconds: 1), () {
                        //   setState(() {
                        //     showSpinner = false;
                        //   });
                        // });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        side: BorderSide(width: 1.0),
                      ),
                      child: Text(
                        '編輯資料',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.0,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
