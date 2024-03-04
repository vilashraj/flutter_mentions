part of flutter_mentions;

class OptionList extends StatelessWidget {
  OptionList({
    required this.data,
    required this.onTap,
    required this.suggestionListHeight,
    this.suggestionBuilder,
    this.suggestionListDecoration,
    this.separatorBuilder
  });

  final Widget Function(Map<String, dynamic>)? suggestionBuilder;
  final Widget Function(int index)? separatorBuilder;

  final List<Map<String, dynamic>> data;

  final Function(Map<String, dynamic>) onTap;

  final double suggestionListHeight;

  final BoxDecoration? suggestionListDecoration;

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? Container(
            decoration:
                suggestionListDecoration ?? BoxDecoration(color: Colors.white),
            constraints: BoxConstraints(
              maxHeight: suggestionListHeight,
              minHeight: 0,
            ),
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 2.0),
              itemCount: data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _buildItem(index);
              },
              separatorBuilder: (context, index) {
                return separatorBuilder?.call(index) ?? Container();
              },
            ),
          )
        : Container();
  }

  Widget _buildItem(int index){
    return GestureDetector(
      onTap: () {
        onTap(data[index]);
      },
      child: suggestionBuilder != null
          ? suggestionBuilder!(data[index])
          : Container(
              color: Colors.blue,
              padding: EdgeInsets.all(20.0),
              child: Text(
                data[index]['display'],
                style: TextStyle(fontSize: 12),
              ),
            ),
    );

  }
}
