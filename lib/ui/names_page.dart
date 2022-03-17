import 'package:flutter/material.dart';

class NamesPage extends StatelessWidget {
  final List<String> names;
  final void Function(BuildContext context)? onGenerateNamePressed;
  final void Function(String name, BuildContext context)? onRemoveNamePressed;
  final bool isLoading;

  const NamesPage({
    required this.names,
    this.onGenerateNamePressed,
    this.onRemoveNamePressed,
    this.isLoading = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Names'),
      ),
      body: Column(
        children: [
          if (isLoading)
            const LinearProgressIndicator(
              minHeight: 4,
            ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: isLoading ? 0 : 4),
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
          ),
        ],
      ),
      floatingActionButton: onGenerateNamePressed == null
          ? null
          : FloatingActionButton(
              onPressed: isLoading ? null : () => onGenerateNamePressed!.call(context),
              child: const Icon(Icons.add),
              disabledElevation: 0,
              backgroundColor: isLoading ? Colors.blue.shade800 : null,
            ),
    );
  }
}
