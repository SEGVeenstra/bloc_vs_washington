import 'package:flutter/material.dart';

class NamesPage extends StatelessWidget {
  final String title;
  final List<String> names;
  final void Function(BuildContext context)? onGenerateNamePressed;
  final void Function(String name, BuildContext context)? onRemoveNamePressed;
  final bool isLoading;
  final Widget? nextPage;

  const NamesPage({
    required this.title,
    required this.names,
    this.onGenerateNamePressed,
    this.onRemoveNamePressed,
    this.nextPage,
    this.isLoading = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          if (nextPage != null)
            IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => nextPage!),
              ),
              icon: const Icon(Icons.delete_sweep),
            )
        ],
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
