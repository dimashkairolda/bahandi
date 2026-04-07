import 'package:Etry/firebase_options.dart';
import 'package:Etry/inspections/inspections_widget.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'auth/custom_auth/auth_util.dart';
import 'auth/custom_auth/custom_auth_user_provider.dart';
import 'backend/api_requests/api_calls.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'services/app_update_checker.dart';
import 'services/force_update_app.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await FlutterFlowTheme.initialize();
  await FFLocalizations.initialize();

  await authManager.initialize();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppMetrica.activate(const AppMetricaConfig("5ae85786-d02b-482e-a1ea-3edfd65f273e", logs: true));

  final updateCheck = await AppUpdateChecker.evaluate();
  if (updateCheck.mustUpdate) {
    runApp(ForceUpdateApp(storeUrl: updateCheck.storeUrl));
    return;
  }


  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Locale? _locale;

  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  late DateTime _foregroundCheckAllowedAfter;
  DateTime? _lastForegroundUpdateCheckAt;
  static const _coldStartGraceBeforeForegroundCheck = Duration(seconds: 3);
  static const _minIntervalBetweenForegroundChecks = Duration(seconds: 30);
  String getRoute([RouteMatch? routeMatch]) {
    final RouteMatch lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  List<String> getRouteStack() =>
      _router.routerDelegate.currentConfiguration.matches
          .map((e) => getRoute(e))
          .toList();
  late Stream<BahandiAuthUser> userStream;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _foregroundCheckAllowedAfter =
        DateTime.now().add(_coldStartGraceBeforeForegroundCheck);
    _locale = FFLocalizations.getStoredLocale();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = bahandiAuthUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });

    Future.delayed(
      Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkUpdateOnForeground();
    }
  }

  Future<void> _checkUpdateOnForeground() async {
    final now = DateTime.now();
    if (now.isBefore(_foregroundCheckAllowedAfter)) {
      return;
    }
    if (_lastForegroundUpdateCheckAt != null &&
        now.difference(_lastForegroundUpdateCheckAt!) <
            _minIntervalBetweenForegroundChecks) {
      return;
    }
    _lastForegroundUpdateCheckAt = now;

    final updateCheck = await AppUpdateChecker.evaluate();
    if (!mounted) {
      return;
    }
    if (updateCheck.mustUpdate) {
      runApp(ForceUpdateApp(storeUrl: updateCheck.storeUrl));
    }
  }

  void setLocale(String language) {
    FFLocalizations.storeLocale(language);
    safeSetState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Etry',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackMaterialLocalizationDelegate(),
        FallbackCupertinoLocalizationDelegate(),
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('ru'),
        Locale('kk'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({
    Key? key,
    this.initialPage,
    this.page,
    this.disableResizeToAvoidBottomInset = false,
  }) : super(key: key);

  final String? initialPage;
  final Widget? page;
  final bool disableResizeToAvoidBottomInset;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'Defects';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final userRole = valueOrDefault<String>(
      getJsonField(
        FFAppState().account,
        r'''$.role''',
      )?.toString(),
      '',
    );
    final isLabeler = userRole == 'labeler' || userRole == '\"labeler\"';

    final tabs = {
      'Defects': DefectsWidget(),
      if (!isLabeler) 'EquipmentsTree': EquipmentsTreeWidget(),
      'Inspections': InspectionsWidget(),
      'profilePage': ProfilePageWidget(),
    };
    final tabKeys = tabs.keys.toList();
    final resolvedPageName =
        tabKeys.contains(_currentPageName) ? _currentPageName : tabKeys.first;
    final currentIndex = tabKeys.indexOf(resolvedPageName);

    return Scaffold(
      resizeToAvoidBottomInset: !widget.disableResizeToAvoidBottomInset,
      body: _currentPage ?? tabs[resolvedPageName],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) async {
          safeSetState(() {
            _currentPage = null;
            _currentPageName = tabKeys[i];
            MyApp.analytics.logEvent(
              name: tabKeys[i],
            );
            AppMetrica.reportEvent(tabKeys[i]);
          });

          if (tabKeys[i] == 'Defects') {
            await ViewedNotificationCall.call(
              access: currentAuthenticationToken,
            );
          }
        },
        currentIndex: currentIndex,
        
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        selectedItemColor: FlutterFlowTheme.of(context).primary,
        unselectedItemColor: FlutterFlowTheme.of(context).secondaryText,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt_outlined,
            ),
            label: FFLocalizations.of(context).getVariableText(
              ruText: 'Заявки',
              kkText: 'Өтінімдер',
            ),
            tooltip: '',
          ),
          if (!isLabeler)
            BottomNavigationBarItem(
              icon: Icon(
                Icons.kitchen_rounded,
              ),
              label: FFLocalizations.of(context).getVariableText(
                ruText: 'Парк оборудования',
                kkText: 'Жабдықтар паркі',
              ),
              tooltip: '',
            ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.grading,
              size: 24.0,
            ),
            label: FFLocalizations.of(context).getVariableText(
              ruText: 'Регламенты',
              kkText: 'Регламенттер',
            ),
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 24.0,
            ),
            label: FFLocalizations.of(context).getVariableText(
              ruText: 'Профиль',
              kkText: 'Профиль',
            ),
            tooltip: '',
          ),
          
        ],
      ),
    );
  }
}
