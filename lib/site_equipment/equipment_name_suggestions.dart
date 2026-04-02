import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_theme.dart';

/// Список подсказок названий оборудования для автодополнения в формах добавления/редактирования.
const List<String> equipmentNameSuggestions = [
  'Чек лист (Bahandi сауда орындарының ашылуы) Гагарина',
  'Чек лист (Bahandi сауда орындарының жабылуы) Гагарина',
  'Сыртқы көрініс саясаты (Политика внешнего вида)',
  'Дверной звонок',
  'Электрочайник',
  'Стол персонала',
  'Батареи тепла',
  'Жироуловитель',
  'Мойка односекционная',
  'Стеллаж',
  'Микроволновка',
  'Полка для салфеток',
  'Морозильник для запаса фри',
  'морозильник для запаса котлет',
  'Стол нержавейка для напитков',
  'Камеры',
  'Дверь в кухню',
  'Окно выдачи',
  'Трансформатор плиты',
  'Кондиционер Almacom',
  'Кварц лампа',
  'Стол нержавейка',
  'Стол для хранения булок',
  'Фритюр двухсекционный',
  'Термопринтер жарщика',
  'Стол',
  'Кондиционер-Теплоудержатель',
  'Соусницы',
  'Полка для завертышей',
  'Плита для жарки котлет',
  'Плита для карамелизации',
  'Вытяжка 3',
  'Вытяжка 2',
  'Вытяжка 1',
  'Стол холодильник',
  'Полка для пакетов',
  'Моноблок на выдаче',
  'Морозильник Бирюса',
  'Морозильник Atlant',
  'холодильник Atlant',
  'Сигнализация',
  'Кассовый стол',
  'Интеренет',
  'Кондиционер',
  'Счетчик',
  'Щиток электричества',
  'Холодильник Bahandi',
  'Холодильник Coca Cola',
  'Видеорегистратор',
  'Аптечка',
  'Susan Терминал',
  'Kaspi терминал',
  'Термопринтер на кассе',
  'Ящик для денег',
  'Кассовый моноблок',
];

/// Виджет поля названия с автодополнением из списка оборудования.
class EquipmentNameAutocompleteField extends StatelessWidget {
  const EquipmentNameAutocompleteField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.theme,
    this.validator,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final FlutterFlowTheme theme;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<String>(
      focusNode: focusNode,
      textEditingController: controller,
      optionsBuilder: (TextEditingValue value) {
        if (value.text.isEmpty) return const Iterable<String>.empty();
        final query = value.text.toLowerCase().trim();
        return equipmentNameSuggestions.where((String name) {
          return name.toLowerCase().startsWith(query);
        });
      },
      displayStringForOption: (String option) => option,
      fieldViewBuilder: (context, ctrl, fn, onSubmitted) {
        return TextFormField(
          controller: ctrl,
          focusNode: fn,
          onFieldSubmitted: (_) => onSubmitted(),
          validator: validator ??
              (value) {
                if (value == null || value.isEmpty) return 'Заполните поле';
                return null;
              },
          decoration: InputDecoration(
            hintText: 'Например, Стол из нержавейки',
            hintStyle: theme.bodyMedium.override(
              fontFamily: 'SFProText',
              letterSpacing: 0.0,
              color: theme.secondaryText,
            ),
            filled: true,
            fillColor: theme.secondaryBackground,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 14.0,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: theme.alternate),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: theme.primary, width: 2.0),
            ),
          ),
          style: theme.bodyMedium.override(
            fontFamily: 'SFProText',
            letterSpacing: 0.0,
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(12.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options.elementAt(index);
                  return InkWell(
                    onTap: () => onSelected(option),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      child: Text(
                        option,
                        style: theme.bodyMedium.override(
                          fontFamily: 'SFProText',
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
