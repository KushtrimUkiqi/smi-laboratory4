import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../dtos/examDto.dart';

class CardComponent extends StatelessWidget {

  final String examId;
  final Function _deleteExamAppointment;

  const CardComponent(this.examId, this._deleteExamAppointment,{Key? key}) : super(key: key);

  // void _deleteExamAppointment() {
  //   var doc = FirebaseFirestore.instance.collection('events').doc(examId);
  //   doc.delete();
  // }

  @override
  Widget build(BuildContext context) {
    CollectionReference events = FirebaseFirestore.instance.collection('events');

    return FutureBuilder<DocumentSnapshot>(
        future: events.doc(examId).get(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done)
          {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

            /// only solution of the moment, since this is just a laboratory exercise, otherwise this should not be event thought !
            /// also apologise for the mess of the code.

            var currentUserEmail = FirebaseAuth.instance.currentUser?.email;

            if (data['userEmail'].toString() != currentUserEmail)
            {
              return SizedBox();
            }

            var examDto = ExamDto.fromJson(data);
            // Timestamp timestamp = data['date'];
            // DateTime date = timestamp.toDate();
            //
            // var examDto = ExamDto("",data["name"], date, TimeOfDay(hour: date.hour, minute: date.minute), currentUserEmail ?? '');

            return Card(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                height: 90,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(examDto.subject,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left),
                          IconButton(
                              onPressed: () {
                                _deleteExamAppointment(examId);
                              },
                              icon:
                              Icon(Icons.delete, color: Colors.indigo))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            examDto.getDateFormatted(),
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          SizedBox(width: 20),
                          Text(examDto.getFormattedTime(),
                              style: TextStyle(color: Colors.grey[700]))
                        ],
                      )
                    ]),
              ),
            );
          }

          return SizedBox();
        });

  }
}
