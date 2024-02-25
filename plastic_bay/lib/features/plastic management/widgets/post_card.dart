
import 'package:flutter/material.dart';
import 'package:plastic_bay/features/plastic%20management/widgets/carousel_image.dart';
import 'package:plastic_bay/model/plastic.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:plastic_bay/theme/app_color.dart';

import '../../../utils/enums/post_status.dart';
import '../../../utils/extensions/date_format.dart';


class PlasticPostCard extends StatefulWidget {
  final Plastic plastic;
  const PlasticPostCard({super.key, required this.plastic});

  @override
  State<PlasticPostCard> createState() => _PlasticPostCardState();
}

class _PlasticPostCardState extends State<PlasticPostCard> {
 
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.plastic.status == PlasticStatus.accepted
                ? SizedBox(
                    height: 50,
                    child: TimerCountdown(
                        timeTextStyle: const TextStyle(color: Colors.red),
                        endTime: parseDateString(
                            '${widget.plastic.pickUpDate} ${widget.plastic.pickUpTime}')),
                  )
                : const SizedBox.shrink(),
            CarouselImage(imageLink: widget.plastic.imageUrl),
            ListTile(
              title: Text(widget.plastic.description),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
             
                  Chip(
                      side: BorderSide(color: AppColors.secondaryColor),
                      backgroundColor:
                          plasticStatusColor(widget.plastic.status),
                      label: Text(widget.plastic.status.name.toUpperCase(),
                          style: textTheme.titleMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Text(
                    'Qty',
                    style: textTheme.titleMedium!.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${widget.plastic.quantity}kg',
                    style: textTheme.titleMedium!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    widget.plastic.plasticType.name,
                    style: textTheme.titleMedium!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
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
