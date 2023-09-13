import 'package:flutter/material.dart';

enum MarkerType { placeMarker, selectedMarker, exhibitionMarker }

class ExhibitionMarker extends StatefulWidget {
  const ExhibitionMarker({
    super.key,
    required this.type,
    required this.onFinishRendering,
  });

  final void Function(GlobalKey globalKey, MarkerType type) onFinishRendering;
  final MarkerType type;

  @override
  State<ExhibitionMarker> createState() => _ExhibitionMarkerState();
}

class _ExhibitionMarkerState extends State<ExhibitionMarker> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // widget.onFinishRendering(_globalKey, widget.type);
      loadTheMarker();
    });
  }

  Future<void> loadTheMarker() async {
    Future.delayed(const Duration(milliseconds: 100), () {
      widget.onFinishRendering(_globalKey, widget.type);
    });
  }

  Widget _renderAMarker() {
    if (widget.type == MarkerType.placeMarker) {
      // return asset.Images.placeMarker;
      return Container(width: 10, height: 10, color: Colors.red);
    } else if (widget.type == MarkerType.selectedMarker) {
      // return asset.Images.selectedMarker;
      return Container(width: 10, height: 10, color: Colors.blue);
    }

    // return asset.Images.marker;
    return Container(width: 10, height: 10, color: Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: _renderAMarker(),
    );
  }
}
