import 'package:flutter/material.dart';

class DisposableBuildContextBuilder extends StatefulWidget {
  const DisposableBuildContextBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget Function(
    BuildContext context,
    DisposableBuildContext<_DisposableBuildContextBuilderState> disposableContext,
  ) builder;

  @override
  _DisposableBuildContextBuilderState createState() => _DisposableBuildContextBuilderState();
}

class _DisposableBuildContextBuilderState extends State<DisposableBuildContextBuilder> {
  late final DisposableBuildContext<_DisposableBuildContextBuilderState> _disposableBuildContext;

  @override
  void initState() {
    _disposableBuildContext = DisposableBuildContext<_DisposableBuildContextBuilderState>(this);
    super.initState();
  }

  @override
  void dispose() {
    _disposableBuildContext.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _disposableBuildContext);
}
