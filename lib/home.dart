import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of(context, listen: false);
    provider.second = provider.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Selector<UserProvider, List<UserModel>>(
        selector: (p0, p1) => p1.second,
        builder: (context, value, child) => ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) => Selector<UserProvider, bool>(
            selector: (p0, p1) => p1.second[index].status,
            builder: (context, value, child) => Text("$value"),
          ),
        ),
      ),
    );
  }
}

class UserModel {
  String name;
  bool status;
  UserModel({required this.name, required this.status});
}

class UserProvider extends ChangeNotifier {
  List<UserModel> first = [
    UserModel(name: "A", status: false),
    UserModel(name: "C", status: false),
    UserModel(name: "D", status: false),
  ];

  List<UserModel> second = [];

  toggle(int index) {
    second[index].status = true;
    notifyListeners();
  }
}
