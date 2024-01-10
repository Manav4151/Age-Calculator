import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Age Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String myAge = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Age Calculator' ),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).primaryColor),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your Age is', style: GoogleFonts.robotoMono(
                          fontSize: 28, color: Colors.black)),
            const SizedBox(height: 10),
            Text(myAge , style: GoogleFonts.robotoMono(
                          fontSize: 20, color: Colors.black)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => pickDob(),
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered))
                      return Colors.blueGrey; 
                    return null;
                  },
                ),
              ),
              child: const Text('Pick Your Date of Birth'),
            ),
            Image.network("https://i0.wp.com/amarvani.blog/wp-content/uploads/2015/05/quel-age-avez-vous.jpg?ssl=1")
          ],
        ),
      ),
    );
  }

  pickDob() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate != null) {
        calculateAge(pickedDate);
      }
    });
  }

  calculateAge(DateTime birth) {
    DateTime now = DateTime.now();
    Duration age = now.difference(birth);
    int years = age.inDays ~/ 365;
    int months = (age.inDays % 365) ~/ 30;
    int days = ((age.inDays % 365) % 30);
    setState(() {
      myAge = '$years years, $months months and $days days';
    });
  }
}
