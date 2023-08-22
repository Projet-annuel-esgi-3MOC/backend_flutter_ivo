import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:backend_flutter_ivo/bo/_i_firebaseable.dart';
import 'package:backend_flutter_ivo/dal/_abst_dao.dart';
import 'package:backend_flutter_ivo/dal/media_category_access.dart';
import 'package:backend_flutter_ivo/dal/providers/_i_provider.dart';
import 'package:backend_flutter_ivo/screens/crud/edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Crud<T extends BO, U extends Iprovider> extends StatefulWidget {
  final T Function() newInstanceBuilder;
  final Widget editWidget;
  final DAO<T> accessor;

  const Crud({
    Key? key,
    required this.newInstanceBuilder,
    required this.editWidget,
    required this.accessor,
  }) : super(key: key);

  @override
  State<Crud> createState() => _CrudState<T, U>();
}

class _CrudState<T extends BO, U extends Iprovider> extends State<Crud> {
  @override
  void initState() {
    super.initState();
  }

  void _showModal(BuildContext context, BO object,
      Future<void> Function(BO) onSubmitCallback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit'),
          content: widget.editWidget,
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the modal
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final newItem = widget.newInstanceBuilder();

    return Stack(
      children: [
        Positioned.fill(child: _buildItemList(context)),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () => _showModal(
              context,
              newItem,
              (BO newItem) async => await context.read<U>().add(newItem),
            ),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  _editItem(BO item) {
    _showModal(
      context,
      item,
      (BO newItem) async => await context.read<U>().update(item),
    );
  }

  _deleteItem(BO item) async {
    await context.read<U>().remove(item);
  }

  Widget _buildItemList(BuildContext context) {
    final itemsProvider = context.watch<U>();

    return FutureBuilder<List<BO>>(
      future: widget.accessor.getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Snap Error: ${snapshot.error}'));
        } else {
          //final itemProvider = context.read<MediaCategoryProvider>();
          itemsProvider.updateItems(snapshot.data!);
          List<BO> itemList = snapshot.data!;

          return ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              BO item = itemList[index];
              return ListTile(
                title: Text(item.showTitle()),
                subtitle: Text(item.showSubtitle()),
                onTap: () => _editItem(item),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
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
