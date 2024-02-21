import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:go_router/go_router.dart';

import 'package:waste_company/model/plastic.dart';
import 'package:waste_company/routes/route_path.dart';
import 'package:waste_company/utils/post_status.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../theme/app_color.dart';
import '../../../utils/reuseables.dart';
import 'carousel_image.dart';

class PlasticPostCard extends StatefulWidget {
  final Plastic plastic;
  const PlasticPostCard({super.key, required this.plastic});

  @override
  State<PlasticPostCard> createState() => _PlasticPostCardState();
}

class _PlasticPostCardState extends State<PlasticPostCard> {
  String address = '';
  @override
  void initState() {
    getStreetAddress(widget.plastic.location).then((value) {
      setState(() {
        address = value;
      });
    });
    super.initState();
  }

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
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(timeago.format(widget.plastic.postedAt)),
                )),
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
              title: Text(
                widget.plastic.description,
                style: textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: AppColors.primaryColor,
                  ),
                  Text(address),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        getDirection(widget.plastic.location);
                      },
                      child: const Text('Get Direction')),
                  const Spacer(),
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
            widget.plastic.status == PlasticStatus.accepted
                ? const SizedBox()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      context.pushNamed(RoutePath.acceptPost,
                          extra: widget.plastic);
                    },
                    child: Text(
                      'Accept',
                      style: textTheme.bodyMedium!
                          .copyWith(color: AppColors.greyColor),
                    )),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
