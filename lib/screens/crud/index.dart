import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:backend_flutter_ivo/dal/providers/_crud_provider.dart';
import 'package:backend_flutter_ivo/screens/_fab_action.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Crud<T extends BO, U extends CrudProvider<T>> extends StatefulWidget {
  final BO Function() newInstanceBuilder;
  final Widget Function(T) editWidget;
  final Function(FABAction) setFAB;

  const Crud({
    Key? key,
    required this.newInstanceBuilder,
    required this.editWidget,
    required this.setFAB,
  }) : super(key: key);

  @override
  State<Crud> createState() => _CrudState<T, U>();
}

class _CrudState<T extends BO, U extends CrudProvider<T>> extends State<Crud> {
  Function onCrudSave = () => {throw UnimplementedError('Set a save callback')};

  setOnCrudSaveCallback(Function fun) {
    onCrudSave = fun;
  }

  @override
  void initState() {
    super.initState();

    widget.setFAB(
      FABAction(
        function: openModal,
        parameters: () => [
          widget.newInstanceBuilder(),
        ],
      ),
    );
  }

  void openModal(List<dynamic> newItem) {
    final T newItem_ = newItem.first;

    _showModal(
      context,
      newItem_,
      () async => {await context.read<U>().add(newItem_)},
    );
  }

  void _showModal(BuildContext context, T object, Function onSubmitCallback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit'),
          content: widget.editWidget(object),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () async {
                //await widget.editWidget.onSave(context);
                //Navigator.of(context).pop(); // Close the modal
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildItemList(context);
  }

  _editItem(T item) {
    _showModal(
      context,
      item,
      (T item) async => await context.read<U?>()?.update(item),
    );
  }

  _deleteItem(T item) async {
    await context.read<U?>()?.remove(item);
  }

  Widget _buildItemList(BuildContext context) {
    final itemsProvider = context.watch<U?>();

    return FutureBuilder<List<T>>(
      future: itemsProvider?.getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(snapshot.stackTrace);
          return Center(child: Text('Snap Error: ${snapshot.error}'));
        } else {
          //final itemProvider = context.read<MediaCategoryProvider>();
          itemsProvider?.updateItems(snapshot.data!);
          List<T> itemList = snapshot.data ?? [];

          return ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              var item = itemList[index];
              return ListTile(
                title: item.tileTitle(),
                subtitle: item.tileSubtitle(),
                onTap: () => _editItem(item),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Perform edit action for the current item
                        _editItem(item);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        // Perform delete action for the current item
                        await _deleteItem(item);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
