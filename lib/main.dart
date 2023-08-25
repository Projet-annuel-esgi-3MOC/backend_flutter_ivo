import 'package:backend_flutter_ivo/dal/providers/ingredient_provider.dart';
import 'package:backend_flutter_ivo/dal/providers/media_category_provider.dart';
import 'package:backend_flutter_ivo/dal/providers/media_provider.dart';
import 'package:backend_flutter_ivo/dal/providers/recipe_ingredient_provider.dart';
import 'package:backend_flutter_ivo/dal/providers/recipe_provider.dart';
import 'package:backend_flutter_ivo/firebase_options.dart';
import 'package:backend_flutter_ivo/screens/_scaffold.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // a priori ne fonctionne pas dans la version web
  // rajoute enormement de bruit dans les stack trace
  /*try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack);
      return true;
    };
  } catch (error) {
    // une fois sur 10, demarrer crashlitics cause un crash
    // et un ecran blanc au demarrage
    debugPrint('Failed to init firebase : $error');
  }*/

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: ((context) => MediaCategoryProvider()),
      ),
      ChangeNotifierProvider(
        create: ((context) => MediaProvider()),
      ),
      ChangeNotifierProvider(
        create: ((context) => IngredientProvider()),
      ),
      ChangeNotifierProvider(
        create: ((context) => RecipeIngredientProvider()),
      ),
      ChangeNotifierProvider(
        create: ((context) => RecipeProvider()),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
