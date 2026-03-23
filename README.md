# Campus Food Finder & Budget Tracker

##  Project Description
This mobile application helps students find food spots, track expenses, and manage their food budget efficiently. The app works fully offline using SQLite and SharedPreferences.

##  Developer
Jeremy Henry

##  Features
- Add and view food spots
- Favorite restaurants
- Food detail view
- Expense tracking system
- Budget management
- Category-based spending analytics
- Search and filter restaurants
- Local recommendation system
- Biometric authentication (fingerprint/face)
- Dark mode support
- Data visualization (pie chart)

##  Technologies Used
- Flutter (latest stable)
- Dart
- sqflite (SQLite)
- shared_preferences
- fl_chart
- local_auth

##  Installation
1. Clone repository
2. Run `flutter pub get`
3. Run `flutter run`

##  Usage
- Add restaurants using "+" button
- Track expenses in Budget section
- View analytics and charts
- Use search/filter in food list
- Toggle dark mode from home screen

##  Database Schema

### Restaurants
- id
- name
- cuisine
- price_range
- is_favorite

### Expenses
- id
- title
- amount
- category
- date

### Reviews
- id
- restaurant_id
- rating
- comment

##  Known Issues
- Biometric may not work on unsupported emulator
- Charts require existing expense data

##  Future Improvements
- Export data (CSV/JSON)
- Notifications
- Image upload for food spots

##  License
MIT License