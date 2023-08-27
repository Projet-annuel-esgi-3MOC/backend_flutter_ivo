import 'package:backend_flutter_ivo/bo/recipe.dart';
import 'package:backend_flutter_ivo/dal/providers/recipe_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeDropDown extends StatefulWidget {
  final void Function(Recipe) setRecipe;
  final Recipe Function() getInitialRecipe;

  const RecipeDropDown({
    required this.setRecipe,
    required this.getInitialRecipe,
    Key? key,
  }) : super(key: key);

  @override
  State<RecipeDropDown> createState() => _RecipeDropDownState();
}

class _RecipeDropDownState extends State<RecipeDropDown> {
  Future<List<Recipe>> fetchRecipes(BuildContext context) async {
    RecipeProvider recipeProvider = context.watch<RecipeProvider>();

    return await recipeProvider.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Recipe>>(
      future: fetchRecipes(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Snap Error: ${snapshot.error}'));
        } else {
          //final itemProvider = context.read<MediaCategoryProvider>();
          List<Recipe> itemList = snapshot.data!;

          return DropdownMenu<Recipe>(
            width: 250,
            initialSelection: itemList
                .where((element) => element.id == widget.getInitialRecipe().id)
                .firstOrNull,
            onSelected: (newValue) {
              widget.setRecipe(newValue!);
            },
            dropdownMenuEntries: itemList.map((item) {
              return DropdownMenuEntry<Recipe>(
                value: item,
                label: item.name,
                leadingIcon: Image.network(
                  item.image.accessUrl,
                  height: 50,
                  width: 50,
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}
