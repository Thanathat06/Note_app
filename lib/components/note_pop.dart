import 'package:flutter/material.dart';

class NotePop extends StatelessWidget {
  final Function()? onEditTap;
  final Function()? onDelTap;

  const NotePop({
    super.key,
    required this.onEditTap,
    required this.onDelTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 120, // ปรับความกว้างของกล่องให้ใหญ่ขึ้น
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, // จัดข้อความให้อยู่ทางซ้าย
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                if (onEditTap != null) onEditTap!();
              },
              child: Row(
                children: [
                  Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    "Edit",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1, height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                if (onDelTap != null) onDelTap!();
              },
              child: Row(
                children: [
                  Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                  const SizedBox(width: 8),
                  Text(
                    "Delete",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
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
