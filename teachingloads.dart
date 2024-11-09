import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final TextEditingController courseController = TextEditingController();
  final TextEditingController semesterController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController courseTitleController = TextEditingController();
  final List<String> courses = [];

  bool showCourseForm = false; // Boolean to control the display of the form

  @override
  void initState() {
    super.initState();
    courses.addAll([
      'NETWORKING212 - Networking 1',
      'NETWORKING213 - Networking 2',
      'NETWORKING214 - Networking 3',
      'NETWORKING215 - Networking 4',
    ]);
  }

  void addCourse() {
    if (courseTitleController.text.isNotEmpty &&
        semesterController.text.isNotEmpty &&
        yearController.text.isNotEmpty) {
      setState(() {
        courses.add(courseTitleController.text);
      });
      courseTitleController.clear();
      semesterController.clear();
      yearController.clear();
    }
    Navigator.of(context).pop(); // Close the dialog after adding the course
  }

  void showCourseFormDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fill out the Information'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: semesterController,
                  decoration: InputDecoration(
                    labelText: 'Semester',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: courseTitleController,
                  decoration: InputDecoration(
                    labelText: 'Course',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: yearController,
                  decoration: InputDecoration(
                    labelText: 'Academic Year',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: addCourse,
                  child: Text('Add Course'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void deleteCourse(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Course'),
          content: Text('Are you sure you want to DELETE this course?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  courses.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text("Delete"),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat', // Set Montserrat as the default font
      ),
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'Pamantasan ng Lungsod ng San Pablo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'College of Computer Studies and Technology',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Text(
                'Teaching Loads',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              // Align the button to the right side
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: showCourseFormDialog, // Show the form when this is pressed
                    child: Text('Add Course'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Set button background color
                      foregroundColor: Colors.green, // Set text color
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.9,  // Adjusted child aspect ratio to make boxes smaller and neat
                  ),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    return buildAccountBox(courses[index], index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAccountBox(String title, int index) {
    return Container(
      width: double.infinity,  // Ensure the container takes up the full width
      height: 200,  // Set a fixed height for the account box
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),  // Slightly reduced radius for smaller box
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,  // Reduced blur radius to match the smaller box size
            spreadRadius: 3,  // Reduced spread radius
          ),
        ],
      ),
      child: Column(
        children: [
          // The header now takes up the full width without padding
          Container(
            width: double.infinity,  // Ensure full width of the container
            decoration: BoxDecoration(
              color: Colors.green, // Set the header background to green
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ), // Rounded top corners
            ),
            padding: EdgeInsets.symmetric(vertical: 8.0),  // Adjusted padding for title
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Set the text color to black
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10),

          // Buttons inside the box
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(4, (buttonIndex) {
                  String buttonText = '';
                  switch (buttonIndex) {
                    case 0:
                      buttonText = 'Select Instructor';
                      break;
                    case 1:
                      buttonText = 'Select Day';
                      break;
                    case 2:
                      buttonText = 'Insert Time';
                      break;
                    case 3:
                      buttonText = 'Year and Section';
                      break;
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: buildButton(context, title, buttonText),
                  );
                }),
              ],
            ),
          ),

          // Delete Button
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextButton(
              onPressed: () {
                deleteCourse(index);
              },
              child: Text(
                'Delete Course',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(BuildContext context, String title, String buttonText) {
    return OutlinedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$buttonText for $title')),
        );
      },
      child: Text(
        buttonText,
        style: TextStyle(
          fontWeight: FontWeight.bold,  // Make the text bold
        ),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,  // Text color (default is blue)
        side: BorderSide(color: Colors.green), // Border color
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20), // Padding for the button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
      ),
    );
  }
}
