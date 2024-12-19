import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/custom_animated_icon.dart';
import '../../../logic/notes/notes_cubit.dart';
import 'recent_search_section.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection>
    with SingleTickerProviderStateMixin {
  bool isSearchExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !isSearchExpanded
          ? () {
              toggleSearch();
            }
          : null,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24),
                bottom: Radius.circular(24),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CustomAnimatedIcon(
                      fromIcon: Icons.search,
                      toIcon: Icons.arrow_back,
                      animation: _animation,
                      color: Colors.grey,
                      onTap: isSearchExpanded ? toggleSearch : null,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _searchController,
                        enabled: isSearchExpanded,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          hintText: 'Search Notes',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    CustomAnimatedIcon(
                      fromIcon: Icons.person,
                      toIcon: Icons.close,
                      animation: _animation,
                      color: Colors.grey,
                      onTap: isSearchExpanded
                          ? () {
                              _searchController.clear();
                            }
                          : null,
                    ),
                  ],
                ),
                if (isSearchExpanded)
                  RecentSearchSection(
                    animation: _animation,
                    onTap: (query) {
                      _searchController.text = query;
                      BlocProvider.of<NotesCubit>(context)
                          .searchNotes(query: query);
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void initAnimation() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        setState(() => isSearchExpanded = true);
      } else if (status == AnimationStatus.dismissed) {
        setState(() => isSearchExpanded = false);
      }
    });

    _searchController.addListener(() {
      BlocProvider.of<NotesCubit>(context)
          .searchNotes(query: _searchController.text);
    });
  }

  void toggleSearch() {
    setState(() {
      if (!isSearchExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
        _searchController.clear();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}