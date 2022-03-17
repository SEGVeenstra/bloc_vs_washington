import 'package:flutter/material.dart';

class NamesPage extends StatelessWidget {
  final List<String> names;
  final void Function(BuildContext context)? onGenerateNamePressed;
  final void Function(String name, BuildContext context)? onRemoveNamePressed;

  const NamesPage({
    required this.names,
    this.onGenerateNamePressed,
    this.onRemoveNamePressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Names'),
      ),
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(names[index]),
          trailing: onRemoveNamePressed == null
              ? null
              : IconButton(
                  onPressed: () => onRemoveNamePressed!.call(names[index], context),
                  icon: const Icon(Icons.delete),
                ),
        ),
      ),
      floatingActionButton: onGenerateNamePressed == null
          ? null
          : FloatingActionButton(
              onPressed: () => onGenerateNamePressed!.call(context),
              child: const Icon(Icons.add),
            ),
    );
  }
}
