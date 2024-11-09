import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manage Students',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ManageStudentsScreen(),
    );
  }
}

class ManageStudentsScreen extends StatefulWidget {
  @override
  _ManageStudentsScreenState createState() => _ManageStudentsScreenState();
}

class _ManageStudentsScreenState extends State<ManageStudentsScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<String> pendingStudents = ['Mario', 'Luigi', 'Waluigi'];
  List<String> approvedStudents = [];
  double _studentFontSize = 25.0;
  Color _appBarColor = Colors.lightBlue[50]!;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  void approveStudent(String student) async {
    String? selectedSection = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SectionSelectionDialog();
      },
    );

    if (selectedSection != null) {
      setState(() {
        pendingStudents.remove(student);
        approvedStudents.add('$student - Section $selectedSection');
      });
    }
  }

  void removeStudent(String student) {
    setState(() {
      pendingStudents.remove(student);
    });
  }

  void updateAppBarColor(Color newColor) {
    setState(() {
      _appBarColor = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _appBarColor,
        title: Center(
          child: Column(
            children: [
              Text(
                'Pamantasan ng Lungsod ng San Pablo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24, // Increased font size
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'College of Computer Studies and Technology',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18, // Increased font size
                ),
              ),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80.0), // Adjust height as needed
          child: Column(
            children: [
              SizedBox(height: 10), // Adds space between title and TabBar
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.black,
                tabs: [
                  Tab(
                    child: Text(
                      '1st Year',
                      style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      '2nd Year',
                      style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      '3rd Year',
                      style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      '4th Year',
                      style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildYearTab('1st Year'),
          buildYearTab('2nd Year'),
          buildYearTab('3rd Year'),
          buildYearTab('4th Year'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => updateAppBarColor(Colors.teal),
        child: Icon(Icons.color_lens),
      ),
    );
  }

  Widget buildYearTab(String year) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$year - Pending Students', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Expanded(
                  child: ListView(
                    children: pendingStudents.map((student) => buildPendingStudent(student)).toList(),
                  ),
                ),
              ],
            ),
          ),
          VerticalDivider(width: 20, thickness: 1, color: Colors.grey),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$year - Approved', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Expanded(
                  child: ListView(
                    children: approvedStudents.map((student) => ListTile(
                      title: Text(student, style: TextStyle(fontSize: _studentFontSize)),
                      leading: Icon(Icons.person),
                    )).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPendingStudent(String student) {
    return ListTile(
      title: Text(student, style: TextStyle(fontSize: _studentFontSize)),
      leading: Icon(Icons.person),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.green),
            onPressed: () => approveStudent(student),
          ),
          IconButton(
            icon: Icon(Icons.close, color: Colors.red),
            onPressed: () => removeStudent(student),
          ),
        ],
      ),
    );
  }
}

class SectionSelectionDialog extends StatelessWidget {
  final List<String> sections = ['A', 'B', 'C', 'D', 'E', 'F'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Choose Section'),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: sections.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Section ${sections[index]}'),
              onTap: () => Navigator.pop(context, sections[index]),
            );
          },
        ),
      ),
    );
  }
}
