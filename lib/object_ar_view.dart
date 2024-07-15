import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';

class ObjectArView extends StatefulWidget {
  const ObjectArView({super.key});

  @override
  State<ObjectArView> createState() => _ObjectArViewState();
}

class _ObjectArViewState extends State<ObjectArView> {
  ArCoreController? arCoreController;
  ArCoreNode? node;

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController?.onPlaneDetected = _handleOnPlaneDetected;
  }

  void _handleOnPlaneDetected(ArCorePlane plane) {
    if (node != null) {
      arCoreController?.removeNode(nodeName: node!.name);
    }
    _add3dObject(plane);
  }

  void _add3dObject(ArCorePlane plane) {
    final toucanNode = ArCoreReferenceNode(
        name: "Toucano",
        objectUrl:
            "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF/Duck.gltf",
        position: plane.centerPose?.translation,
        rotation: plane.centerPose?.rotation);

    arCoreController?.addArCoreNodeWithAnchor(toucanNode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        enableUpdateListener: true,
      ),
    );
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}
