# Campus Food Finder & Budget Bites

##  Project Description
This mobile app helps students find affordable food spots and track their food spending using local storage.

##  Team Members
Jeremy Henry – UI, Database, Testing, Documentation

##  Features
- Add and view food spots
- Favorite restaurants
- Budget tracking
- Expense tracking (CRUD)
- Category-based spending analytics
- Smart recommendation system
- Splash screen & navigation
- Data visualization (chart) [if added]

##  Technologies
- Flutter (latest stable)
- Dart
- SQLite (sqflite)
- SharedPreferences
- charts_flutter (if used)

##  Installation
1. Clone repo
2. Run `flutter pub get`
3. Run `flutter run`

##  How to Use
- Add restaurants via "+" button
- Track expenses in budget section
- View recommendations based on favorites
- Monitor spending categories

## Database Schema
Tables:
- restaurants(id, name, cuisine, price_range, is_favorite)
- expenses(id, title, amount, category, date)

## Known Issues
- No cloud sync (offline only)
- Basic UI styling

## Future Improvements
- Search/filter
- Notifications
- Better AI recommendations
- Dark mode

## License
MIT