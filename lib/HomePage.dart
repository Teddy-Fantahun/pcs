import 'package:flutter/material.dart';

import 'DescriptionPage.dart';
import 'MainCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            opacity: 0.1,
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover),
      ),
      child: ListView(
        children: [
          Image.asset('assets/images/friends.jpg'),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: MainCard(DescriptionPage('PCS ምንድን ነው?',
                'assets/images/PCS.png',
                'PCS ከሰዎች ጋር ጓደኝነትን በመመስረት ለሰዎች ስለክርስቶስ የምንነግርበት መንገድ ነው።\n\n'
                    'PCS ምህፃረ ቃል ሲሆን ሲተነተን Pray Care Share (ወይም ፀሎት፣ እንክብካቤ እና ምስክርነት) ነው።\n\n'
                    'PCS ስትራቴጂን ለመጠቀም፣ በመጀመርያ ያልዳኑ ሰዎችን ለይተን በመምረጥ የስም ዝርዝራቸውን ይዘን እንፀልይላቸዋለን፤ በመቀጠልም ለሰዎቹ ፍቅር (እንክብካቤ) እንሰጣቸዋለን። በመጨረሻም የጌታን አዳኝነት እንመሰክርላቸዋለን።'
            )),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: MainCard(DescriptionPage('የምፀልይላቸውን ሰዎች እንዴት ልምረጥ?',
                'assets/images/how to list.jpg',
                'በምንኖርበት ሰፈር፣ በምንማርበት ቦታ ወይም በምንሰራበት መስርያ ቤት ውስጥ ብዙ ጌታን የማያውቁ ነገር ግን የምናውቃቸው ሰዎች ይኖራሉ። የምንፀልየውም ከእነዚህ ሰዎች መካከል የተወሰኑትን በመምረጥ ይሆናል።'
                    ' እነዚህን ሰዎች የምንመርጠው ልንፀልይላቸው ብቻ ሳይሆን ወደፊት እንክብካቤ ልናሳያቸው እና ልንመሰክርላቸውም ጭምር ስለሆነ የምንመርጣቸው ሰዎች በቅርበት ልናገኛቸው የምንችላቸው አይነት ሰዎች ቢሆኑ ይመከራል።'
            )),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: MainCard(DescriptionPage('የመዘገብኳቸውን ሰዎች እንዴት ነው የምንከባከባቸው?',
                'assets/images/care.jpg',
                'ለመረጥናቸው ሰዎች ከፀለይን በኋላ ቀጣዩ እርምጃ ለሰዎቹ ፍቅርን የምንሰጥበት መንገዶችን መፈለግ ነው። ይህን የምናደርገው በተለያየ መንገድ ሊሆን ይችላል። ለምሳሌ፦ አብሮአቸው ጊዜ ማሳለፍ፣ የፀሎት ርዕስ መቀበል፣ ምሳ መጋበዝ፣ እርዳታ በሚያስፈልጋቸው ነገር ከጎናቸው መቆም፣ ወ.ዘ.ተ ሊሆን ይችላል።'
            )),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: MainCard(DescriptionPage('ለመዘገብኳቸው ሰዎች እንዴት ነው ወንጌልን የምመሰክርላቸው?',
                'assets/images/share female.jpg',
                'የ ፒ.ሲ.ኤስ (PCS) የወንጌል ስትራቴጂ የመጨረሻው ደረጃ ለሰዎቹ ወንጌልን የምንነግርበትን ሁኔታ ማመቻቸት ነው። ለመዘገብናቸው ሰዎች መፀለይና እንክብካቤ ማሳየት ለሰዎቹ መዳን በቂ አይድለም። ፒ.ሲ.ኤስ (PCS) ስትራቴጂ ግቡን መምታት የሚችለው ለመረጥናቸው ሰዎች የክርስቶስን አዳኝነት ስንመሰክርላቸው ብቻ ነው። ይህንም ለማሳካት ሰዎቹ ትኩረታቸውን ሰጥተው ሊሰሙን የሚችሉበትን ቦታና ጊዜ በማመቻቸት የምስራቹን ቃል ማብሰር ይጠበቅብናል። አስፈላጊ ሁኖ ከተገኘም፣ የግል ታሪካችንን ማካፈል እንችላለን።'
            )),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(0,8.0,0,16.0),
            child: MainCard(DescriptionPage('ይህ መተግበርያ (app) PCS ስትራቴጂን በመተግበር አኳያ የሚያግዘኝ በምንድን ነው?',
                'assets/images/role of the app.jpg',
                'ይህ መተግበርያ ለፒ.ሲ.ኤስ (PCS) የመረጥናቸውን ሰዎች መዝግቦ ለመያዝ ይረዳል። በተጨማሪም ለመዘገብናቸው ሰዎች ሁልጊዜ መፀለይን እንድናስታውስ የሚያስችል አላርም (alarm) አለው። ወደፊትም ከፒ.ሲ.ኤስ (PCS) ጋር በተያያዘ ሌሎች ብዙ ስራዎችን መስራት እንዲያስችል ታስቦ የተሰራ መተግበርያ ነው።'
            )),
          ),

          /* template for adding new card

        MainCard(DescriptionPage('title',
            'assets/images/notifications.jpg',
            'content'
        )),

         */

        ],
      ),
    );
  }
}
