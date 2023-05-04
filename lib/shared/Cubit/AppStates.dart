
import 'package:inkaz/shared/Cubit/AppStates.dart';

abstract class AppStates {}
class AppInitialStates extends AppStates{}
class AppChangeNavBar extends AppStates{}
class AppCreateDatabase extends AppStates{}
class AppInsertDatabase extends AppStates{}
class AppGetDatabase extends AppStates{}
class AppUpdateDatabase extends AppStates{}
class AppDeleteDatabase extends AppStates{}
class AppGetLoadingDatabase extends AppStates{}
class AppChangeBottomSheet extends AppStates{}
