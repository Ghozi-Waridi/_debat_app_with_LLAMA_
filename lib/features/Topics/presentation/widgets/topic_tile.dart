import 'package:debate_app/core/theme/color.dart';
import 'package:debate_app/features/Debate/presentation/bloc/debate_bloc.dart';
import 'package:debate_app/features/Debate/presentation/pages/chat_page.dart';
import 'package:debate_app/features/Topics/domain/entities/topic_entity.dart';
import 'package:debate_app/features/Topics/presentation/widgets/card_role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopicTile extends StatelessWidget {
  final TopicEntity topic;

  const TopicTile({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () => _showRoleSelectionDialog(context),
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            color: AppColor.accent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.accent),
            boxShadow: [
              BoxShadow(
                blurRadius: 12,
                offset: const Offset(0, 4),
                color: AppColor.background.withOpacity(0.08),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColor.purpleLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.forum_outlined,
                    size: 22,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topic.topic,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.white70),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showRoleSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColor.accent,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Pilih Sisi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CardRole(
                        icon: Icons.thumb_up,
                        onTap: () => _onPick(context, "Pro"),
                        iconColor: Colors.greenAccent,
                        role: "Pro",
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CardRole(
                        icon: Icons.thumb_down,
                        onTap: () => _onPick(context, "Kontra"),
                        iconColor: Colors.redAccent,
                        role: "Kontra",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      "Batal",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onPick(BuildContext context, String pihak) {
    Navigator.pop(context);
    _createSession(context, pihak);
  }

  void _createSession(BuildContext context, String pihak) {
    final String defaultPrompt =
        pihak == 'Pro'
            ? 'Saya setuju dengan topik "${topic.topic}" '
            : 'Saya tidak setuju dengan topik "${topic.topic}" ';

    context.read<DebateBloc>().add(
      CreateSessionEvent(
        prompt: defaultPrompt,
        topic: topic.topic,
        role: pihak,
      ),
    );
    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(topic: topic.topic, role: pihak),
      ),
    );
  }
}
