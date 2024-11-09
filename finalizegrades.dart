import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: FinalizeGradesScreen(),
  ));
}

class FinalizeGradesScreen extends StatefulWidget {
  @override
  _FinalizeGradesScreenState createState() => _FinalizeGradesScreenState();
}

class _FinalizeGradesScreenState extends State<FinalizeGradesScreen> {
  List<Map<String, String>> pendingGrades = [
    {
      "name": "Joy Masiyahin",
      "subject": "CC214 - Data Structure and Algorithm",
      "section": "BSIT 2C",
      "avatar": 'assets/joy.png'
    },
    {
      "name": "Anger Galit",
      "subject": "CC214 - Data Structure and Algorithm",
      "section": "BSIT 2A",
      "avatar": 'assets/anger.png'
    },
    {
      "name": "Joy Masiyahin",
      "subject": "CC214 - Data Structure and Algorithm",
      "section": "BSIT 2D",
      "avatar": 'assets/joy.png'
    },
    {
      "name": "Joy Masiyahin",
      "subject": "CC111 - Introduction to Computing",
      "section": "BSIT 2C",
      "avatar": 'assets/joy.png'
    },
  ];

  List<Map<String, String>> approvedGrades = [
    {
      "name": "Sadness Malungkot",
      "subject": "GE101 - Understanding the Self",
      "section": "BSIT 1C",
      "avatar": 'assets/sadness.png'
    },
    {
      "name": "Fear Duwag",
      "subject": "GE101 - Understanding the Self",
      "section": "BSIT 1F",
      "avatar": 'assets/fear.png'
    },
    {
      "name": "Anger Galit",
      "subject": "LITE - Living in IT Era",
      "section": "BSIT 1A",
      "avatar": 'assets/anger.png'
    },
    {
      "name": "Joy Masiyahin",
      "subject": "ITProfE11 - Advanced Software Development",
      "section": "BSIT 3D",
      "avatar": 'assets/joy.png'
    },
  ];

  void approveGrade(int index) {
    setState(() {
      approvedGrades.add(pendingGrades[index]);
      pendingGrades.removeAt(index);
    });
  }

  Future<void> showApproveDialog(int index) async {
    String name = pendingGrades[index]["name"]!;
    bool confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Approve Grade"),
        content: Text("Do you want to approve this grade for $name?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("No"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text("Yes"),
          ),
        ],
      ),
    ) ?? false;

    if (confirmed) {
      approveGrade(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/university_logo.png'),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Pamantasan ng Lungsod ng San Pablo College of Computer Studies and Technology',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "Student Grades",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  // Pending Grades Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Pending Grades",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: pendingGrades.length,
                            itemBuilder: (context, index) {
                              return gradeCard(
                                pendingGrades[index]["name"]!,
                                pendingGrades[index]["subject"]!,
                                pendingGrades[index]["section"]!,
                                pendingGrades[index]["avatar"]!,
                                onApprove: () => showApproveDialog(index),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(thickness: 1, color: Colors.grey),
                  // Approved Grades Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Approved",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: approvedGrades.length,
                            itemBuilder: (context, index) {
                              return gradeCard(
                                approvedGrades[index]["name"]!,
                                approvedGrades[index]["subject"]!,
                                approvedGrades[index]["section"]!,
                                approvedGrades[index]["avatar"]!,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget gradeCard(String name, String subject, String section, String avatarPath, {VoidCallback? onApprove}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(avatarPath),
        ),
        title: Text(
          name,
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subject, style: TextStyle(fontFamily: 'Montserrat')),
            Text(section, style: TextStyle(fontFamily: 'Montserrat')),
          ],
        ),
        trailing: onApprove != null
            ? ElevatedButton(
          onPressed: onApprove,
          child: Text("Approve"),
        )
            : null,
      ),
    );
  }
}
