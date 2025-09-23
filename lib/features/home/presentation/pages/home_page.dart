import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size;
    double height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text('Caching Data with BLOC & HIVE'),
            Text(
              '@ProgramingWithSoulivanh',
              style: theme.textTheme.labelMedium!.copyWith(color: Colors.grey),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SizedBox(width: width, height: height),
    );
  }
}
