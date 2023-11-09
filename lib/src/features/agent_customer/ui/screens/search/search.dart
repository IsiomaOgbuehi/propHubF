import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prophub/src/widgets/scaffold/platform_scaffold.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: (context) => const Center(child: Text("Search Page UI... UI updated in next build"),),
    );
  }
}