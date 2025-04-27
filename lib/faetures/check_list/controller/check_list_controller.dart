import 'package:get/get.dart';
class ChecklistController extends GetxController {
  /// Define the Rx variables for the goal input and checklist tasks
  var goalInput = ''.obs;
  var checklistTasks = <String>[].obs;
  var isLoading = false.obs;

  /// Predefined checklist templates
  final Map<String, List<String>> checklistTemplates = {
    'Apply for internship': [
      'Update Resume',
      'Prepare Portfolio',
      'Write Cover Letter',
      'Submit Application',
      'Prepare for Interview',
      'Follow up with companies',
    ],
    'Plan vacation': [
      'Choose destination',
      'Book flights',
      'Book accommodation',
      'Pack luggage',
      'Check weather forecast',
      'Arrange transportation',
    ],
    'Prepare for a job interview': [
      'Research the company',
      'Practice interview questions',
      'Choose outfit',
      'Prepare questions for the interviewer',
      'Get a good night\'s sleep',
      'Bring necessary documents (e.g., resume, ID)',
    ],
    'Start a new project': [
      'Define project goals',
      'Create project plan',
      'Set up project repository',
      'Assign tasks to team members',
      'Set project timeline',
      'Identify project risks and mitigation plans',
    ],
    'Plan a wedding': [
      'Set a date',
      'Create a guest list',
      'Book venue',
      'Choose wedding dress and attire',
      'Order invitations',
      'Arrange catering',
    ],
    'Build a personal website': [
      'Choose a domain name',
      'Select a hosting provider',
      'Design website layout',
      'Write content for pages',
      'Test website for mobile compatibility',
      'Launch website',
    ],
    'Learn a new language': [
      'Choose the language',
      'Set learning goals',
      'Find learning resources (e.g., apps, books)',
      'Practice daily',
      'Watch movies or listen to podcasts in the language',
      'Test your progress with quizzes',
    ],
    'Start a fitness routine': [
      'Set fitness goals',
      'Choose a workout plan',
      'Buy necessary equipment',
      'Create a workout schedule',
      'Track progress',
      'Join a fitness community',
    ],
    'Start a blog': [
      'Choose a niche',
      'Create a content plan',
      'Set up the blog website',
      'Write the first post',
      'Promote your blog on social media',
      'Monetize your blog through ads or affiliate marketing',
    ],
    'Plan a birthday party': [
      'Choose a theme',
      'Send invitations',
      'Order cake and food',
      'Decorate the venue',
      'Create a playlist for the party',
      'Arrange entertainment or games',
    ],
  };


  /// Method to generate checklist based on goal input
  void generateChecklist() async {
    if (goalInput.value.isEmpty) {
      checklistTasks.clear();
      return;
    }

    isLoading.value = true;

    /// Simulate a network delay
    await Future.delayed(Duration(seconds: 1));

    /// Check if the goal input matches a predefined checklist
    if (checklistTemplates.containsKey(goalInput.value)) {
      checklistTasks.value = checklistTemplates[goalInput.value]!;
    } else {
      checklistTasks.value = ['No checklist found for this goal.'];
    }
    isLoading.value = false;
  }
}

