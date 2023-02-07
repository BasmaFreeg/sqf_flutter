List<Map> tasks = [];
// Scaffold(
    //   key: scaffoldKey,
    //   appBar: AppBar(
    //     title: Text(Titles[currentIndex]),
    //   ),
    //   body: ConditionalBuilder(
    //     condition: tasks.length>0,
    //     builder: (context)=> Screens[currentIndex],
    //     fallback: (context)=>Center(
    //         child:CircularProgressIndicator() ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       if (isButtomSheet) {
    //         if (formKey.currentState!.validate()) {
    //           insertToDatabase(
    //                titleController.text,
    //               dateController.text,
    //               timeController.text).then((value)
    //           {
    //             Navigator.pop(context); // by3ml back beeha
    //             isButtomSheet = false;
    //             setState(() {
    //               fabIcon = Icons.edit;
    //           });

    //           });
    //         }
    //       } else {
    //         scaffoldKey.currentState?.showBottomSheet(
    //           (context) => Container(
    //             color: Colors.white,
    //             padding: EdgeInsets.all(20.0),
    //             child: Form(
    //               key: formKey,
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   TextFormField(
    //                     controller: titleController,
    //                     keyboardType: TextInputType.text,
    //                     validator: (value) {
    //                       if (value!.isEmpty) {
    //                         return 'title must not be empty';
    //                       }
    //                       return null;
    //                     },
    //                     decoration: InputDecoration(
    //                       border: OutlineInputBorder(),
    //                       labelText: 'Title Task',
    //                       prefixIcon: Icon(
    //                         Icons.title,
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 15.0,
    //                   ),
    //                   TextFormField(
    //                     controller: timeController,
    //                     keyboardType: TextInputType.datetime,
    //                     onTap: () {
    //                       showTimePicker(
    //                         context: context,
    //                         initialTime: TimeOfDay.now(),
    //                       ).then((value) {
    //                         timeController.text =
    //                             value!.format(context).toString();
    //                         print(value!.format(context));
    //                       });
    //                     },
    //                     validator: (value) {
    //                       if (value!.isEmpty) {
    //                         return 'time must not be empty';
    //                       }
    //                       return null;
    //                     },
    //                     decoration: InputDecoration(
    //                       border: OutlineInputBorder(),
    //                       labelText: 'Task Time',
    //                       prefixIcon: Icon(
    //                         Icons.watch_later_outlined,
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 15.0,
    //                   ),
    //                   TextFormField(
    //                     controller: dateController,
    //                     keyboardType: TextInputType.datetime,
    //                     onTap: () {
    //                       showDatePicker(
    //                           context: context,
    //                           initialDate: DateTime.now(),
    //                           firstDate: DateTime(1940),
    //                           lastDate: DateTime.now())
    //                           .then((value) {
    //                         setState(() {
    //                           dateController.text = DateFormat.yMMMd().format(value!);
    //                         });
    //                       });
    //                     },
    //                     validator: (value) {
    //                       if (value!.isEmpty) {
    //                         return 'Date must not be empty';
    //                       }
    //                       return null;
    //                     },
    //                     decoration: InputDecoration(
    //                       border: OutlineInputBorder(),
    //                       labelText: 'Date Time',
    //                       prefixIcon: Icon(
    //                         Icons.calendar_today,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           elevation: 20.0,
    //         ).closed.then((value) // closed de 3shan lma anzel el bottom sheet be 2eedy el icon tet8yer
    //         {
    //           // msh m7tageen navigator.pop hena 3shan howa hy2fel el bottom sheet w y8yer el icon bs msh hy3mel back
    //           isButtomSheet = false;
    //           setState(() {
    //             fabIcon = Icons.edit;
    //           });
    //         });
    //         isButtomSheet = true;
    //         setState(() {
    //           fabIcon = Icons.add;
    //         });
    //       }
    //     },
    //     child: Icon(fabIcon),
    //   ),
    //   bottomNavigationBar: BottomNavigationBar(
    //     type: BottomNavigationBarType.fixed,
    //     items: [
    //       BottomNavigationBarItem(
    //         label: 'New Tasks',
    //         icon: Icon(Icons.menu),
    //       ),
    //       BottomNavigationBarItem(
    //         label: 'Done Tasks',
    //         icon: Icon(Icons.check_circle_outline),
    //       ),
    //       BottomNavigationBarItem(
    //         label: 'Archive',
    //         icon: Icon(Icons.archive),
    //       )
    //     ],
    //     currentIndex: currentIndex,
    //     onTap: (index) {
    //       setState(() {
    //         currentIndex = index;
    //       });
    //     },
    //   ),
    // );