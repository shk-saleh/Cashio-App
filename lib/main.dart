import 'package:cashio/screens/add_transaction_screen.dart';
import 'package:cashio/screens/analytics_screen.dart';
import 'package:cashio/screens/home_screen.dart';
import 'package:cashio/screens/profile_screen.dart';
import 'package:cashio/screens/splash_screen.dart';
import 'package:cashio/screens/transaction_screen.dart';
import 'package:cashio/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './models/transaction.dart';
import './models/user.dart';
import './providers/transaction_provider.dart';
import './providers/profile_provider.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register adapters (custom models)
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(UserProfileAdapter());

  // Open boxes
  await Hive.openBox<Transaction>('transactions');
  await Hive.openBox<UserProfile>('userProfile');

  runApp(const CashioApp());
}

class CashioApp extends StatelessWidget {
  const CashioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cashio',
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: const SplashScreen(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(u
            colors: [
              Color(0xFFFBE5C1),
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: _buildScreen(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const AnalyticsScreen();
      case 2:
        return AddExpenseScreen(
          onAddExpense: (transaction) {
            context.read<TransactionProvider>().addTransaction(transaction);
            setState(() {
              _selectedIndex = 3;
            });
          },
        );
      case 3:
        return const TransactionScreen(
          transactions: [],
        );
      case 4:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }
}