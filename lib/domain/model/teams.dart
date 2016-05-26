const Baystars baystars = const Baystars();
const Buffaloes buffaloes = const Buffaloes();
const Carp carp = const Carp();
const Dragons dragons = const Dragons();
const Eagles eagles = const Eagles();
const Fighters fighters = const Fighters();
const Giants giants = const Giants();
const Hawks hawks = const Hawks();
const Lions lions = const Lions();
const Marines marines = const Marines();
const Swallows swallows = const Swallows();
const Tigers tigers = const Tigers();

abstract class Team {
  String get id;

  String get name;

  String get color;
}

class Baystars implements Team {
  final String id = 'baystars';
  final String name = 'ＤｅＮＡ';
  final String color = '#3F51B5';

  const Baystars();
}

class Buffaloes implements Team {
  final String id = 'buffaloes';
  final String name = 'オリックス';
  final String color = '#795548';

  const Buffaloes();
}

class Carp implements Team {
  final String id = 'carp';
  final String name = '広島';
  final String color = '#F44336';

  const Carp();
}

class Dragons implements Team {
  final String id = 'dragons';
  final String name = '中日';
  final String color = '#2196F3';

  const Dragons();
}

class Eagles implements Team {
  final String id = 'eagles';
  final String name = '楽天';
  final String color = '#B71C1C';

  const Eagles();
}

class Fighters implements Team {
  final String id = 'fighters';
  final String name = '日本ハム';
  final String color = '#CDDC39';

  const Fighters();
}

class Giants implements Team {
  final String id = 'giants';
  final String name = '巨人';
  final String color = '#FF9800';

  const Giants();
}

class Hawks implements Team {
  final String id = 'hawks';
  final String name = 'ソフトバンク';
  final String color = '#FFC107';

  const Hawks();
}

class Lions implements Team {
  final String id = 'lions';
  final String name = '西武';
  final String color = '#03A9F4';

  const Lions();
}

class Marines implements Team {
  final String id = 'marines';
  final String name = 'ロッテ';
  final String color = '#9E9E9E';

  const Marines();
}

class Swallows implements Team {
  final String id = 'swallows';
  final String name = 'ヤクルト';
  final String color = '#607D8B';

  const Swallows();
}

class Tigers implements Team {
  final String id = 'tigers';
  final String name = '阪神';
  final String color = '#FFEB3B';

  const Tigers();
}
