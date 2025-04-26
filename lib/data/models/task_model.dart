import '../providers/local_database/databse_constants.dart';
import 'base_model.dart';

class TaskModel implements BaseModel {
  final String? userId;
  final int? taskId; // <-- made this int?
  final String taskTitle;
  final DateTime startTime;
  final DateTime endTime;
  final String category;

  TaskModel({
    this.userId,
    this.taskId,
    required this.taskTitle,
    required this.startTime,
    required this.endTime,
    required this.category,
  });

  /// Create TaskModel from Map (Database)
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      userId: map[DatabaseConstants.columnUserId],
      taskId: map[DatabaseConstants.columnTaskId] is int
          ? map[DatabaseConstants.columnTaskId]
          : int.tryParse(map[DatabaseConstants.columnTaskId].toString()),
      taskTitle: map[DatabaseConstants.columnTaskTitle] ?? '',
      startTime: DateTime.parse(map[DatabaseConstants.columnTaskStartTime]),
      endTime: DateTime.parse(map[DatabaseConstants.columnTaskEndTime]),
      category: map[DatabaseConstants.columnTaskCategory] ?? 'General',
    );
  }

  /// Convert TaskModel to Map (for Database)
  Map<String, dynamic> toMap() {
    return {
      DatabaseConstants.columnUserId: userId,
      DatabaseConstants.columnTaskId: taskId,
      DatabaseConstants.columnTaskTitle: taskTitle,
      DatabaseConstants.columnTaskStartTime: startTime.toIso8601String(),
      DatabaseConstants.columnTaskEndTime: endTime.toIso8601String(),
      DatabaseConstants.columnTaskCategory: category,
    };
  }
}
