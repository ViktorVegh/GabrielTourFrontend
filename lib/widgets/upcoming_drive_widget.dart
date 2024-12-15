import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/dtos/drive_dto.dart';
import 'package:gabriel_tour_app/dtos/person_dto.dart';
import 'package:gabriel_tour_app/services/person_service.dart';

class UpcomingDriveItem extends StatefulWidget {
  final DriveDTO drive;
  final Function() onManage;
  final PersonService personService;

  const UpcomingDriveItem({
    required this.drive,
    required this.onManage,
    required this.personService,
  });

  @override
  _UpcomingDriveItemState createState() => _UpcomingDriveItemState();
}

class _UpcomingDriveItemState extends State<UpcomingDriveItem> {
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
    if (widget.drive.userIds != null && widget.drive.userIds!.isNotEmpty) {
      try {
        final person = await widget.personService
            .getPersonByProfisId(widget.drive.userIds![0]);
        setState(() {
          userEmail = person?.email ?? 'Unknown user';
        });
      } catch (error) {
        setState(() {
          userEmail = 'Error fetching user';
        });
      }
    } else {
      setState(() {
        userEmail = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.drive.departurePlace} → ${widget.drive.arrivalPlace}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      if (widget.drive.customReason != null) ...[
                        SizedBox(height: 4),
                        Text(
                          widget.drive.customReason!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                      if (userEmail != null) ...[
                        SizedBox(height: 4),
                        Text(
                          'User: $userEmail',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.brown, size: 36),
                  onPressed: widget.onManage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
