import 'package:npb_polls/domain/model/teams.dart';

const Unselected unselected = const Unselected();

class Unselected implements Team {
  final String id = 'unselected';
  final String name = '未選択';
  final String color = '#FFFFFF';

  const Unselected();
}
