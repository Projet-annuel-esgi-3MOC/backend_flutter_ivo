import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:backend_flutter_ivo/dal/providers/_crud_provider.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class MultiselectRecipeStep<T extends BO, P extends CrudProvider<T>>
    extends StatefulWidget {
  final List<T> elements;
  final void Function(List<T>) onSave;

  const MultiselectRecipeStep({
    required this.elements,
    required this.onSave,
    Key? key,
  }) : super(key: key);

  @override
  State<MultiselectRecipeStep> createState() =>
      _MultiselectRecipeStepState<T, P>();
}

class _MultiselectRecipeStepState<T extends BO, P extends CrudProvider<T>>
    extends State<MultiselectRecipeStep<T, P>> {
  @override
  Widget build(BuildContext context) {
    Future<List<T>> fetch(BuildContext context) async {
      return await context.watch<P>().getAll();
    }

    return FutureBuilder<List<T>>(
      future: fetch(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Snap Error: ${snapshot.error}'));
        } else {
          //final itemProvider = context.read<MediaCategoryProvider>();
          List<T> itemList = snapshot.data!;

          return MultiSelectDialogField<T>(
            items: itemList
                .map(
                  (item) => MultiSelectItem<T>(
                    item,
                    item.showTitle(),
                  ),
                )
                .toList(),
            initialValue: widget.elements,
            title: const Text("Etapes"),
            selectedColor: Colors.blue,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              border: Border.all(
                color: Colors.blue,
                width: 2,
              ),
            ),
            buttonIcon: const Icon(
              Icons.soup_kitchen,
              color: Colors.blue,
            ),
            buttonText: Text(
              "Etapes",
              style: TextStyle(
                color: Colors.blue[800],
                fontSize: 16,
              ),
            ),
            onConfirm: (results) {
              widget.onSave(results);
            },
            //onSelectionChanged: (p0) => 0,
          );
        }
      },
    );
  }
}
