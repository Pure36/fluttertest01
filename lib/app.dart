import 'package:flutter/material.dart';
import 'package:flutterdemo/Provider/counter_provider.dart';
import 'package:flutterdemo/home_page.dart';
import 'package:flutterdemo/Provider/transaction_provider.dart';

import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider()),
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.orange),
        home: const HomeScreen(),
      ),
    );
  }
}
