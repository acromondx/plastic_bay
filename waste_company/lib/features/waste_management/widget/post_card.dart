import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:go_router/go_router.dart';
import 'package:waste_company/api/providers.dart';
import 'package:waste_company/features/waste_management/controller/controller.dart';

import 'package:waste_company/model/plastic.dart';
import 'package:waste_company/routes/route_path.dart';
import 'package:waste_company/utils/post_status.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../theme/app_color.dart';
import '../../../utils/reuseables.dart';
import 'carousel_image.dart';

class PlasticPostCard extends ConsumerStatefulWidget {
  final Plastic plastic;
  final bool isPickedUp;
  const PlasticPostCard({
    super.key,
    required this.plastic,
    this.isPickedUp = false,
  });

  @override
  ConsumerState<PlasticPostCard> createState() => _PlasticPostCardState();
}

class _PlasticPostCardState extends ConsumerState<PlasticPostCard> {
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
          border: Border.all(
              color: widget.isPickedUp
                  ? Colors.red
                  : Theme.of(context).colorScheme.secondary),
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
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: AppColors.primaryColor,
                  ),
                  Text(address, style: textTheme.titleMedium),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        getDirection(
                            point: widget.plastic.location, address: address);
                      },
                      child: Text(
                        'Get Direction',
                        style: textTheme.titleMedium,
                      )),
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
            widget.isPickedUp
                ? const SizedBox.shrink()
                : widget.plastic.status == PlasticStatus.accepted
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
            widget.plastic.status == PlasticStatus.accepted
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          minWidth: 150,
                          height: 50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.red,
                          onPressed: () {
                            ref
                                .read(plasticControllerProvider.notifier)
                                .cancelPickUp(
                                  postId: widget.plastic.plasticId,
                                  context: context,
                                  contributorsId: widget.plastic.contributorId,
                                )
                                .then((value) {
                              ref.invalidate(acceptedPlasticPostProvider(true));
                              ref.invalidate(plasticPostProvider);
                            });
                          },
                          child: Text(
                            'Cancel',
                            style: textTheme.bodyMedium!
                                .copyWith(color: AppColors.greyColor),
                          ),
                        ),
                        const Spacer(),
                        MaterialButton(
                          minWidth: 150,
                          height: 50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: AppColors.primaryColor,
                          onPressed: () {
                            ref
                                .read(plasticControllerProvider.notifier)
                                .pickedUp(
                                    postId: widget.plastic.plasticId,
                                    contributorsId:
                                        widget.plastic.contributorId,
                                    context: context)
                                .then((value) {
                              ref.invalidate(acceptedPlasticPostProvider(true));
                              ref.invalidate(
                                  acceptedPlasticPostProvider(false));
                            });
                          },
                          child: Text(
                            'Pick Up',
                            style: textTheme.bodyMedium!
                                .copyWith(color: AppColors.greyColor),
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
