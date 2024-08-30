import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie/Provider/Provider_languages.dart';
import 'package:provider/provider.dart';
class  Languagebuttomsheet extends StatefulWidget {


  @override
  State<Languagebuttomsheet> createState() => _LanguagebuttomsheetState();
}

class _LanguagebuttomsheetState extends State<Languagebuttomsheet> {
  @override
  Widget build(BuildContext context) {
    var porvider=Provider.of<ProviderLanguages>(context);
   return Container(
     margin: EdgeInsets.all(15),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         InkWell(onTap: (){
           porvider.changeLan('en');
         },
           child:porvider.Applan=="en"?
     getSelected(AppLocalizations.of(context)!.english):
               getUnSelected(AppLocalizations.of(context)!.english)
         ),
         SizedBox(height: 15,),
         InkWell(onTap:(){
           porvider.changeLan('ar');
         },child:porvider.Applan=="ar"?
    getSelected(AppLocalizations.of(context)!.arabic):
    getUnSelected(AppLocalizations.of(context)!.arabic)
         )],
     ),
   );
  }

  Widget getSelected(String text){

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,style: Theme.of(context).textTheme.bodySmall,),
        Icon(Icons.check,size: 35,),
      ],
    );



  }
  Widget getUnSelected(String text){

    return Text(text,style: Theme.of(context).textTheme.bodySmall,);



  }
}
