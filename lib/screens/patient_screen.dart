import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpful_app/constant.dart';
import 'package:helpful_app/screens/patientaddcondition.dart';
import 'package:helpful_app/screens/patientcheckcondition.dart';
import 'package:helpful_app/widgets/patientbasicinfolisttile.dart';
import 'package:helpful_app/widgets/patientbasictopinfo.dart';
import 'package:helpful_app/widgets/patientfeatures.dart';

String patientName;
String patientIc;
String patientGender;
String patientPhone;
String patientAge;
String patientAddress;

class PatientScreen extends StatefulWidget {
  final String patientIc;

  PatientScreen({this.patientIc});

  @override
  _PatientScreenState createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  Future getCurrentPatientData() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('patients')
          .doc(widget.patientIc)
          .get();
      String name = documentSnapshot.get('patientName');
      String ic = documentSnapshot.get('patientIc');
      String gender = documentSnapshot.get('patientGender');
      String phone = documentSnapshot.get('patientPhoneNumber');
      String age = documentSnapshot.get('patientAge');
      String address = documentSnapshot.get('patientAddress');

      setState(() {
        patientName = name;
        patientIc = ic;
        patientGender = gender;
        patientPhone = phone;
        patientAge = age;
        patientAddress = address;
      });

      return;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    getCurrentPatientData();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.patientIc),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.popAndPushNamed(context, 'onBoard');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: kPrimaryBgColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.supervisor_account,
                            size: 50.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      PatientBasicTopInfo(
                        info: '54',
                        title: '看病次數',
                      ),
                      PatientBasicTopInfo(
                        info: '13',
                        title: '照片',
                      ),
                      PatientBasicTopInfo(
                        info: '6',
                        title: '影片',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              // Divider(
              //   height: 2,
              //   thickness: 2,
              // ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  child: Column(
                    children: [
                      PatientBasicInfoListTile(
                        newIcon: Icons.account_circle,
                        patientValue: patientName,
                        title: '姓名',
                      ),
                      PatientBasicInfoListTile(
                        newIcon: Icons.contact_page_rounded,
                        patientValue: patientIc,
                        title: '身份證號碼',
                      ),
                      PatientBasicInfoListTile(
                        newIcon: Icons.wc_rounded,
                        patientValue: patientGender,
                        title: '性別',
                      ),
                      PatientBasicInfoListTile(
                        newIcon: Icons.phone,
                        patientValue: patientPhone,
                        title: '電話號碼',
                      ),
                      PatientBasicInfoListTile(
                        newIcon: Icons.perm_identity,
                        patientValue: patientAge,
                        title: '歲數',
                      ),
                      PatientBasicInfoListTile(
                        newIcon: Icons.location_on,
                        patientValue: patientAddress,
                        title: '地址',
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: TextButton(
                  onPressed: () {
                    //Edit patient info
                    Navigator.pushNamed(context, 'editPatientScreen',
                        arguments: [
                          patientName = patientName,
                          patientIc = patientIc,
                          patientGender = patientGender,
                          patientPhone = patientPhone,
                          patientAge = patientAge,
                          patientAddress = patientAddress,
                        ]);
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

              Divider(
                color: Colors.black,
              ),
              Container(
                height: height / 2,
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10,
                  padding: EdgeInsets.all(10.0),
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('add');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PatientAddCondition(),
                          ),
                        );
                      },
                      child: PatientFeature(
                        title: '新增看診咨詢',
                        icon: Icons.add,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('check');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PatientCheckCondition(),
                          ),
                        );
                      },
                      child: PatientFeature(
                        title: '查詢看診咨詢',
                        icon: Icons.menu_book,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
