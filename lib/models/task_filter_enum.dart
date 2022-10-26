enum TaskFilterEnum {
  today(descriptions: 'De HOJE'),
  tomorrow(descriptions: 'De AMANHÂ'),
  week(descriptions: 'Da SEMANA');

  const TaskFilterEnum({required this.descriptions});

  final String descriptions;
}
//dois jeitos de ser usar um Enum para passar paramentro


extension TaskFilterDescription on TaskFilterEnum {
  String get description {
    switch (this) {
      case TaskFilterEnum.today:
        return 'De HOJE';
      case TaskFilterEnum.tomorrow:
        return 'De AMANHÂ';
      case TaskFilterEnum.week:
        return 'Da SEMANA';
    }
  }
}
