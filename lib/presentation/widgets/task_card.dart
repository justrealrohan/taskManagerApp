import 'package:flutter/material.dart';
import 'package:real_world_projects/data/models/task_item.dart';
import 'package:real_world_projects/presentation/widgets/snack_bar_massage.dart';

import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';


class TaskCard extends StatefulWidget{
  const TaskCard({
    super.key, required this.taskItem, required this.refreshList,
  });

  final TaskItem taskItem;
  final VoidCallback refreshList;



  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {

  bool _updateTaskByIdInProgress = false;
  bool _deleteTaskInProgress = false;


  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskItem.title ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.taskItem.description ?? ''),
            Text('Date: ${widget.taskItem.createdDate}'),
            Row(
              children: [
                Chip(
                  label: Text(widget.taskItem.status ?? ''),
                ),
                const Spacer(),
                Visibility(
                  visible: _updateTaskByIdInProgress == false,
                  replacement: const CircularProgressIndicator(),
                  child: IconButton(
                    onPressed: () {
                      if (widget.taskItem.sId != null) {
                        _showUpdateStatusDialog(widget.taskItem.sId!);
                       }
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ),
                Visibility(
                  visible: _deleteTaskInProgress == false,
                  replacement: const CircularProgressIndicator(),
                  child: IconButton(
                    onPressed: (){
                      if (widget.taskItem.sId != null) {
                        _deleteTaskById(widget.taskItem.sId!); // Assuming _deleteTaskById is your method for deleting tasks
                      } else {
                        // Show SnackBar if sId is null
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Cannot perform action: Task ID is missing.'),
                            duration: Duration(seconds: 3), // Duration is optional
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }



  void _showUpdateStatusDialog(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('New'),
              trailing: _isCurrentStatus('New') ? const Icon(Icons.check): null,
              onTap: (){
                if(_isCurrentStatus('New')){
                  return;
                }
                _updateTaskById(id, 'New');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Completed'),
              trailing: _isCurrentStatus('Completed') ? const Icon(Icons.check): null,
              onTap: (){
                if(_isCurrentStatus('Completed')){
                  return;
                }
                _updateTaskById(id, 'Completed');
                Navigator.pop(context);
              },

            ),
            ListTile(
              title: const Text('Progress'),
              trailing: _isCurrentStatus('Progress') ? const Icon(Icons.check): null,
              onTap: (){
                if(_isCurrentStatus('Progress')){
                  return;
                }
                _updateTaskById(id, 'Progress');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Cancelled'),
              trailing: _isCurrentStatus('Cancelled') ? const Icon(Icons.check): null,
              onTap: (){
                if(_isCurrentStatus('Cancelled')){
                  return;
                }
                _updateTaskById(id, 'Cancelled');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  bool _isCurrentStatus(String status){
    return widget.taskItem.status == status;
  }
  Future<void> _updateTaskById(String id, String status) async {
    _updateTaskByIdInProgress = true;
    setState(() {});
    final response =
    await NetworkCaller.getRequest(Urls.updateTaskById(id, status));
    _updateTaskByIdInProgress = false;
    if (response.isSuccess) {
      _updateTaskByIdInProgress = false;
      widget.refreshList();
    } else {
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Update Task has been failed', true);
      }
    }
  }

  Future<void> _deleteTaskById(String id) async {
    _deleteTaskInProgress = true;
    setState(() {});



    final response = await NetworkCaller.getRequest(Urls.deleteTask(id));
    _deleteTaskInProgress = false;
    if (response.isSuccess) {
      widget.refreshList();
    } else {
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Delete Task has been failed', true);
      }
    }
  }

}