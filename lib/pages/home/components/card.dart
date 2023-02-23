import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../dtos/examDto.dart';

// class CardComponent extends StatefulWidget {
//   final String examId;
//   const CardComponent(this.examId, {Key? key}) : super(key: key);
//
//   @override
//   State<CardComponent> createState() => _CardComponentState();
// }
//
// class _CardComponentState extends State<CardComponent> {
//
//   late ExamDto examDto;
//
//
//   void _deleteSubject(int idx) {
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference events = FirebaseFirestore.instance.collection('events');
//
//     return FutureBuilder<DocumentSnapshot>(
//         future: events.doc(this.widget.examId ?? ""),
//         builder: (context, snapshot) {
//       if(snapshot.connectionState == ConnectionState.done)
//         {
//           Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
//
//           setState(() {
//             examDto = ExamDto(data["name"], DateTime.now(), TimeOfDay.now());
//           });
//
//           return Card(
//             child: Container(
//               padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
//               height: 90,
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(examDto.subject,
//                             style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold),
//                             textAlign: TextAlign.left),
//                         IconButton(
//                             onPressed: () {
//                               _deleteSubject(1);
//                             },
//                             icon:
//                             Icon(Icons.delete, color: Colors.indigo))
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text(
//                           examDto.getDateFormatted(),
//                           style: TextStyle(color: Colors.grey[700]),
//                         ),
//                         SizedBox(width: 20),
//                         Text(examDto.getFormattedTime(),
//                             style: TextStyle(color: Colors.grey[700]))
//                       ],
//                     )
//                   ]),
//             ),
//           );
//         }
//
//       return SizedBox();
//     });
//
//   }
// }


class CardComponent extends StatelessWidget {

  final String examId;

  const CardComponent(this.examId ,{Key? key}) : super(key: key);

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

            Timestamp timestamp = data['date'];
            DateTime date = timestamp.toDate();

            var examDto = ExamDto(data["name"], date, TimeOfDay(hour: date.hour, minute: date.minute));

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
