import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab4_test/dtos/user.dart';

class ExamDto{
  String id;
  String userEmail;
  String subject;
  DateTime date;
  TimeOfDay time;


  ExamDto(this.id,this.subject, this.date, this.time, this.userEmail);

  String getDateFormatted() => DateFormat("dd-mm-yyyy").format(date);

  String getFormattedTime() => "${time.hour}:${time.minute}";

  Map<String, dynamic> toJson()
  {
    return {
      "name" : subject,
      "description": '',
      "date" : DateTime(date.year, date.month, date.day, time.hour, time.minute),
      "userEmail": userEmail
    };
  }


  static ExamDto fromJson(Map<String, dynamic> json){
    Timestamp timestamp = json['date'];
    DateTime date = timestamp.toDate();


    return ExamDto("",json["name"], date, TimeOfDay(hour: date.hour, minute: date.minute), json["userEmail"]);
  }
}