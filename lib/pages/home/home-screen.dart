import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab4_test/components/bottom-bar.dart';
import 'package:lab4_test/pages/home/components/card.dart';
import '../../dtos/examDto.dart';
import './components/add-exam-modal.dart';
import '../../components/drawer.dart';

enum ItemType { itemOne, itemTwo, itemThree }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ItemType? selectedMenu;
  int y  = 1;
  List<String> documents = [];

  void _addNewExam(exam) {
    setState(() {
      // exams.add(exam);
    });
  }

  void refresh()
  {
    setState(() {
      y = y + 1;
    });
  }

  void _deleteExamAppointment(String examId) {
    var doc = FirebaseFirestore.instance.collection('events').doc(examId);
    doc.delete();
    refresh();
  }

  Future getDocuments() async {
    documents = [];

    await FirebaseFirestore.instance.collection("events").get().then((snapshot) => {
      snapshot.docs.forEach((element) => {
        documents.add(element.reference.id)
      })
    });

    // setState(() {
    //   documents = localDocumentIds;
    // });
  }

  Future<void> _addExamDialogOpen(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddExamModal(addNewExam: (value) {
          _addNewExam(value);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBarComponent(),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: () {
            _addExamDialogOpen(context);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: DrawerComponent(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          child: FutureBuilder(
            future: getDocuments(),
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index){
                return CardComponent(documents[index], _deleteExamAppointment);
              });
            },
          ),
        ),
      ),
    );
  }

}
