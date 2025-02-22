import 'package:binko/core/constants/assets.dart';
import 'package:binko/features/home/presentation/widgets/book_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(Assets.assetsImgsLogo),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.6,
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemBuilder: (context, index) {
          return BookWidget();
        },
      ),
    );
  }
}
