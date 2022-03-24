import 'package:flutter/material.dart';
import 'package:sms_app/models/amostragem_model.dart';
import 'package:sms_app/models/plano_amostragem_model.dart';
import 'package:sms_app/models/plano_amostragem_on_model.dart';
import 'package:sms_app/pages/plano_amostragem_on_list_page.dart';
import 'package:sms_app/widgets/global/app_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class PlanoAmostragemCheckboxListPage extends StatefulWidget {
  const PlanoAmostragemCheckboxListPage({Key? key}) : super(key: key);

  @override
  State<PlanoAmostragemCheckboxListPage> createState() =>
      _PlanoAmostragemCheckboxListPageState();
}

class _PlanoAmostragemCheckboxListPageState
    extends State<PlanoAmostragemCheckboxListPage> {
  List<String> _selecteCategorys = [];

  void _onCategorySelected(bool selected, category_id) {
    if (selected == true) {
      setState(() {
        _selecteCategorys.add(category_id);
      });
    } else {
      setState(() {
        _selecteCategorys.remove(category_id);
      });
    }
  }

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Provider.of<PlanoAmostragemModel>(
      context,
      listen: false,
    ).loadPlanoAmostragem().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _refreshPlanoAmostragem(BuildContext context) {
    return Provider.of<PlanoAmostragemModel>(
      context,
      listen: false,
    ).loadPlanoAmostragem();
  }

  @override
  Widget build(BuildContext context) {
    PlanoAmostragemOnModel planoOnData = Provider.of(context);
    AmostragemModel amostragemData = Provider.of(context);

    return Scaffold(
      appBar: AppBarWidget(
        title: "Planos Disponíveis",
      ),
      body:
          Consumer<PlanoAmostragemModel>(builder: (context, planoData, child) {
        return _isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () => _refreshPlanoAmostragem(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ListView.builder(
                          itemCount: planoData.itemsCount,
                          itemBuilder: (ctx, index) {
                            return Card(
                                elevation: 4,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: CheckboxListTile(
                                    dense: true,
                                    secondary: CircleAvatar(
                                      radius: 30,
                                      child: Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: FittedBox(
                                          child: Text(
                                            planoData
                                                .items[index].idPlanoAmostragem,
                                          ),
                                        ),
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    title: Text(
                                        '${planoData.items[index].razaoSocial!} - ${planoData.items[index].nomeFantasia!}'),
                                    subtitle: Text(
                                        '${planoData.items[index].amostrador!} | ${planoData.items[index].dataPrevista!}'),
                                    value: _selecteCategorys.contains(planoData
                                        .items[index].idPlanoAmostragem),
                                    onChanged: (selected) {
                                      _onCategorySelected(
                                          selected!,
                                          planoData
                                              .items[index].idPlanoAmostragem);
                                    }));
                          },
                        ),
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                          icon: const Icon(
                            Icons.double_arrow_rounded,
                            size: 28,
                          ),
                          label: Text('Iniciar Amostragem',
                              style: Theme.of(context).textTheme.headline5),
                          style: ElevatedButton.styleFrom(
                            primary:
                                Theme.of(context).colorScheme.primaryVariant,
                            elevation: 4,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            fixedSize: const Size(10, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          onPressed: () {
                            _selecteCategorys.isEmpty
                                ? showTopSnackBar(
                                    context,
                                    const CustomSnackBar.error(
                                      message:
                                          "Favor selecione algum plano de amostragem.",
                                    ),
                                  )
                                : showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Atenção'),
                                        content: Text(
                                            'Deseja iniciar os planos de amostragem ${_selecteCategorys.join(', ')}?'),
                                        actions: [
                                          TextButton(
                                            child: const Text('Não'),
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                          ),
                                          TextButton(
                                            child: const Text('Sim'),
                                            onPressed: () async {
                                              amostragemData.loadAmostragem(
                                                _selecteCategorys.join(','),
                                              );
                                              // planoOnData
                                              //     .loadPlanoAmostragemOn(
                                              //   _selecteCategorys.join(','),
                                              // )

                                              Navigator.of(context).pop(true);
                                              Navigator.of(context).pop(true);
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlanoAmostragemOnListPage(
                                                          paId:
                                                              _selecteCategorys
                                                                  .join(',')),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    });
                          }),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
