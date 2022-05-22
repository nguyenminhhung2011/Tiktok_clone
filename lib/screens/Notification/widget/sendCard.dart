import 'package:flutter/material.dart';

import '../../../models/messItem.dart';

class SendCard extends StatelessWidget {
  final MessItem data;
  const SendCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
      child: Align(
        alignment: Alignment.centerRight,
        child: (data.typeOfMessage == 0)
            ? Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 222, 236, 238),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(data.border1 as double),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(data.border2 as double),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  data.tittle,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              )
            : (data.typeOfMessage == 1)
                ? InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          backgroundColor: Colors.transparent,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 10,
                            height: MediaQuery.of(context).size.height / 3,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 252, 227),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width - 20,
                              height:
                                  MediaQuery.of(context).size.height / 3 - 10,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(data.tittle),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width / 2.2,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 222, 236, 238),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(data.border1 as double),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(data.border2 as double),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(data.tittle),
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 50,
                    width: 50,
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(data.tittle),
                    ),
                  ),
      ),
    );
  }
}
