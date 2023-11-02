import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_management/constants/colors.dart';

class EditItemTile extends StatefulWidget {

  final String itemName;
  final int price;
  final int quantity;
  final bool isEven;
  EditItemTile({Key? key, required this.itemName, required this.price, required this.isEven, required this.quantity}) : super(key: key);

  @override
  State<EditItemTile> createState() => _EditItemTileState();
}

class _EditItemTileState extends State<EditItemTile> {
  Apptheme th = Apptheme();
  int _quantity = 0;
  int _price = 0;

  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.itemName;
    _quantity = widget.quantity;
    _price = widget.price;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.itemName),
      subtitle:
      Text("Available: ${widget.quantity} Pieces"),
      backgroundColor: widget.isEven
          ? Colors.white
          : Colors.grey.withOpacity(0.4),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Rs ${widget.price}"),
      ),
      children: [
        Form(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      label: Text("Name"),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.amber,
                          )
                      ),
                      border: OutlineInputBorder()
                  ),
                ),
              ),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Price: "),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.60,
                          decoration: BoxDecoration(
                              color: th.kYellow,
                              borderRadius: BorderRadius.circular(6)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                child: const Icon(Icons.remove),
                                onTap: () {
                                  if (_price == 0) {
                                    return;
                                  } else {
                                    setState(() {
                                      _price--;
                                    });
                                  }
                                },
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.40,
                                height:
                                MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                    color: th.kWhite,
                                    borderRadius: BorderRadius.circular(6)),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  // controller: priceController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding:
                                    const EdgeInsets.only(top: 8.0),
                                    hintText: _price.toString(),
                                    border: const OutlineInputBorder(),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      _price = int.parse(val);
                                    });
                                  },
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      _price++;
                                    });
                                  },
                                  child: const Icon(Icons.add)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Quantity: "),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.60,
                          decoration: BoxDecoration(
                              color: th.kYellow,
                              borderRadius: BorderRadius.circular(6)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                child: const Icon(Icons.remove),
                                onTap: () {
                                  if (_quantity == 0) {
                                    return;
                                  } else {
                                    setState(() {
                                      _quantity--;
                                    });
                                  }
                                },
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.40,
                                height: MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                    color: th.kWhite,
                                    borderRadius: BorderRadius.circular(6)),
                                child: TextFormField(
                                  // controller: quantityController,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding:
                                    const EdgeInsets.only(top: 12),
                                    hintText: _quantity.toString(),
                                    border: const OutlineInputBorder(),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      _quantity = int.parse(val);
                                    });
                                  },
                                ),
                              ),
                              InkWell(
                                child: const Icon(Icons.add),
                                onTap: () {
                                  setState(() {
                                    _quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
