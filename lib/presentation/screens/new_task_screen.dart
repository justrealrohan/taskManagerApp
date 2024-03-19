import 'package:flutter/material.dart';
import 'package:real_world_projects/data/models/count_by_status_wrapper.dart';
import 'package:real_world_projects/presentation/screens/add_new_task_screen.dart';
import 'package:real_world_projects/presentation/widgets/background_widget.dart';
import 'package:real_world_projects/presentation/widgets/profile_bar.dart';

import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
import '../widgets/snack_bar_massage.dart';
import '../widgets/task_card.dart';
import '../widgets/task_counter_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _isLoading = false;
  CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();

  @override
  void initState() {
    _getAllTaskCountByStatus();
    super.initState();
  }

  Widget taskCounterSection() {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _countByStatusWrapper.ListOfTaskByStatusData?.length ?? 0,
          itemBuilder: (context, index) {
            return TaskCounterCard(
              title: _countByStatusWrapper.ListOfTaskByStatusData![index].sId ?? '',
              count: _countByStatusWrapper.ListOfTaskByStatusData![index]
                  .sum ?? 0,
            );
          },
          separatorBuilder: (__, ___) => const SizedBox(
            height: 16,
          ),
        ),
      ),
    );
  }

  Future<void> _getAllTaskCountByStatus() async {
    _isLoading = true;
    setState(() {});
    final response =
        await NetworkCaller.getRequest(Urls.getAllTaskCountByStatus);
    if (response.isSuccess) {
      _countByStatusWrapper =
          CountByStatusWrapper.fromJson(response.responseBody);
      _isLoading = false;
      setState(() {});
    } else {
      _isLoading = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ?? 'Get task count by status has been failed',
            true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileBar, // Use AppBar widget
      body: backgroundImage(
        child: Column(
          children: [
            Visibility(
                visible: _isLoading == false,
                replacement: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(),
                  ),
                ),
                child: taskCounterSection()),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return const TaskCard();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
