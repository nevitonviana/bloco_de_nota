enum TaskFilterEnum {
  today,
  tomorrow,
  week;
}

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
