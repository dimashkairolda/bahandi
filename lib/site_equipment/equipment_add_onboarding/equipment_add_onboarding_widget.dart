import 'package:flutter/material.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/site_equipment/equipment_add_onboarding/equipment_onboarding_prefs.dart';
import '/site_equipment/sites_list/sites_list_widget.dart';
import '/site_equipment/site_equipment_list/site_equipment_list_widget.dart';

class EquipmentAddOnboardingWidget extends StatefulWidget {
  const EquipmentAddOnboardingWidget({
    super.key,
    this.openSitesListAfter = false,
  });

  final bool openSitesListAfter;

  @override
  State<EquipmentAddOnboardingWidget> createState() =>
      _EquipmentAddOnboardingWidgetState();
}

class _EquipmentAddOnboardingWidgetState
    extends State<EquipmentAddOnboardingWidget> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<Widget> _resolveDestination() async {
    try {
      final token = authManager.authenticationToken;
      final objectsRes = await GetObjectCall.call(access: token);
      final objects = GetObjectCall.objects(objectsRes.jsonBody) ?? [];
      final List<Map<String, dynamic>> allAreas = [];
      for (final obj in objects) {
        final objMap = obj as Map<String, dynamic>;
        final objectId = objMap['id'] as int?;
        final objectTitle = (objMap['title'] ?? '').toString().trim();
        if (objectId == null) continue;
        final childRes = await GetObjectChildCall.call(
          objectId: objectId,
          access: token,
        );
        final areas = GetObjectChildCall.areas(childRes.jsonBody) ?? [];
        for (final a in areas) {
          final areaMap = Map<String, dynamic>.from(a as Map<String, dynamic>);
          areaMap['object_title'] = objectTitle;
          allAreas.add(areaMap);
        }
      }
      if (allAreas.length == 1) {
        final area = allAreas.first;
        return SiteEquipmentListWidget(
          areaId: area['id'] as int?,
          areaTitle: (area['title'] ?? '').toString(),
          objectTitle: (area['object_title'] ?? '').toString(),
        );
      }
    } catch (_) {}
    return const SitesListWidget();
  }

  Future<void> _finishOnboarding() async {
    await EquipmentOnboardingPrefs.setCompleted();
    if (!mounted) return;
    if (widget.openSitesListAfter) {
      final dest = await _resolveDestination();
      if (!mounted) return;
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => dest),
      );
      return;
    }
    context.safePop();
  }

  Future<void> _skipOnboarding() async {
    await EquipmentOnboardingPrefs.setCompleted();
    if (!mounted) return;
    if (widget.openSitesListAfter) {
      final dest = await _resolveDestination();
      if (!mounted) return;
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => dest),
      );
      return;
    }
    context.safePop();
  }

  Future<void> _goNext() async {
    if (_currentPage == _slides.length - 1) {
      await _finishOnboarding();
      return;
    }
    await _pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  List<_OnboardingSlideData> get _slides => [
        _OnboardingSlideData(
          title: FFLocalizations.of(context).getVariableText(
            ruText: 'Добавление оборудования',
            kkText: 'Жабдық қосу',
          ),
          body: FFLocalizations.of(context).getVariableText(
            ruText:
                'Чтобы добавить оборудование, вам понадобятся фирменные штрихкоды Etry.\n\n'
                'Проверьте, чтобы все коды относились к одной точке.\n'
                'Пример:\n'
                '• Точка на Абая -> bhndi-60001, bhndi-60002, bhndi-60003 и т.д.\n'
                '• Точка на Сейфуллина -> bhndi-70001, bhndi-70002, bhndi-70003 и т.д.\n\n'
                'НЕЛЬЗЯ путать коды между точками.\n'
                'Коды от Абая нельзя клеить на Сейфуллина.',
            kkText:
                'Жабдықты қосу үшін сізге Etry фирмалық штрихкодтары қажет.\n\n'
                'Барлық кодтардың бір нүктеге тиесілі екенін тексеріңіз.\n'
                'Мысал:\n'
                '• Абайдағы нүкте -> bhndi-60001, bhndi-60002, bhndi-60003 және т.б.\n'
                '• Сейфуллиндегі нүкте -> bhndi-70001, bhndi-70002, bhndi-70003 және т.б.\n\n'
                'Кодтарды нүктелер арасында шатастыруға БОЛМАЙДЫ.\n'
                'Абайдағы кодтарды Сейфуллинге жапсыруға болмайды.',
          ),
          icon: Icons.qr_code_rounded,
        ),
        _OnboardingSlideData(
          title: FFLocalizations.of(context).getVariableText(
            ruText: 'Выберите правильный тип штрихкода',
            kkText: 'Штрихкодтың дұрыс түрін таңдаңыз',
          ),
          body: FFLocalizations.of(context).getVariableText(
            ruText:
                'Штрихкоды бывают двух типов: Железные и Обычные.\n\n'
                'На плиты и фритюрницы клеятся ЖЕЛЕЗНЫЕ наклейки.\n'
                'Перед наклейкой:\n'
                '1. Протереть поверхность.\n'
                '2. Обезжирить.\n'
                '3. Дать высохнуть.\n'
                '4. Только потом клеить.',
            kkText:
                'Штрихкодтар екі түрлі болады: Темір және Қарапайым.\n\n'
                'Плиталар мен фритюрницаларға ТЕМІР жапсырмалар жапсырылады.\n'
                'Жапсырмас бұрын:\n'
                '1. Бетін сүртіңіз.\n'
                '2. Майсыздандырыңыз.\n'
                '3. Кептіріңіз.\n'
                '4. Тек содан кейін жапсырыңыз.',
          ),
          imageAsset: 'assets/images/onboarding/sticker_iron.png',
        ),
        _OnboardingSlideData(
          title: FFLocalizations.of(context).getVariableText(
            ruText: 'Клейте штрихкоды в правильном порядке',
            kkText: 'Штрихкодтарды дұрыс ретпен жабыстырыңыз',
          ),
          body: FFLocalizations.of(context).getVariableText(
            ruText:
                '1. Начинаем с первого номера.\n'
                '2. Клеим на первое оборудование.\n'
                '3. Потом второй номер — на следующее оборудование.\n'
                '4. И так далее.\n\n'
                'Пример правильного порядка:\n'
                '• bhndi-60001\n'
                '• bhndi-60002\n'
                '• bhndi-60003',
            kkText:
                '1. Бірінші нөмірден бастаңыз.\n'
                '2. Оны бірінші жабдыққа жапсырыңыз.\n'
                '3. Содан кейін екінші нөмірді келесі жабдыққа жапсырыңыз.\n'
                '4. Осылай жалғастырыңыз.\n\n'
                'Дұрыс реттің мысалы:\n'
                '• bhndi-60001\n'
                '• bhndi-60002\n'
                '• bhndi-60003',
          ),
          icon: Icons.format_list_numbered_rounded,
        ),
        _OnboardingSlideData(
          title: FFLocalizations.of(context).getVariableText(
            ruText: 'Правильно наклейте штрихкод',
            kkText: 'Штрихкодты дұрыс жабыстырыңыз',
          ),
          body: FFLocalizations.of(context).getVariableText(
            ruText:
                'Куда клеить НЕЛЬЗЯ:\n'
                '• НЕЛЬЗЯ клеить на экран телевизора\n'
                '• НЕЛЬЗЯ клеить на экран моноблока\n'
                '• НЕЛЬЗЯ клеить на кнопки\n'
                '• НЕЛЬЗЯ клеить на рабочую поверхность\n'
                '• НЕЛЬЗЯ клеить там, где мешает персоналу\n\n'
                'Штрих-код должен быть:\n'
                '• Наклеен ровно\n'
                '• Без пузырей\n'
                '• Без загнутых краев\n'
                '• На нерабочей части оборудования\n'
                '• В месте, где не мешает персоналу\n'
                '• Не бросается в глаза гостям',
            kkText:
                'Жапсыруға БОЛМАЙТЫН жерлер:\n'
                '• Теледидар экранына жапсыруға болмайды\n'
                '• Моноблок экранына жапсыруға болмайды\n'
                '• Батырмаларға жапсыруға болмайды\n'
                '• Жұмыс бетіне жапсыруға болмайды\n'
                '• Қызметкерлерге кедергі келтіретін жерге жапсыруға болмайды\n\n'
                'Штрихкод мынадай болуы керек:\n'
                '• Түзу жапсырылған\n'
                '• Көпіршіксіз\n'
                '• Қайырылған шеттерсіз\n'
                '• Жабдықтың жұмыс істемейтін бөлігінде\n'
                '• Қызметкерлерге кедергі келтірмейтін жерде\n'
                '• Қонақтардың көзіне түспейтін жерде',
          ),
          extraContentBuilder: (context) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                FFLocalizations.of(context).getVariableText(
                  ruText: 'Клеить нельзя:',
                  kkText: 'Жапсыруға болмайды:',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'SFProText',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.0,
                    ),
              ),
              const SizedBox(height: 8.0),
              const _OnboardingImageCard(
                assetPath: 'assets/images/onboarding/placement_wrong.png',
              ),
              const SizedBox(height: 16.0),
              Text(
                FFLocalizations.of(context).getVariableText(
                  ruText: 'Как правильно:',
                  kkText: 'Дұрысы қалай:',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'SFProText',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.0,
                    ),
              ),
              const SizedBox(height: 8.0),
              const _OnboardingImageCard(
                assetPath: 'assets/images/onboarding/placement_correct.png',
              ),
            ],
          ),
        ),
        _OnboardingSlideData(
          title: FFLocalizations.of(context).getVariableText(
            ruText: 'После добавления',
            kkText: 'Қосқаннан кейін',
          ),
          body: FFLocalizations.of(context).getVariableText(
            ruText:
                'После добавления вы сможете:\n\n'
                '— отредактировать оборудование\n'
                '— или архивировать его\n\n'
                'Все добавленные данные отправляются на проверку администратору.',
            kkText:
                'Қосқаннан кейін сіз:\n\n'
                '— жабдықты өңдей аласыз\n'
                '— немесе архивке жібере аласыз\n\n'
                'Барлық қосылған деректер әкімшіге тексеруге жіберіледі.',
          ),
          icon: Icons.fact_check_outlined,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Scaffold(
      backgroundColor: theme.primaryBackground,
      appBar: AppBar(
        backgroundColor: theme.secondaryBackground,
        leading: IconButton(
          onPressed: () => context.safePop(),
          icon: const Icon(Icons.close_rounded),
        ),
        title: Text(
          FFLocalizations.of(context).getVariableText(
            ruText: 'Инструкция',
            kkText: 'Нұсқаулық',
          ),
          style: theme.bodyMedium.override(
            fontFamily: 'SFProText',
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.0,
          ),
        ),
        centerTitle: false,
        elevation: 0.0,
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.secondaryBackground,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (slide.icon != null)
                              Container(
                                width: 56.0,
                                height: 56.0,
                                decoration: BoxDecoration(
                                  color: theme.primary.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Icon(
                                  slide.icon,
                                  color: theme.primary,
                                  size: 30.0,
                                ),
                              ),
                            if (slide.icon != null) const SizedBox(height: 16.0),
                            Text(
                              slide.title,
                              style: theme.headlineSmall.override(
                                fontFamily: 'SFProText',
                                fontSize: 22.0,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.0,
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            Text(
                              slide.body,
                              style: theme.bodyMedium
                                  .override(
                                    fontFamily: 'SFProText',
                                    letterSpacing: 0.0,
                                  )
                                  .copyWith(height: 1.45),
                            ),
                            if (slide.imageAsset != null) const SizedBox(height: 16.0),
                            if (slide.imageAsset != null)
                              _OnboardingImageCard(assetPath: slide.imageAsset!),
                            if (slide.extraContentBuilder != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: slide.extraContentBuilder!(context),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _slides.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: _currentPage == index ? 22.0 : 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? theme.primary
                          : theme.secondaryText.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(999.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          await _pageController.previousPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text(
                          FFLocalizations.of(context).getVariableText(
                            ruText: 'Назад',
                            kkText: 'Артқа',
                          ),
                        ),
                      ),
                    ),
                  if (_currentPage > 0) const SizedBox(width: 12.0),
                  Expanded(
                    child: TextButton(
                      onPressed: _skipOnboarding,
                      child: Text(
                        FFLocalizations.of(context).getVariableText(
                          ruText: 'Пропустить',
                          kkText: 'Өткізіп жіберу',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _goNext,
                      child: Text(
                        FFLocalizations.of(context).getVariableText(
                          ruText: _currentPage == _slides.length - 1
                              ? 'Начать'
                              : 'Далее',
                          kkText: _currentPage == _slides.length - 1
                              ? 'Бастау'
                              : 'Келесі',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingSlideData {
  const _OnboardingSlideData({
    required this.title,
    required this.body,
    this.icon,
    this.imageAsset,
    this.extraContentBuilder,
  });

  final String title;
  final String body;
  final IconData? icon;
  final String? imageAsset;
  final WidgetBuilder? extraContentBuilder;
}

class _OnboardingImageCard extends StatelessWidget {
  const _OnboardingImageCard({
    required this.assetPath,
  });

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Image.asset(
        assetPath,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          height: 180.0,
          color: FlutterFlowTheme.of(context).primaryBackground,
          alignment: Alignment.center,
          child: Icon(
            Icons.broken_image_outlined,
            color: FlutterFlowTheme.of(context).secondaryText,
            size: 36.0,
          ),
        ),
      ),
    );
  }
}
