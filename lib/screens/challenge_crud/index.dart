import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:backend_flutter_ivo/bo/challenge.dart';
import 'package:backend_flutter_ivo/dal/providers/challenge_provider.dart';
import 'package:backend_flutter_ivo/screens/_fab_action.dart';
import 'package:backend_flutter_ivo/screens/challenge_crud/edit.dart';
import 'package:backend_flutter_ivo/screens/crud/index.dart';
import 'package:flutter/material.dart';

class ChallengeCrud extends StatelessWidget {
  final Function(FABAction) setFAB;
  const ChallengeCrud({required this.setFAB, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Crud<Challenge, ChallengeProvider>(
      newInstanceBuilder: () => Challenge.placeholder(),
      editWidget: (BO challenge) => ChallengeEditWidget(
        object: challenge as Challenge,
      ),
      setFAB: setFAB,
    );
  }
}
