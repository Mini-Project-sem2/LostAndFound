List<String> getsubcategory(String categoryValue) {
  List<String> electronicItems = [
    'Laptop',
    'mobile',
    'charger',
    'earphones',
    'watch',
    'tablets',
    'other'
  ];
  List<String> dailyAccessories = [
    'wearables',
    'umbrella',
    'wallet',
    'keys',
    'other'
  ];
  List<String> govIds = [
    'Driving License',
    'Passport',
    'Voter ID',
    'adhaar',
    'academic',
    'pan card',
    'other'
  ];

  if (categoryValue == 'Electronic items') {
    return electronicItems;
  } else if (categoryValue == 'Daily Accessories') {
    return dailyAccessories;
  } else if (categoryValue == 'government ids & certificate') {
    return govIds;
  } else {
    return ['cat', 'dog', 'other'].toList();
  }
}
