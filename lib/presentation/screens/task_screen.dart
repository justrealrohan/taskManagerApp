import 'package:flutter/material.dart';
import 'package:real_world_projects/presentation/widgets/background_widget.dart';
import 'package:real_world_projects/presentation/widgets/profile_bar.dart';

import '../../data/models/count_by_status_wrapper.dart';
import '../../data/models/task_list_wrapper.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
import '../widgets/empty_list_widget.dart';
import '../widgets/snack_bar_massage.dart';
import '../widgets/task_card.dart';
import '../widgets/task_counter_card.dart';
import 'add_new_task_screen.dart';

class TaskScreen extends StatefulWidget {
  final String title;
  final String url;
  const TaskScreen({required this.title, required this.url, super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TaskListWrapper _taskListWrapper = TaskListWrapper();
  bool _getAllTaskListInProgress = false;
  CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();
  bool _getAllTaskCountByStatusInProgress = false;

  @override
  void initState() {
    super.initState();
    _getDataFromApis();
  }

  Future<void> _getDataFromApis() async {
    await _getAllTaskList();
    await _getAllTaskCountByStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileBar, // Use AppBar widget
      body: backgroundImage(
        child: Column(
          children: [
            Visibility(
                visible: !_getAllTaskCountByStatusInProgress,
                replacement: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(),
                  ),
                ),
                child: taskCounterSection),
            Expanded(
              child: Visibility(
                visible: !_getAllTaskListInProgress,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: _getDataFromApis,
                  child: Visibility(
                    visible: _taskListWrapper.taskList?.isNotEmpty ?? false,
                    replacement: const EmptyListWidget(),
                    child: ListView.builder(
                      itemCount: _taskListWrapper.taskList?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return TaskCard(
                          taskItem: _taskListWrapper.taskList![index],
                          refreshList: _getDataFromApis,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
          if (result != null && result == true) {
            _getDataFromApis();
          }
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget get taskCounterSection {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _countByStatusWrapper.ListOfTaskByStatusData?.length ?? 0,
          itemBuilder: (context, index) {
            return TaskCounterCard(
              title: _countByStatusWrapper.ListOfTaskByStatusData![index].sId ??
                  '',
              count:
                  _countByStatusWrapper.ListOfTaskByStatusData![index].sum ?? 0,
            );
          },
          separatorBuilder: (__, ___) => const SizedBox(
            height: 16,
          ),
        ),
      ),
    );
  }

  Future<void> _getAllTaskList() async {
    _getAllTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(widget.url);
    _getAllTaskListInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _taskListWrapper = TaskListWrapper.fromJson(response.responseBody);
    } else {
      showSnackBarMessage(context,
          response.errorMessage ?? 'Get task list has been failed', true);
    }
  }

  Future<void> _getAllTaskCountByStatus() async {
    _getAllTaskCountByStatusInProgress = true;
    setState(() {});
    final response =
        await NetworkCaller.getRequest(Urls.getAllTaskCountByStatus);
    _getAllTaskCountByStatusInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _countByStatusWrapper =
          CountByStatusWrapper.fromJson(response.responseBody);
    } else {
      showSnackBarMessage(
          context,
          response.errorMessage ?? 'Get task count by status has been failed',
          true);
    }
  }
}
