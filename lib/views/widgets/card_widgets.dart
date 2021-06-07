import 'package:flutter/material.dart';
import 'package:followpet_alfa/model/pet_model.dart';
import 'package:followpet_alfa/utils/colors.dart';
import 'package:followpet_alfa/utils/images.dart';

// ignore: must_be_immutable
class CardWidgets extends StatefulWidget {
  PetModel pet;
  final Function({PetModel petModel}) click;
  CardWidgets(this.pet, this.click);

  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<CardWidgets> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
      child: GestureDetector(
        onTap: () {
          widget.click(petModel: widget.pet);
          //Navigator.pushNamed(context, '/form', arguments: widget.pet);
        },
        child: Container(
          width: 209,
          height: 216,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                //color: Theme.of(context).cardColor,
                blurRadius: 4,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 16.32,
              ),
              Container(
                height: 138,
                width: 138,
                child: Image.asset(
                    widget.pet.SpeciePet == 'dog' ? ICONDOG : ICONCAT),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text(
                widget.pet.NamePet,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2.color,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}