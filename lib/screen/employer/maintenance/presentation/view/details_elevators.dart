import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class DetailsElevators extends StatelessWidget {
  const DetailsElevators({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
    final String nameReport = arguments['nameReport'];
    final String date = arguments['date'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          nameReport,
          style: Styles.styleHeader,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(context.screenWidth * .02),
        children: [
          RichText(
            text: TextSpan(
              text: 'Date of preparation of the report: ',
              style: Styles.style14400,
              children: [TextSpan(text: date, style: Styles.style14400.copyWith(color: AppColors.subTextColor))],
            ),
          ),
          10.ESH(),
          Text(detailsReport),
        ],
      ),
    );
  }
}

String detailsReport = '''
Why Do You Need An Elevator Maintenance Plan?
Elevator maintenance is the inspection process of finding, diagnosing, and fixing issues that may cause elevator malfunction or breakdown.

Elevator service technicians perform elevator maintenance to keep lift systems safe and operating efficiently.

Without a maintenance plan, a malfunctioning elevator part can go unnoticed until a major repair is necessary. This major repair can be very costly and creates inconvenient usage downtime — especially in buildings where elderly or ailing residents need to travel to their homes above the first floor.

The value of an elevator is related to how well it is maintained throughout its lifecycle. A comprehensive elevator maintenance plan minimizes potential risks elevator/building owners and users face.

If an elevator isn’t maintained properly, the building owner could face financial exposure, liability issues and angry tenants.

Tenants, on the other hand, risk the unpleasant experience of getting stuck in an elevator, along with additional safety hazards and having to climb by foot to higher floors.

A comprehensive elevator maintenance plan should:

Prevent expensive repairs and part replacements by catching issues early on
Make sure elevators operate according to applicable codes
Ensure elevators pass the required inspections
Keep elevator users safe
Creating an elevator maintenance plan helps the entire building operate smoothly and keeps tenants satisfied with the quality of life in their building.

19 Items To Include In Your Elevator Inspection Checklist
An elevator inspection checklist prioritizes safety, ensures compliance with building regulations and helps mitigate risks to both tenants and building owners.

Your elevator maintenance checklist should contain the following items, categorized based on where they are located in the lift.

Inside The Car
Make sure the door can open and close properly and without obstructions
Check for damage on walls, ceiling and handrails
Check and replace any broken lights including those in the control panel
Make sure the emergency phone can connect the elevator user quickly with the local fire department or 911
Outside The Car
Inspect the door panels
Replace any broken lights on the door of the elevator on each floor
Test the fire alarm systems
Top Of The Car
Check cables for any signs of damage
Inspect the brake mechanism and test the brakes
Make sure an emergency exit is possible
Check the hoistway for signs of vandalism
Machine Room
Check oil levels and ensure systems are lubricated
Remove objects that may block access to the equipment
Check electrical wiring for any signs of defect
Ensure there is enough headroom for technicians
The Pit
Make sure the pit area can be properly accessed
Check for necessary clearance
Check for debris, dirt or water
Locate signs of damage on the car frame
''';
