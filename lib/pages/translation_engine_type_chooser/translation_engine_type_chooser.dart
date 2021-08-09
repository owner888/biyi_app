import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../includes.dart';

class TranslationEngineTypeChooserPage extends StatefulWidget {
  final String engineType;
  final ValueChanged<String> onEngineTypeChanged;

  const TranslationEngineTypeChooserPage({
    Key key,
    this.engineType,
    this.onEngineTypeChanged,
  }) : super(key: key);

  @override
  _TranslationEngineTypeChooserPageState createState() =>
      _TranslationEngineTypeChooserPageState();
}

class _TranslationEngineTypeChooserPageState
    extends State<TranslationEngineTypeChooserPage> {
  String _type;

  void initState() {
    _type = widget.engineType;
    super.initState();
  }

  void _handleClickOk() async {
    if (widget.onEngineTypeChanged != null) {
      widget.onEngineTypeChanged(_type);
    }

    Navigator.of(context).pop();
  }

  Widget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: Text('引擎类型'),
      actions: [
        CustomAppBarActionItem(
          text: '确定',
          onPressed: _handleClickOk,
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return PreferenceList(
      children: [
        PreferenceListSection(
          children: [
            for (var engineType in kSupportedEngineTypes)
              PreferenceListRadioItem(
                icon: TranslationEngineIcon(
                  TranslationEngineConfig(type: engineType),
                ),
                title: Text(R.string('common.engine.$engineType')),
                value: engineType,
                groupValue: _type,
                onChanged: (newGroupValue) {
                  _type = engineType;
                  setState(() {});
                },
              ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }
}