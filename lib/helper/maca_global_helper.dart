booleanConverter(dynamic value) {
  if (value == true) {
    return 1;
  } else {
    return 0;
  }
}

firstAlphabetExtractAndCapitalize(String value) {
  return value[0].toUpperCase();
}

mealOffBooleanConverter(dynamic value) {
  if (value == true) {
    return "N0";
  } else {
    return "D0";
  }
}
