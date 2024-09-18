// import 'package:flutter/material.dart';

// //final _scaffoldKeys = GlobalKey<ScaffoldState>();

// // ValueNotifier<TaskType> selectedTaskNotifier =
// //     ValueNotifier(TaskType.pendingTsk);

// class RadioButton extends StatelessWidget {
//   final String title;
//   // final TaskType type;
//   const RadioButton({required this.title, required this.type, Key? key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       // key: _scaffoldKeys,
//       children: [
//         ValueListenableBuilder(
//             valueListenable: selectedTaskNotifier,
//             builder: (BuildContext ctx, TaskType newtask, Widget? _) {
//               return Radio<TaskType>(
//                 value: type,
//                 groupValue: newtask,
//                 onChanged: (value) async {
//                   if (value == null) {
//                     return;
//                   }
//                   //  else if (value == TaskType.pendingTsk) {
//                   //   const String task = asgnd;
//                   //   Taskdetails.instance.refreshAssigned(task, context);
//                   // } else if (value == TaskType.completedTsk) {
//                   //   const String task = cmpltd;
//                   //   Taskdetails.instance.refreshAssigned(task, context);
//                   // } else if (value == TaskType.recontactTsk) {
//                   //   const String task = rcntct;
//                   //   Taskdetails.instance.refreshAssigned(task, context);
//                   // }
//                   // else if (value == TaskType.paid) {
//                   //   const String task = paid;
//                   //   Taskdetails.instance.paidpartpaid(task, context);
//                   // } else if (value == TaskType.partpaid) {
//                   //   const String task = partpaid;
//                   //   Taskdetails.instance.paidpartpaid(task, context);
//                   // } else if (value == TaskType.both) {
//                   //   const String task = both;
//                   //   Taskdetails.instance.paidpartpaid(task, context);
//                   // }
//                   // selectedTaskNotifier.value.clear();
//                   // selectedTaskNotifier.value = value;
//                   // selectedTaskNotifier.notifyListeners();
//                 },
//               );
//             }),
//         Text(title),
//       ],
//     );
//   }
//   // @override
//   // void dispose(){
//   //   selectedTaskNotifier.dispose();
//   //   super.dispose();
//   // }
// }
