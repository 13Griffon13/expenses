import 'package:flutter/material.dart';

class InteractiveListItem extends StatefulWidget {
  final Widget child;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final double height;

  const InteractiveListItem({
    Key? key,
    required this.child,
    required this.onDelete,
    required this.onEdit,
    required this.height,
  }) : super(key: key);

  @override
  State<InteractiveListItem> createState() => _InteractiveListItemState();
}

class _InteractiveListItemState extends State<InteractiveListItem> {
  bool showActions = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 2.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: SizedBox(
          height: widget.height,
          child: Stack(
            children: [
              widget.child,
              if (showActions)
                Container(
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          showActions = !showActions;
                          setState(() {});
                        },
                      ),
                      _separator(),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          widget.onEdit();
                          setState(() {
                            showActions = !showActions;
                          });
                        },
                      ),
                      _separator(),
                      IconButton(
                        icon: const Icon(Icons.delete_forever),
                        onPressed: () {
                          widget.onDelete();
                          setState(() {
                            showActions = !showActions;
                          });
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      onLongPress: () {
        showActions = !showActions;
        setState(() {});
      },
    );
  }

  Widget _separator() {
    return Container(
      width: 1.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.blueGrey.shade500,
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
