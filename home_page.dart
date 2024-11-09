import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'main.dart';
import 'manage.dart';
import 'finalizegrades.dart'; // Import your Finalize Grades page here
import 'teachingloads.dart';
import 'main.dart'; // Import your Login page here

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> cardOrder = ['Manage Students', 'Finalize Grades', 'Teaching Loads', 'Account'];
  final SwiperController _swiperController = SwiperController();

  // Function to show sign out confirmation dialog
  Future<void> _showSignOutDialog() async {
    bool confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sign Out"),
        content: Text("Are you sure you want to sign out?"),
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  LoginPage()), // Navigate to LoginPage
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F8FC),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundplsp.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            buildHeader(),

            // Add a Sign Out button in the header or footer
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.logout, color: Colors.black),
                  onPressed: _showSignOutDialog, // Call the sign-out dialog
                ),
              ),
            ),

            Expanded(
              child: Center(
                child: Swiper(
                  controller: _swiperController,
                  itemWidth: 700,
                  itemHeight: 300,
                  loop: true,
                  duration: 1200,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (cardOrder[index] == 'Manage Students') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ManageStudentsScreen()),
                          );
                        } else if (cardOrder[index] == 'Finalize Grades') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FinalizeGradesScreen()), // Navigate to Finalize Grades page
                          );
                        } else if (cardOrder[index] == 'Teaching Loads') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => App()), // Navigate to Teaching Loads page
                          );
                        } else {
                          _swiperController.next();
                        }
                      },
                      child: Container(
                        width: 400,
                        height: 400,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          cardOrder[index],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: cardOrder.length,
                  layout: SwiperLayout.STACK,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  onPressed: () {
                    _swiperController.next();
                  },
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.arrow_downward),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 800 ? 15.0 : 22.0;
    double subtitleFontSize = screenWidth < 600 ? 10.0 : 12.0;
    double padding = screenWidth < 600 ? 12.0 : 16.0;
    double avatarSize = screenWidth < 600 ? 25.0 : 30.0;
    double spacing = screenWidth < 600 ? 12.0 : 16.0;

    return Container(
      color: const Color(0xFFF2F8FC),
      padding: EdgeInsets.all(padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: avatarSize,
            backgroundColor: const Color(0xFFF2F8FC),
            backgroundImage: const AssetImage('assets/images/plsp.jpg'),
          ),
          SizedBox(width: spacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Pamantasan ng Lungsod ng San Pablo',
                  style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Brgy. San Jose, San Pablo City',
                  style: TextStyle(fontSize: subtitleFontSize, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Tel No: (049) 536-7380',
                  style: TextStyle(fontSize: subtitleFontSize, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Email Address: plspofficial@plsp.edu.ph',
                  style: TextStyle(fontSize: subtitleFontSize, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: HomePage()));
}
