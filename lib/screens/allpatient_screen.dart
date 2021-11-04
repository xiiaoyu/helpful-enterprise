import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:helpful_app/screens/patient_screen.dart';
import '../constant.dart';

final _fireStore = FirebaseFirestore.instance;

class AllPatientScreen extends StatefulWidget {
  @override
  _AllPatientScreenState createState() => _AllPatientScreenState();
}

class _AllPatientScreenState extends State<AllPatientScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            '病人',
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: '姓名或身份證號碼',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: AllPatients(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//get all patient data from firebase.
class AllPatients extends StatefulWidget {
  @override
  _AllPatientsState createState() => _AllPatientsState();
}

class _AllPatientsState extends State<AllPatients> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _fireStore.collection('patients').orderBy('patientName').snapshots(),
      builder: (context, snapshots) {
        List<PatientListSlide> storePatientWidget = [];

        if (!snapshots.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
            ),
          );
        }

        final allPatient = snapshots.data.docs;

        for (var patientInfo in allPatient) {
          final patientName = patientInfo['patientName'];
          final patientIc = patientInfo['patientIc'];

          final patientWidget = PatientListSlide(
            patientName: patientName,
            patientIc: patientIc,
          );

          storePatientWidget.add(patientWidget);
        }

        return ListView(
          children: storePatientWidget,
        );
      },
    );
  }
}

//patient data widget.
class PatientListSlide extends StatefulWidget {
  final String patientName;
  final String patientIc;

  PatientListSlide({
    this.patientName,
    this.patientIc,
  });
  @override
  _PatientListSlideState createState() => _PatientListSlideState();
}

class _PatientListSlideState extends State<PatientListSlide> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: GestureDetector(
        onTap: () {
          //navigator to that patient info page.
          print(widget.patientName);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatientScreen(
                patientIc: widget.patientIc,
              ),
            ),
          );
        },
        child: Container(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.supervisor_account),
              foregroundColor: Colors.white,
            ),
            title: Text(
              '${widget.patientName}',
              style: TextStyle(
                fontSize: 17.0,
              ),
            ),
            subtitle: Text(
              '${widget.patientIc}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
              ),
            ),
          ),
        ),
      ),
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
          caption: '刪除',
          color: kPrimaryColor,
          icon: Icons.delete,
          onTap: () {},
        ),
      ],
    );
  }
}
