import 'package:flutter/material.dart';

import 'recent_search_item.dart';

class RecentSearchSection extends StatelessWidget {
  const RecentSearchSection({
    super.key,
    required Animation<double> animation,
  }) : _animation = animation;

  final Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: Colors.grey[300]),
                  const Text(
                    'Recent Searches',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return RecentSearchItem(
                        title: 'Recent Search ${index + 1}',
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}