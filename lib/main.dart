
import 'package:customers_collector_feedback/features/event_management/presentation/cubit/event_cubit.dart';
import 'package:customers_collector_feedback/features/event_management/presentation/view_all_events_page.dart';
import 'package:customers_collector_feedback/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/services/injection_container.dart';
import 'features/feedback_management/presentation/cubit/feedback_form_cubit.dart';
import 'features/feedback_management/presentation/view_all_feedback_forms_page.dart';
import 'firebase_options.dart';
import 'profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, 
  );
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customers Collector Feedback',
      themeMode: ThemeMode.light,
      theme: GlobalThemeData.lightThemeData,
      home: const MyHomePage(title: 'Customers Collector Feedback'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          BlocProvider(
            create: (context) => serviceLocator<EventCubit>(),
            child: const ViewAllEventsPage(),
          ),
          BlocProvider(
            create: (context) => serviceLocator<FeedbackFormCubit>(),
            child: const ViewAllFeedbackFormsPage(feedbackForms: [],),
          ),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.celebration), label: "Events"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "FeedbackForms"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      
    );
  }
}