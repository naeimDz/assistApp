import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_defaults.dart';
import '../../utils/constants/sizedbox_const.dart';

class SegmentedOptions extends StatefulWidget {
  final List<String> options;
  final ValueChanged<int> onChanged;

  const SegmentedOptions({
    super.key,
    required this.options,
    required this.onChanged,
  });

  @override
  State<SegmentedOptions> createState() => _SegmentedOptionsState();
}

class _SegmentedOptionsState extends State<SegmentedOptions> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.options.asMap().entries.map((entry) {
        final index = entry.key;
        final option = entry.value;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = index;
              widget.onChanged(index); // Notify parent about the change
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: _selectedIndex == index
                  ? AppColors.primary
                  : AppColors.cardColor,
              borderRadius: AppDefaults.borderRadius,
              boxShadow: AppDefaults.boxShadow,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                SizedBox(
                  height: 32,
                  width: 32,
                  child: Icon(
                    Icons.man_4_outlined,
                    color:
                        _selectedIndex == index ? Colors.white : Colors.black,
                  ),
                ),
                AppSizedBox.w5,
                Text(
                  option,
                  style: TextStyle(
                    color:
                        _selectedIndex == index ? Colors.white : Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
