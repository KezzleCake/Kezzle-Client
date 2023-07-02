import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SizePricedWidget extends StatelessWidget {
  final List priceList;

  const SizePricedWidget({super.key, required this.priceList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '사이즈별 평균가',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PriceBox(
              size: '미니',
              diameter: '지름 12cm',
              price: priceList[0],
            ),
            PriceBox(
              size: '1호',
              diameter: '지름 15cm',
              price: priceList[1],
            ),
            PriceBox(
              size: '2호',
              diameter: '지름 18cm',
              price: priceList[2],
            ),
            PriceBox(
              size: '3호',
              diameter: '지름 21cm',
              price: priceList[3],
            ),
          ],
        ),
      ],
    );
  }
}

class PriceBox extends StatelessWidget {
  final String size;
  final String diameter;
  final int price;

  const PriceBox({
    super.key,
    required this.size,
    required this.diameter,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            size,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Text(
            diameter,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '${NumberFormat('###,###,###,###').format(price)}원~',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
