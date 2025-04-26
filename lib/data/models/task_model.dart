import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String category;

  TaskModel({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.category,
  });

  /// Factory to create from Firebase document
  factory TaskModel.fromMap(Map<String, dynamic> map, String docId) {
    return TaskModel(
      id: docId,
      title: map['title'] ?? '',
      startTime: (map['startTime'] as Timestamp).toDate(),
      endTime: (map['endTime'] as Timestamp).toDate(),
      category: map['category'] ?? 'General',
    );
  }

  /// To send back to Firebase (optional)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'startTime': startTime,
      'endTime': endTime,
      'category': category,
    };
  }
}
