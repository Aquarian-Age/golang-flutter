import 'package:flutter/material.dart';

class ExampleForm extends StatefulWidget {
  const ExampleForm({super.key});

  @override
  State<ExampleForm> createState() => _ExampleFormState();
}

class _ExampleFormState extends State<ExampleForm> {
  // Note: This is a GlobalKey<FormState>,
  final _formKey = GlobalKey<FormState>();
//创建监听文本的显示
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    //myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  // void _printLatestValue() {
  //   print('Second text field: ${myController.text}');
  // }

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form  Demo';
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
        actions: [],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 获取输入内容
            TextField(
              style: const TextStyle(color: Colors.red, fontSize: 16),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              autofocus: true,
              controller: myController,
              // onChanged: ((value) => print("输入了： $value")),
              onEditingComplete: () => print("输入内容为: ${myController.text}"), //输入之后回车
            ),

            ////  捕获和处理点击动作 底部显示
            //// https://flutter.cn/docs/cookbook/gestures/handling-taps
            GestureDetector(
              // When the child is tapped, show a snackbar.
              onTap: () {
                var snackBar = SnackBar(content: Text('onTap ${myController.text}'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              // The custom button
              child: Container(
                padding: const EdgeInsets.all(9.0),
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Text('Button'),
              ),
            ),
            // //搜索框
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            //   child: TextField(
            //     decoration: const InputDecoration(
            //       border: OutlineInputBorder(),
            //       hintText: 'Enter a search term',
            //     ),
            //     onSubmitted: (value) => print("value: $value"),
            //   ),
            // ),
            // //输入框密码
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            //   child: TextFormField(
            //     decoration: const InputDecoration(
            //       border: UnderlineInputBorder(),
            //       labelText: 'Enter your password',
            //     ),
            //   ),
            // ),
            // Divider(),
            // TextField(
            //   controller: myController,
            // ),
            //弹窗显示myController输入的值
            FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    //弹窗
                    return AlertDialog(
                      content: Text(myController.text),
                    );
                  },
                );
              },
              tooltip: 'Show me the value!', //鼠标悬停显示
              child: const Icon(Icons.text_fields),
            ),
            // const Divider(
            //   height: 30,
            // ),
          ],
        ),
      ),
    );
    // );
  }
}

///--------------------------------
//   final _formKey = GlobalKey<FormState>();
//   String title = '';
//   String description = '';
//   DateTime date = DateTime.now();
//   double maxValue = 0;
//   bool? brushedTeeth = false;
//   bool enableFeature = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Form widgets'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Scrollbar(
//           child: Align(
//             alignment: Alignment.topCenter,
//             child: Card(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: ConstrainedBox(
//                   constraints: const BoxConstraints(maxWidth: 400),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       ...[
//                         TextFormField(
//                           decoration: const InputDecoration(
//                             filled: true,
//                             hintText: 'Enter a title...',
//                             labelText: 'Title',
//                           ),
//                           onChanged: (value) {
//                             setState(() {
//                               title = value;
//                             });
//                           },
//                         ),
//                         TextFormField(
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             filled: true,
//                             hintText: 'Enter a description...',
//                             labelText: 'Description',
//                           ),
//                           onChanged: (value) {
//                             description = value;
//                           },
//                           maxLines: 5,
//                         ),
//                         _FormDatePicker(
//                           date: date,
//                           onChanged: (value) {
//                             setState(() {
//                               date = value;
//                             });
//                           },
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Estimated value',
//                                   style: Theme.of(context).textTheme.bodyLarge,
//                                 ),
//                               ],
//                             ),
//                             // Text(
//                             //   intl.NumberFormat.currency(symbol: "\$", decimalDigits: 0).format(maxValue),
//                             //   style: Theme.of(context).textTheme.titleMedium,
//                             // ),
//                             Slider(
//                               min: 0,
//                               max: 500,
//                               divisions: 500,
//                               value: maxValue,
//                               onChanged: (value) {
//                                 setState(() {
//                                   maxValue = value;
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Checkbox(
//                               value: brushedTeeth,
//                               onChanged: (checked) {
//                                 setState(() {
//                                   brushedTeeth = checked;
//                                 });
//                               },
//                             ),
//                             Text('Brushed Teeth', style: Theme.of(context).textTheme.titleMedium),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text('Enable feature', style: Theme.of(context).textTheme.bodyLarge),
//                             Switch(
//                               value: enableFeature,
//                               onChanged: (enabled) {
//                                 setState(() {
//                                   enableFeature = enabled;
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//                       ].expand(
//                         (widget) => [
//                           widget,
//                           const SizedBox(
//                             height: 24,
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _FormDatePicker extends StatefulWidget {
//   final DateTime date;
//   final ValueChanged<DateTime> onChanged;

//   const _FormDatePicker({
//     required this.date,
//     required this.onChanged,
//   });

//   @override
//   State<_FormDatePicker> createState() => _FormDatePickerState();
// }

// class _FormDatePickerState extends State<_FormDatePicker> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Text(
//               'Date',
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//             // Text(
//             //   intl.DateFormat.yMd().add_jm().format(widget.date),
//             //   style: Theme.of(context).textTheme.titleMedium,
//             // ),
//           ],
//         ),
//         TextButton(
//           child: const Text('Edit'),
//           onPressed: () async {
//             var newDate = await showDatePicker(
//               context: context,
//               initialDate: widget.date,
//               firstDate: DateTime(1900),
//               lastDate: DateTime(2100),
//             );

//             // Don't change the date if the date picker returns null.
//             if (newDate == null) {
//               return;
//             }

//             widget.onChanged(newDate);
//           },
//         )
//       ],
//     );
//   }
// }
