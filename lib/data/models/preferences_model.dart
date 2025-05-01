class Preference {
  final String title;
  final String icon;
  bool isSelected;

  Preference({
    required this.title,
    required this.icon,
    this.isSelected = false,
  });

  Preference copyWith({bool? isSelected}) {
    return Preference(
      title: title,
      icon: icon,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
