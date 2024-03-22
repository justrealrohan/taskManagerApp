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

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {

  TaskListWrapper _progressTaskListWrapper = TaskListWrapper();
  bool _getAllProgressTaskListInProgress = false;
  CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();
  bool _getAllTaskCountByStatusInProgress = false;


  @override
  void initState() {
    super.initState();
    _getDataFromApis();
  }

  void _getDataFromApis() {
    _getAllProgressTaskList();
    _getAllTaskCountByStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileBar, // Use AppBar widget
      body: backgroundImage(
        child: Column(
          children: [
            Visibility(
                visible: _getAllTaskCountByStatusInProgress == false,
                replacement: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(),
                  ),
                ),
                child: taskCounterSection),
            Expanded(
              child: Visibility(
                visible: _getAllProgressTaskListInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: () async => _getDataFromApis(),
                  child: Visibility(
                    visible: _progressTaskListWrapper.taskList?.isNotEmpty ?? false,
                    replacement: const EmptyListWidget(),
                    child: ListView.builder(
                      itemCount: _progressTaskListWrapper.taskList?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return TaskCard(
                          taskItem: _progressTaskListWrapper.taskList![index],
                          refreshList: () {
                            _getDataFromApis();
                          },
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
  Future<void> _getAllProgressTaskList() async {
    _getAllProgressTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.progressTaskList);
    if (response.isSuccess) {
      _progressTaskListWrapper =
          TaskListWrapper.fromJson(response.responseBody);
      _getAllProgressTaskListInProgress = false;
      setState(() {});
    } else {
     _getAllProgressTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ?? 'Get progress task list has been failed',
            true);
      }
    }
  }
  Future<void> _getAllTaskCountByStatus() async {
    _getAllTaskCountByStatusInProgress = true;
    setState(() {});
    final response =
    await NetworkCaller.getRequest(Urls.getAllTaskCountByStatus);
    if (response.isSuccess) {
      _countByStatusWrapper =
          CountByStatusWrapper.fromJson(response.responseBody);
      _getAllTaskCountByStatusInProgress = false;
      setState(() {});
    } else {
      _getAllTaskCountByStatusInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ?? 'Get task count by status has been failed',
            true);
      }
    }
  }
}