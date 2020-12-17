/// Тип валидации множественноо валидатора
enum TextFieldValidationType {
  /// Текст считается валидным если
  /// все валидаторы вернули isValid == true
  and,

  /// Текст считается валидным если хотя бы
  /// один валидатор вернул isValid == true
  or,
}