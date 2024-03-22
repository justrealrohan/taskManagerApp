import 'package:flutter/material.dart';
import 'package:real_world_projects/data/models/task_list_wrapper.dart';
import 'package:real_world_projects/presentation/widgets/background_widget.dart';
import 'package:real_world_projects/presentation/widgets/empty_list_widget.dart';
import 'package:real_world_projects/presentation/widgets/profile_bar.dart';

import '../../data/models/count_by_status_wrapper.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
import '../widgets/snack_bar_massage.dart';
import '../widgets/task_card.dart';
import '../widgets/task_counter_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  TaskListWrapper _cancelledTaskListWrapper = TaskListWrapper();
  bool _getAllCancelledTaskListInProgress = false;
  CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();
  bool _getAllTaskCountByStatusInProgress = false;


  @override
  void initState() {
    super.initState();
    _getDataFromApis();
  }

  void _getDataFromApis() {
    _getAllCancelledTaskList();
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
                visible: _getAllCancelledTaskListInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: () async => _getDataFromApis(),
                  child: Visibility(
                    visible: _cancelledTaskListWrapper.taskList?.isNotEmpty ?? false,
                    replacement: const EmptyListWidget(),
                    child: ListView.builder(
                      itemCount: _cancelledTaskListWrapper.taskList?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return TaskCard(
                          taskItem: _cancelledTaskListWrapper.taskList![index],
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
  Future<void> _getAllCancelledTaskList() async {
    _getAllCancelledTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.cancelledTaskList);
    if (response.isSuccess) {
      _cancelledTaskListWrapper =
          TaskListWrapper.fromJson(response.responseBody);
      _getAllCancelledTaskListInProgress = false;
      setState(() {});
    } else {
      _getAllCancelledTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ?? 'Get Cancelled task list has been failed',
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
