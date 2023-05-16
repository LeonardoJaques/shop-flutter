// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/models/product_list.dart';
import 'package:shop_flutter/models/products.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  final _imageURLFocus = FocusNode();
  final _imageURLController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  void updateImage() => setState(() {});

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWith = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWith;
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    Provider.of<ProductList>(context, listen: false).saveProduct(_formData);
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final product = ModalRoute.of(context)?.settings.arguments as Product?;
      if (product != null) {
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['description'] = product.description;
        _formData['price'] = product.price;
        _formData['imageUrl'] = product.imageUrl;
        _imageURLController.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();

    _imageURLFocus.removeListener(updateImage);
    _imageURLFocus.dispose();
  }

  @override
  void initState() {
    super.initState();
    _imageURLFocus.addListener(updateImage);
  }

//https://cdn.pixabay.com/photo/2016/10/18/20/18/international-1751293_640.png
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Formulário de Produto'),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _submitForm,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    initialValue: _formData['name'] as String?,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocus);
                    },
                    onSaved: (name) => _formData['name'] = name ?? '',
                    validator: (name) {
                      final nameIsValid = name?.trim().isNotEmpty ?? false;
                      final nameIsInvalid = !nameIsValid;

                      if (nameIsInvalid) {
                        return 'Informe um nome válido';
                      }
                      if (nameIsValid && name!.trim().length < 3) {
                        return 'Informe um nome com no mínimo 3 letras';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                      initialValue: _formData['price']?.toString() ?? '',
                      decoration: const InputDecoration(labelText: 'Preço'),
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocus,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionFocus);
                      },
                      onSaved: (price) =>
                          _formData['price'] = double.parse(price ?? '0'),
                      validator: (priceValue) {
                        final priceString = priceValue?.trim() ?? '';
                        final price = double.tryParse(priceString) ?? -1;
                        if (price <= 0) {
                          return 'Informe um preço válido';
                        }
                        return null;
                      }),
                  TextFormField(
                    initialValue: _formData['description'] as String?,
                    decoration: const InputDecoration(labelText: 'Descrição'),
                    focusNode: _descriptionFocus,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    onSaved: (description) =>
                        _formData['description'] = description ?? '',
                    validator: (description) {
                      final descriptionIsValid =
                          description?.trim().isNotEmpty ?? false;
                      final descriptionIsInvalid = !descriptionIsValid;

                      if (descriptionIsInvalid) {
                        return 'Informe uma descrição válido';
                      }
                      if (descriptionIsValid &&
                          description!.trim().length < 10) {
                        return 'Informe uma descrição com no mínimo 10 letras';
                      }
                      return null;
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'URL da Imagem'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          focusNode: _imageURLFocus,
                          controller: _imageURLController,
                          onFieldSubmitted: (_) => _submitForm(),
                          onSaved: (imageUrl) =>
                              _formData['imageUrl'] = imageUrl ?? '',
                          validator: (imageUrlValue) {
                            final imageUrl = imageUrlValue?.trim() ?? '';
                            return isValidImageUrl(imageUrl)
                                ? null
                                : 'Informe uma URL válida';
                          },
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
                        child: _imageURLController.text.isEmpty
                            ? const Text('Informe a URL')
                            : FittedBox(
                                fit: BoxFit.cover,
                                child: Image.network(
                                  _imageURLController.text,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                      )
                    ],
                  ),
                ],
              )),
        ));
  }
}
