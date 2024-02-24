import 'package:flutter/material.dart';
import 'package:plastic_bay/features/rewards/screen/reward_shop.dart';
import 'package:plastic_bay/model/reward.dart';
import 'package:uuid/uuid.dart';

import '../features/plastic management/screen/dashboard.dart';
import '../features/leaderboard/screen/top_contributors.dart';
import '../features/profile/screen/settings_screen.dart';

List<Widget> screens = [
  const DashBoard(),
  const TopContributors(),
  const RewardCatalog(),
  const SettingsScreen()
];

List<Reward> rewardslIST = [
  Reward(
    category: 'Travel and Luggages',
    quantity: 50,
    rewardId: const Uuid().v4(),
    name: 'School Bag',
    value: 10,
    description:
        'Personalised Name Rucksack - Mini Rucksacks are perfect for kids going to School or Nursery. These bags are great for storing school things in and have a storage capacity of 7 litres.',
    imageUrl: 'https://m.media-amazon.com/images/I/81jPf2SS94L._AC_UY1000_.jpg',
  ),
  Reward(
    category: 'Travel and Luggages',
    quantity: 15,
    rewardId: const Uuid().v4(),
    name: 'Travel bag',
    value: 8,
    description: 'A leather hand bag',
    imageUrl:
        'https://w7.pngwing.com/pngs/883/164/png-transparent-handbag-leather-amazon-com-paper-travel-bag-zipper-brown-luggage-bags.png',
  ),
  Reward(
    category: 'Travel and Luggages',
    quantity: 60,
    rewardId: const Uuid().v4(),
    name: 'Small Jute Tote Bag',
    value: 5,
    description:
        'Small jute bag in natural color with matching short jute handles. This jute bag is made from Hessian that is both biodegradable and sustainable.',
    imageUrl:
        'https://cdn.ecommercedns.uk/files/9/248339/4/18048914/jm180n-zoom-small-jute-bag.jpg',
  ),
  Reward(
    category: 'Phone accessories',
    quantity: 9,
    rewardId: const Uuid().v4(),
    name: 'Google Pixel 5a 5G Case',
    value: 6,
    description:
        'Google Official Protective Case for Google Pixel 5a 5G - Black Moss',
    imageUrl:
        'https://i5.walmartimages.com/asr/465fbe29-54aa-4d28-8e62-3ce0c0929b72.6651c84b97a645183e365a2f20a5f514.jpeg',
  ),
  Reward(
    category: 'Drinkware',
    quantity: 12,
    rewardId: const Uuid().v4(),
    name: '16 oz Steel Pint Cup',
    value: 4,
    description:
        'Classic 16oz pint cup in brushed stainless steel. Durable, reusable, and dishwasher safe. Perfect for beer, wine, cocktails, and more.',
    imageUrl:
        'https://www.kleankanteen.com/cdn/shop/products/SB_Pint_0b3835cc-38b9-494c-8e5a-b9d2e5535828_1200x.jpg?v=1690836213',
  ),
  Reward(
    category: 'Drinkwares',
    quantity: 19,
    rewardId: const Uuid().v4(),
    name: 'Ceramic Coffee Mug',
    value: 5,
    description:
        'Enjoy your favorite brew in our ceramic coffee mug. Plastic-free and stylish, it adds a touch of sophistication to your daily caffeine ritua',
    imageUrl:
        'https://cdn.shopifycdn.net/s/files/1/2497/5092/files/A_3_f5b6f9dc-717f-4dfa-882b-898e9fcde3f7.jpg?v=1628672742',
  ),
  Reward(
    category: 'Housewares',
    quantity: 8,
    rewardId: const Uuid().v4(),
    name: 'Nappa Leather Doormat',
    value: 12,
    description:
        'Nappa LeatherBottom FinishingRubber non slip bottomUse it anywhere it gets wet easily- Doormat, Laundry room mat, Kitchen mat, Pet feeding mat, Table mat, Sink front mat, Bath MatSoft, Flexible and Comfortable',
    imageUrl:
        'https://5.imimg.com/data5/SELLER/Default/2023/8/337529444/EX/FO/HK/3471815/nappa-leather-doormat-500x500.jpg',
  ),
  Reward(
    category: 'Stationery',
    quantity: 8,
    rewardId: const Uuid().v4(),
    name: 'Composition Notebook 60 pages',
    value: 12,
    description:
        '''Upgrade your writing experience with our A5 Lined Stapled Notebook. Stay organized, creative, and productive!
Notebook 60 pages. 
English lined Pages.
Stapled Binding: Sturdy and convenient for easy page flipping.
A5 Size: Perfect for students.
High-Quality Paper: Smooth, bleed-resistant pages.
Value for Money: Economical choice for you!
Dimensions: 16×22.5 cm''',
    imageUrl:
        'https://mintra.com.eg/cdn/shop/files/DSC_0319withoutpacksticker_ae578904-d6db-4719-9cb0-f286dda188d2.jpg?v=1694690809',
  ),
];
