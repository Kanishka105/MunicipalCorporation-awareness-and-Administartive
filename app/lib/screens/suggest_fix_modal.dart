import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/civic_app_state.dart';
import '../theme/app_theme.dart';
import '../models/leaderboard_model.dart';

class SuggestFixModal extends StatefulWidget {
  final String ticketCode;
  final String hazardTitle;

  const SuggestFixModal({
    super.key,
    required this.ticketCode,
    required this.hazardTitle,
  });

  @override
  State<SuggestFixModal> createState() => _SuggestFixModalState();
}

class _SuggestFixModalState extends State<SuggestFixModal> {
  final _suggestionController = TextEditingController();

  @override
  void dispose() {
    _suggestionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CivicAppState>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final suggestions = state.fixSuggestions.where((s) => s.ticketCode == widget.ticketCode).toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.78,
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: CivicColors.mintBadgeBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.lightbulb_outline, color: CivicColors.mintDark, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Suggest a Solution',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                        ),
                      ),
                      Text(
                        'Ticket: ${widget.ticketCode}',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8),

          Text(
            widget.hazardTitle,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white70 : CivicColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 12),

          // Suggestion Input Box
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _suggestionController,
                  style: TextStyle(fontSize: 13, color: isDark ? Colors.white : CivicColors.textPrimaryLight),
                  decoration: InputDecoration(
                    hintText: 'e.g. Install 2 extra bins / widen drainage mesh...',
                    hintStyle: TextStyle(fontSize: 12, color: isDark ? CivicColors.textMutedDark : CivicColors.textMutedLight),
                    filled: true,
                    fillColor: isDark ? CivicColors.cardSurfaceDark : CivicColors.bgLight,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: isDark ? CivicColors.borderDark : CivicColors.borderLight),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CivicColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (_suggestionController.text.trim().isNotEmpty) {
                    state.addFixSuggestion(widget.ticketCode, _suggestionController.text.trim());
                    _suggestionController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: CivicColors.mintDark,
                        content: Text('💡 Solution suggested! +15 Karma Points added.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                child: const Text('Post (+15 KP)', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Text(
            'Community Proposed Solutions (${suggestions.length})',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white70 : CivicColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: suggestions.isEmpty
                ? Center(
                    child: Text(
                      'No suggestions yet. Be the first to propose a civic fix!',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? CivicColors.textMutedDark : CivicColors.textMutedLight,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: suggestions.length,
                    itemBuilder: (ctx, i) {
                      final item = suggestions[i];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDark ? CivicColors.cardSurfaceDark : CivicColors.bgLight,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDark ? CivicColors.borderDark : CivicColors.borderLight,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.suggestionText,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                      color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Proposed by ${item.citizenName} • Verified Citizen',
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => state.toggleUpvoteFix(item.id),
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                decoration: BoxDecoration(
                                  color: item.hasUpvoted ? CivicColors.primary.withOpacity(0.15) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: item.hasUpvoted ? CivicColors.primary : Colors.grey.shade300,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.thumb_up_alt_rounded,
                                      size: 14,
                                      color: item.hasUpvoted ? CivicColors.primary : Colors.grey,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${item.upvotes}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: item.hasUpvoted ? CivicColors.primary : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
