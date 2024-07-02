import 'package:flutter/material.dart';

class ReusableListView<Item> extends StatefulWidget {
  const ReusableListView({
    super.key,
    required this.items,
    required this.itemView,
  });

  final List<Item> items;
  final Widget Function(BuildContext context, Item item) itemView;

  @override
  State<ReusableListView> createState() => _ReusableListViewState();
}

class _ReusableListViewState extends State<ReusableListView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
