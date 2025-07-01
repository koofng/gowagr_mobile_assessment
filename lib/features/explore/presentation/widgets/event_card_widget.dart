import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gowagr_mobile_assessment/features/explore/domain/models/event_model.dart';
import 'package:gowagr_mobile_assessment/helpers/date_helper.dart';

class EventCardWidget extends StatelessWidget {
  const EventCardWidget({super.key, required Event event}) : _event = event;

  final Event _event;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: _event.imageUrl,
                    placeholder: (context, url) => CircularProgressIndicator(strokeWidth: 2),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                    width: 48,
                    height: 48,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _event.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Center(
                    child: Text(
                      'Buy Yes  - ₦${_event.markets[0].yesBuyPrice}',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Center(
                    child: Text(
                      'Buy No  - ₦${_event.markets[0].noBuyPrice}',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          /// ROI
          Row(
            children: const [
              Expanded(
                child: Text(
                  '₦10k  →  ₦22k',
                  style: TextStyle(color: Colors.green),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  '₦10k  →  ₦15k',
                  style: TextStyle(color: Colors.green),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          /// Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.bar_chart, size: 16, color: Colors.grey),
                  SizedBox(width: 4),
                  Text('${_event.totalVolume} Trades', style: TextStyle(color: Colors.grey)),
                ],
              ),
              Row(
                children: [
                  if (_event.resolutionDate == null || _event.resolutionDate == '')
                    Text('Ends -')
                  else
                    Text('Ends ${formatDate(DateTime.parse(_event.resolutionDate ?? ''))}', style: TextStyle(color: Colors.grey)),
                  SizedBox(width: 4),
                  Icon(Icons.bookmark_border_outlined, size: 16, color: Colors.grey),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
