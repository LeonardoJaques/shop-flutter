// ignore_for_file: unused_element

import 'package:flutter/material.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  @override
  Widget build(BuildContext context) {
    final priceFocus = FocusNode();
    final descriptionFocus = FocusNode();
    final imageURLFocus = FocusNode();
    final ValueChanged<bool>? onFocusChange;

    TextEditingController imageURLController = TextEditingController();
    void updateImage() {
      setState(() {});
    }

//https://cdn.pixabay.com/photo/2012/04/18/23/18/dart-38220__180.png

    @override
    void dispose() {
      super.dispose();
      priceFocus.dispose();
      descriptionFocus.dispose();

      imageURLFocus.removeListener(updateImage);
      imageURLFocus.dispose();
    }

    @override
    void initState() {
      super.initState();
      imageURLFocus.addListener(updateImage);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Formulário de Produto'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
              child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(priceFocus);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                focusNode: priceFocus,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(descriptionFocus);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descrição'),
                focusNode: descriptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'URL da Imagem'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      focusNode: imageURLFocus,
                      controller: imageURLController,
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: imageURLController.text.isEmpty
                        ? Text('Informe a URL')
                        : FittedBox(
                            child: Image.network("${imageURLController.text}"),
                            fit: BoxFit.cover,
                          ),
                  )
                ],
              ),
            ],
          )),
        ));
  }
}
