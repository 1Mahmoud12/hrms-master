import 'package:cnattendance/model/leave.dart';
import 'package:cnattendance/provider/leaveprovider.dart';
import 'package:dropdown_button3/dropdown_button3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//ignore: must_be_immutable
class LeavetypeFilter extends StatelessWidget {
  Leave? selectedValue;

  LeavetypeFilter({super.key});

  @override
  Widget build(BuildContext context, [bool mounted = true]) {
    final provider = Provider.of<LeaveProvider>(context);

    void onToggleChanged() async {
      final detailResponse = await provider.getLeaveTypeDetail();

      if (!mounted) return;
      if (detailResponse.statusCode == 200) {
        if (detailResponse.data.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              behavior: SnackBarBehavior.floating,
              padding: EdgeInsets.all(20),
              content: Text('No data found'),),);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            padding: const EdgeInsets.all(20),
            content: Text(detailResponse.message),),);
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Filter',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: const Row(
              children: [
                Icon(
                  Icons.list,
                  size: 16,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    'Select Leave Type',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: provider.leaveList
                .map((item) => DropdownMenuItem<Leave>(
                      value: item,
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),)
                .toList(),
            value: selectedValue?.name,
            onChanged: (value) {
              selectedValue = value as Leave?;
              if (selectedValue != null) {
                provider.setType(selectedValue!.id);
                onToggleChanged();
              }
            },
          ),
        ),
      ],
    );
  }
}
