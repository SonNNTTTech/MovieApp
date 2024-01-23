import 'package:flutter/material.dart';
import 'package:test_app/widget/my_loading.dart';

class PaginationWrapper extends StatefulWidget {
  ///child muust be scrollable
  final Widget child;
  final Future Function() onReload;
  final Future Function() onNewPage;
  final bool isNoMorePage;
  final String? errorText;

  const PaginationWrapper({
    Key? key,
    required this.child,
    required this.onReload,
    required this.onNewPage,
    this.isNoMorePage = false,
    this.errorText,
  }) : super(key: key);

  @override
  State<PaginationWrapper> createState() => _PaginationWrapperState();
}

class _PaginationWrapperState extends State<PaginationWrapper> {
  late bool isLoading;
  final scrollController = ScrollController();
  @override
  void initState() {
    isLoading = !widget.isNoMorePage;
    loadPageTrigger();
    super.initState();
  }

  void loadPageTrigger() {
    scrollController.addListener(() async {
      if (isLoading) return;
      if (widget.isNoMorePage) return;
      if (scrollController.offset >
          (scrollController.position.maxScrollExtent * 0.9)) {
        isLoading = true;
        setState(() {});
        await widget.onNewPage();
        isLoading = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: widget.onReload,
        child: Scrollbar(
          controller: scrollController,
          child: ListView(
            controller: scrollController,
            children: [
              widget.child,
              widget.errorText == null
                  ? Container()
                  : Column(
                      children: [
                        const SizedBox(height: 12),
                        Center(
                          child: Text(widget.errorText!),
                        ),
                      ],
                    ),
              const SizedBox(height: 12),
              Center(
                child:
                    isLoading ? const MyLoading() : const Text('End content'),
              )
            ],
          ),
        ));
  }
}
