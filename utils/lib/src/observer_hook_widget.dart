// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

abstract class StatelessObserverHookWidget extends StatelessWidget with ObserverWidgetMixin {
  const StatelessObserverHookWidget({
    Key? key,
    ReactiveContext? context,
    String? name,
  })  : _name = name,
        _context = context,
        super(key: key);

  final String? _name;
  final ReactiveContext? _context;

  @override
  String getName() => _name ?? '$this';

  @override
  ReactiveContext getContext() => _context ?? super.getContext();

  @override
  _StatelessObserverHookElement createElement() => _StatelessObserverHookElement(this);
}

abstract class StatefulObserverHookWidget extends StatefulWidget with ObserverWidgetMixin {
  const StatefulObserverHookWidget({
    Key? key,
    ReactiveContext? context,
    String? name,
  })  : _name = name,
        _context = context,
        super(key: key);

  final String? _name;
  final ReactiveContext? _context;

  @override
  String getName() => _name ?? '$this';

  @override
  ReactiveContext getContext() => _context ?? super.getContext();

  @override
  _StatefulObserverHookElement createElement() => _StatefulObserverHookElement(this);
}

class _StatefulObserverHookElement extends StatefulElement with HookElement, ObserverElementMixin {
  _StatefulObserverHookElement(StatefulObserverHookWidget widget) : super(widget);
}

class _StatelessObserverHookElement extends StatelessElement with HookElement, ObserverElementMixin {
  _StatelessObserverHookElement(StatelessObserverHookWidget widget) : super(widget);
}

class ObserverHookBuilder extends StatelessObserverHookWidget {
  ObserverHookBuilder({
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  final Widget Function(BuildContext context, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) => builder(context, child);
}
