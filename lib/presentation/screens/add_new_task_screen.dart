import 'package:flutter/material.dart';
import 'package:real_world_projects/data/services/network_caller.dart';
import 'package:real_world_projects/data/utility/urls.dart';
import 'package:real_world_projects/presentation/widgets/background_widget.dart';
import 'package:real_world_projects/presentation/widgets/profile_bar.dart';
import 'package:real_world_projects/presentation/widgets/snack_bar_massage.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isLoading = false;
  bool _shouldRefreshNewTask = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop){
        if(didPop){
          return;
        }
        Navigator.pop(context, _shouldRefreshNewTask);
      },
      child: Scaffold(
        appBar: ProfileBar, // Use AppBar widget
        body: backgroundImage(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    Text(
                      'Add New Task',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      validator: (String? value){
                        if(value?.trim().isEmpty ?? true){
                          return 'Enter your Title';
                        }
                        return null;
                      },
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Task Title',
                        hintText: 'Enter the title of the task',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      validator: (String? value){
                        if(value?.trim().isEmpty ?? true){
                          return 'Enter your Description';
                        }
                        return null;
                      },
                      controller: _descriptionController,
                      maxLines: 6,
                      decoration: const InputDecoration(
                        labelText: 'Task Description',
                        hintText: 'Enter the description of the task',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _isLoading == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              _addNewTask();
                            }
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addNewTask() async{
    _isLoading = true;
    setState(() {
    });

    Map<String, dynamic> userData = {
      "title": _titleController.text.trim(),
      "description": _descriptionController.text.trim(),
      "status": "New"
    };

    final response = await NetworkCaller.postRequest(Urls.createTask, userData);

    _isLoading = false;
    setState(() {});

    if(response.isSuccess){
      _shouldRefreshNewTask = true;
      _titleController.clear();
      _descriptionController.clear();
      if(mounted){
        showSnackBarMessage(context, 'New Task has been added');
      }
    }
    else{
      if(mounted){
        showSnackBarMessage(context, response.errorMessage ?? 'add new task failed', true);
      }
    }

  }


  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

