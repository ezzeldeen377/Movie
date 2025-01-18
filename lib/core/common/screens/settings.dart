import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/common/app_provider/app_cubit.dart';
import 'package:movie/core/theme/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie/core/common/screens/init_route.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});


  @override
  Widget build(BuildContext context) {
    List<String> language=[
      AppLocalizations.of(context)!.english,
      AppLocalizations.of(context)!.arabic,
    ];
    List<String> languageCode=[
      'en','ar'
    ];
    return Scaffold(
      appBar: AppBar(leading: InkWell(onTap: (){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const InitRoute(),
          ),
        );
      },
      child: const Icon(Icons.arrow_back)),
        title: Text(AppLocalizations.of(context)!.settings,style:TextStyle(color:AppColors.whiteColor),
      ),
      centerTitle: true,
      ),
      body: Center(
      
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(AppLocalizations.of(context)!.lan,textAlign: TextAlign.start,style: const TextStyle(fontSize:26),),
              const SizedBox(height: 10,),
              Center(
                child: DropdownMenu(
                    width: 250.h,
                    initialSelection:language[languageCode.indexOf(context.watch<AppCubit>().state)],
                    onSelected: ((value){
                      if(value!=null) {
                        context.read<AppCubit>().changeLanguage(
                            languageCode[language.indexOf(value)]);
      
                      }
                    }),
      
                    dropdownMenuEntries:language.map((lang){
                      return DropdownMenuEntry(value: lang, label: lang);
                    }).toList()
                ),
              )
            ],
          ),
        ),
      ),
    );




  }
}
