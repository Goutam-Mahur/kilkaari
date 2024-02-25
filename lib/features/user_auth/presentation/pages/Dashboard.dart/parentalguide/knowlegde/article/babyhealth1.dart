import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  final translator = GoogleTranslator();
  String selectedLanguage = 'English'; 

  String translatedIntroduction = '';
  String translatedSection1 = '';
  String translatedSection2 = '';
  String translatedSection3 = '';
  String translatedSection4 = '';
  String translatedSection5 = '';
  String translatedSection6 = '';
  String translatedConclusion = '';

  void translateText(String languageCode) async {
    final List<Future<Translation>> translations = [
      translator.translate(
        'Introduction: Welcoming a newborn into the family is a joyous occasion, but it can also be overwhelming for new mothers. This article aims to provide essential tips for caring for a newborn and ensuring their health and well-being.',
        to: languageCode,
      ),
      translator.translate(
        'Section 1: Creating a Safe Environment: Preparing the home for the arrival of a newborn is crucial. Baby-proofing measures should be taken, such as covering electrical outlets and securing furniture to prevent accidents. Additionally, setting up a safe sleep environment is essential. Babies should sleep on their backs in a crib with a firm mattress and no soft bedding. Hazardous items, such as small objects and choking hazards, should be kept out of reach. Maintaining a clean and hygienic living space is also important to prevent infections and illnesses.',
        to: languageCode,
      ),
      translator.translate(
        'Section 2: Feeding and Nutrition: Breastfeeding is highly beneficial for both the mother and the baby. It provides essential nutrients and antibodies that help protect the baby from infections. Establishing a successful breastfeeding routine may take time and patience, but it\'s worth the effort. Proper latching techniques are important for ensuring effective breastfeeding. Mothers who are unable to breastfeed can opt for formula feeding, following safe preparation and feeding practices.',
        to: languageCode,
      ),
      translator.translate(
        'Section 3: Diapering and Hygiene: Proper diapering is essential for keeping the baby comfortable and preventing diaper rash. Diapers should be changed frequently, and gentle cleansers can be used during diaper changes. It\'s important to keep the diaper area clean and dry to prevent irritation. Good hygiene practices, such as regular handwashing and bathing, are important for both the baby and the caregiver.',
        to: languageCode,
      ),
      translator.translate(
        'Section 4: Understanding Infant Cues: Babies communicate their needs through various cues, such as crying, facial expressions, and body movements. It\'s important for mothers to learn to recognize these cues and respond promptly. Common cues include hunger, tiredness, and discomfort. Responding to these cues promptly helps promote bonding and communication between the mother and the baby.',
        to: languageCode,
      ),
      translator.translate(
        'Section 5: Bonding and Development: Bonding with the newborn is crucial for their emotional and cognitive development. Skin-to-skin contact, cuddling, and talking to the baby are all important bonding activities. Newborns also benefit from activities that promote cognitive and physical development, such as tummy time and sensory stimulation. Monitoring developmental milestones and seeking guidance from healthcare professionals can help ensure the baby\'s healthy development.',
        to: languageCode,
      ),
      translator.translate(
        'Section 6: Seeking Support: New mothers should not hesitate to seek support from family members, friends, and healthcare professionals. Support groups for new mothers can provide valuable advice and reassurance. It\'s important for mothers to prioritize self-care and seek help if they experience postpartum depression or anxiety.',
        to: languageCode,
      ),
      translator.translate(
        'Conclusion: Caring for a newborn can be challenging, but with love, patience, and support, new mothers can provide the best care for their babies. From creating a safe environment to seeking support when needed, these essential tips can help new mothers navigate the joys and challenges of caring for a newborn.',
        to: languageCode,
      ),
    ];

    final translatedTexts = await Future.wait(translations);
    setState(() {
      translatedIntroduction = translatedTexts[0].text;
      translatedSection1 = translatedTexts[1].text;
      translatedSection2 = translatedTexts[2].text;
      translatedSection3 = translatedTexts[3].text;
      translatedSection4 = translatedTexts[4].text;
      translatedSection5 = translatedTexts[5].text;
      translatedSection6 = translatedTexts[6].text;
      translatedConclusion = translatedTexts[7].text;
    });
  }

  @override
  void initState() {
    super.initState();
    translateText('en'); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article: The Essential Guide to Newborn Care'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                  if (newValue == 'English') {
                    translateText('en');
                  } else if (newValue == 'Hindi') {
                    translateText('hi');
                  }
                  // Add more languages as needed
                });
              },
              items: <String>['English', 'Hindi']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Introduction:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              translatedIntroduction.isNotEmpty
                  ? translatedIntroduction
                  : 'Loading...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/images/newbornessential.png',
              fit: BoxFit.cover,
            ),
            SizedBox(height: 30),
            Text(
              'Section 1: Creating a Safe Environment',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              translatedSection1.isNotEmpty ? translatedSection1 : 'Loading...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Section 2: Feeding and Nutrition',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              translatedSection2.isNotEmpty ? translatedSection2 : 'Loading...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Section 3: Diapering and Hygiene',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              translatedSection3.isNotEmpty ? translatedSection3 : 'Loading...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Section 4: Understanding Infant Cues',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              translatedSection4.isNotEmpty ? translatedSection4 : 'Loading...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Section 5: Bonding and Development',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              translatedSection5.isNotEmpty ? translatedSection5 : 'Loading...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Section 6: Seeking Support',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              translatedSection6.isNotEmpty ? translatedSection6 : 'Loading...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Conclusion:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              translatedConclusion.isNotEmpty
                  ? translatedConclusion
                  : 'Loading...',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class NewPage1 extends StatefulWidget {
  @override
  _NewPage1State createState() => _NewPage1State();
}

class _NewPage1State extends State<NewPage1> {
  final translator = GoogleTranslator();
  String selectedLanguage = 'English'; 

  String translatedIntroduction = '';
  String translatedSection1 = '';
  String translatedSection2 = '';
  String translatedSection3 = '';
  String translatedSection4 = '';
  String translatedSection5 = '';
  String translatedSection6 = '';
  String translatedConclusion = '';

  void translateText(String languageCode) async {
    final List<Future<Translation>> translations = [
      translator.translate(
        'Introduction: Welcoming a newborn is a momentous occasion for parents, but it\'s natural to worry about their health and well-being. This article aims to educate parents about common newborn health concerns and provide guidance on when to seek medical attention.',
        to: languageCode,
      ),
      translator.translate(
        'Section 1: Jaundice: Jaundice is a common condition in newborns, characterized by yellowing of the skin and eyes. It occurs when there is an excess of bilirubin in the blood. While mild jaundice is common and usually resolves on its own, severe jaundice can be dangerous. Parents should monitor their baby\'s skin color and contact a healthcare provider if they notice any signs of jaundice.',
        to: languageCode,
      ),
      translator.translate(
        'Section 2: Colic and Gas: Colic is a condition characterized by excessive crying and fussiness in otherwise healthy babies. It typically peaks around six weeks of age and resolves on its own by three to four months of age. Gas can contribute to colic symptoms, so parents can try gentle techniques such as rocking, swaddling, and using white noise to soothe a colicky baby. Dietary changes for breastfeeding mothers, such as avoiding certain foods that may cause gas, can also help alleviate symptoms.',
        to: languageCode,
      ),
      translator.translate(
        'Section 3: Diaper Rash: Diaper rash is a common irritation of the skin in the diaper area, often caused by prolonged exposure to moisture and irritants. Prevention is key, and parents should change diapers frequently and use gentle cleansers during diaper changes. Applying a barrier cream can help protect the skin from irritation. If diaper rash persists or worsens, parents should seek medical attention.',
        to: languageCode,
      ),
      translator.translate(
        'Section 4: Infant Thrush: Thrush is a fungal infection that can occur in the mouth of infants, characterized by white patches on the tongue and inside the cheeks. It is caused by an overgrowth of yeast and is common in newborns. Antifungal medications are usually prescribed to treat thrush, and parents should also practice good oral hygiene to prevent its spread.',
        to: languageCode,
      ),
      translator.translate(
        'Section 5: Common Illnesses and Infections: Newborns are susceptible to common illnesses and infections, such as colds, fevers, and respiratory syncytial virus (RSV). Parents should take steps to prevent the spread of infections, such as washing their hands frequently and avoiding close contact with sick individuals. They should also monitor their baby closely for signs of illness, such as difficulty breathing or a high fever, and seek medical attention if necessary.',
        to: languageCode,
      ),
      translator.translate(
        'Conclusion: While it\'s natural for parents to worry about their baby\'s health, being informed about common newborn health concerns can help alleviate anxiety. By monitoring their baby closely and seeking medical attention when needed, parents can help ensure their baby\'s health and well-being as they navigate the joys and challenges of parenthood.',
        to: languageCode,
      ),
    ];

    final translatedTexts = await Future.wait(translations);
    setState(() {
      translatedIntroduction = translatedTexts[0].text;
      translatedSection1 = translatedTexts[1].text;
      translatedSection2 = translatedTexts[2].text;
      translatedSection3 = translatedTexts[3].text;
      translatedSection4 = translatedTexts[4].text;
      translatedSection5 = translatedTexts[5].text;
      translatedConclusion = translatedTexts[6].text;
    });
  }

  @override
  void initState() {
    super.initState();
    translateText('en'); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article: Common Newborn Health Concerns'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                  if (newValue == 'English') {
                    translateText('en');
                  } else if (newValue == 'Hindi') {
                    translateText('hi');
                  }
                  // Add more languages as needed
                });
              },
              items: <String>['English', 'Hindi']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Introduction:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              translatedIntroduction.isNotEmpty
                  ? translatedIntroduction
                  : 'Loading...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/images/healthconcern.png',
              fit: BoxFit.cover,
            ),
            SizedBox(height: 30),
            Text(
              'Section 1: Creating a Safe Environment',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              translatedSection1.isNotEmpty ? translatedSection1 : 'Loading...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Section 2: Feeding and Nutrition',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              translatedSection2.isNotEmpty ? translatedSection2 : 'Loading...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Section 3: Diapering and Hygiene',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              translatedSection3.isNotEmpty ? translatedSection3 : 'Loading...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Section 4: Understanding Infant Cues',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              translatedSection4.isNotEmpty ? translatedSection4 : 'Loading...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Section 5: Bonding and Development',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              translatedSection5.isNotEmpty ? translatedSection5 : 'Loading...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Conclusion:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              translatedConclusion.isNotEmpty
                  ? translatedConclusion
                  : 'Loading...',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

//___________________________________________________________________________________________________

class NewPage2 extends StatefulWidget {
  @override
  _NewPage2State createState() => _NewPage2State();
}

class _NewPage2State extends State<NewPage2> {
  final translator = GoogleTranslator();
  String selectedLanguage = 'English'; 

  String originalIntroduction =
      'Introduction: As parents, ensuring the cleanliness and safety of our baby\'s environment is paramount. Baby gear, including strollers, car seats, high chairs, and toys, can harbor germs and bacteria that pose risks to our little ones\' health. In this article, we\'ll provide a comprehensive guide to sanitizing baby gear effectively, keeping our babies healthy and happy.';
  String originalSection1 =
      'Understanding the Importance of Sanitizing Baby Gear: 1. Preventing Illness: Babies have developing immune systems, making them more susceptible to infections. Sanitizing baby gear reduces the risk of illnesses caused by exposure to germs, viruses, and bacteria, promoting a healthier environment for our babies to thrive in. 2. Minimizing Allergens: Dust, pet dander, and other allergens can accumulate on baby gear and trigger allergic reactions in sensitive infants. Regular sanitization helps minimize allergen buildup, creating a safer and more comfortable space for our babies. 3. Maintaining Hygiene: Babies explore their surroundings by touching and mouthing objects, increasing their exposure to germs and bacteria. Sanitizing baby gear ensures that items they come into contact with are clean and hygienic, reducing the risk of infections and keeping our babies safe.';
  String originalSection2 =
      'Effective Methods for Sanitizing Baby Gear: 1. Cleaning vs. Sanitizing: Understand the difference between cleaning (removing visible dirt and debris) and sanitizing (killing germs and bacteria). Start by cleaning baby gear with soap and water, then proceed to sanitize using appropriate methods. 2. Hot Water and Soap: For items that can be submerged in water, such as plastic toys and feeding utensils, wash them thoroughly with hot, soapy water. Use a brush or sponge to scrub hard-to-reach areas, then rinse and air dry. 3. Disinfectant Wipes: Disinfectant wipes are convenient for sanitizing surfaces such as stroller handles, high chair trays, and changing tables. Choose wipes that are safe for use around babies and follow the manufacturer\'s instructions for proper usage. 4. Steam Cleaning: Steam cleaning is an effective method for sanitizing fabric-based baby gear, such as car seats, stroller seats, and play mats. Use a steam cleaner with attachments to reach crevices and seams, and ensure that the fabric is dry before use. 5. UV Sterilization: UV sterilizers use ultraviolet light to kill germs and bacteria on baby gear items such as pacifiers, bottle nipples, and small toys. Follow the manufacturer\'s instructions for the appropriate duration of sterilization. 6. Machine Washing: Check the manufacturer\'s guidelines to determine if fabric items such as baby clothes, blankets, and bedding are machine washable. Use hot water and a baby-safe detergent, and dry items thoroughly before use.';
  String originalConclusion =
      'Conclusion: Sanitizing baby gear is an essential part of maintaining a clean and safe environment for our little ones. By understanding the importance of sanitization and employing effective methods for cleaning and disinfection, parents can ensure that their baby gear remains hygienic and free from harmful germs and bacteria. Remember, a little extra effort in sanitizing baby gear goes a long way in safeguarding our babies\' health and well-being.';

  String translatedIntroduction = '';
  String translatedSection1 = '';
  String translatedSection2 = '';
  String translatedConclusion = '';

  void translateText(String languageCode) async {
    final List<Future<Translation>> translations = [
      translator.translate(
        originalIntroduction,
        to: languageCode,
      ),
      translator.translate(
        originalSection1,
        to: languageCode,
      ),
      translator.translate(
        originalSection2,
        to: languageCode,
      ),
      translator.translate(
        originalConclusion,
        to: languageCode,
      ),
    ];

    final translatedTexts = await Future.wait(translations);
    setState(() {
      translatedIntroduction = translatedTexts[0].text;
      translatedSection1 = translatedTexts[1].text;
      translatedSection2 = translatedTexts[2].text;
      translatedConclusion = translatedTexts[3].text;
    });
  }

  @override
  void initState() {
    super.initState();
    translateText('en');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article: Baby\'s Clean Space'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                  if (newValue == 'English') {
                    translatedIntroduction = originalIntroduction;
                    translatedSection1 = originalSection1;
                    translatedSection2 = originalSection2;
                    translatedConclusion = originalConclusion;
                  } else if (newValue == 'Hindi') {
                    translateText('hi');
                  }
                  // Add more languages as needed
                });
              },
              items: <String>['English', 'Hindi']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Introduction:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedLanguage == 'English'
                  ? originalIntroduction
                  : translatedIntroduction,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/images/sanitation1.png',
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Section 1: Understanding the Importance of Sanitizing Baby Gear',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedLanguage == 'English'
                  ? originalSection1
                  : translatedSection1,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Section 2: Effective Methods for Sanitizing Baby Gear',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedLanguage == 'English'
                  ? originalSection2
                  : translatedSection2,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Conclusion:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedLanguage == 'English'
                  ? originalConclusion
                  : translatedConclusion,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

//_____________________________________________________________________________________________

class NewPage3 extends StatefulWidget {
  @override
  _NewPage3State createState() => _NewPage3State();
}

class _NewPage3State extends State<NewPage3> {
  final translator = GoogleTranslator();
  String selectedLanguage = 'English'; 

  String originalIntroduction =
      'Introduction: Welcoming a baby into the family is a joyous occasion filled with love and excitement. As parents, ensuring the health and well-being of our little ones is our top priority. A crucial aspect of this care is maintaining a clean and safe environment for our babies to grow and thrive in. In this article, we\'ll explore the essentials of sanitation for babies, providing practical tips and guidelines to help parents create a healthy and hygienic environment for their little ones.';
  String originalSection1 =
      'The Importance of Sanitation for Babies: 1. Protecting Against Infections: Babies have delicate immune systems that are still developing, making them more susceptible to infections. Proper sanitation practices help reduce the risk of illnesses caused by harmful bacteria, viruses, and pathogens, keeping our babies healthy and safe. 2. Preventing Allergies: Allergens such as dust, pet dander, and pollen can trigger allergic reactions in babies with sensitive immune systems. Maintaining a clean environment minimizes allergen exposure, reducing the risk of allergic reactions and respiratory issues. 3. Promoting Healthy Development: A clean and hygienic environment is essential for supporting the healthy growth and development of babies. By minimizing exposure to germs and toxins, we create a safe space where our babies can explore, learn, and develop without unnecessary health risks.';
  String originalSection2 =
      'Practical Tips for Sanitation: 1. Regular Handwashing: Wash your hands thoroughly with soap and water before and after handling your baby, preparing food, or changing diapers. Encourage other caregivers and visitors to practice good hand hygiene to prevent the spread of germs. 2. Clean Diapering Practices: Change your baby\'s diapers frequently and clean the diaper area thoroughly with gentle wipes or warm water and mild soap. Use diaper rash cream to protect against irritation and diaper rash. 3. Cleaning Baby Gear: Regularly clean and sanitize baby gear such as strollers, high chairs, and toys. Use baby-safe cleaning products and follow manufacturer instructions for proper cleaning and disinfection. 4. Maintaining a Clean Nursery: Keep your baby\'s nursery clean and clutter-free. Regularly dust and vacuum the room, wash bedding and curtains, and sanitize frequently touched surfaces such as door handles and light switches. 5. Proper Food Handling: If you\'re introducing solid foods to your baby, ensure proper food safety practices. Wash fruits and vegetables thoroughly, store food at the correct temperature, and avoid cross-contamination during food preparation. 6. Pet Hygiene: If you have pets, keep their living areas clean and free from pet hair and dander. Bathe and groom pets regularly, and supervise interactions between pets and babies to prevent accidents and infections.';
  String originalConclusion =
      'Conclusion: Maintaining a clean and safe environment is essential for the health and well-being of our babies. By following practical sanitation tips and guidelines, parents can create a healthy and hygienic space where their little ones can thrive and grow. Remember, investing in sanitation is an investment in our babies\' health and future.';

  String translatedIntroduction = '';
  String translatedSection1 = '';
  String translatedSection2 = '';
  String translatedConclusion = '';

  void translateText(String languageCode) async {
    final List<Future<Translation>> translations = [
      translator.translate(
        originalIntroduction,
        to: languageCode,
      ),
      translator.translate(
        originalSection1,
        to: languageCode,
      ),
      translator.translate(
        originalSection2,
        to: languageCode,
      ),
      translator.translate(
        originalConclusion,
        to: languageCode,
      ),
    ];

    final translatedTexts = await Future.wait(translations);
    setState(() {
      translatedIntroduction = translatedTexts[0].text;
      translatedSection1 = translatedTexts[1].text;
      translatedSection2 = translatedTexts[2].text;
      translatedConclusion = translatedTexts[3].text;
    });
  }

  @override
  void initState() {
    super.initState();
    translateText('en'); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article: Sanitation Essentials'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                  if (newValue == 'English') {
                    translatedIntroduction = originalIntroduction;
                    translatedSection1 = originalSection1;
                    translatedSection2 = originalSection2;
                    translatedConclusion = originalConclusion;
                  } else if (newValue == 'Hindi') {
                    translateText('hi');
                  }
                  
                });
              },
              items: <String>['English', 'Hindi']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Introduction:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedLanguage == 'English'
                  ? originalIntroduction
                  : translatedIntroduction,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/images/sanitation2.png',
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Section 1: The Importance of Sanitation for Babies',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedLanguage == 'English'
                  ? originalSection1
                  : translatedSection1,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Section 2: Practical Tips for Sanitation',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedLanguage == 'English'
                  ? originalSection2
                  : translatedSection2,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Conclusion:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedLanguage == 'English'
                  ? originalConclusion
                  : translatedConclusion,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

//____________________________________________________________________________________

class NewPage4 extends StatefulWidget {
  @override
  _NewPage4State createState() => _NewPage4State();
}

class _NewPage4State extends State<NewPage4> {
  final translator = GoogleTranslator();
  String selectedLanguage = 'English'; 

  String originalIntroduction =
      'Introduction: Bringing a newborn home is an exciting and joyous time, but it also comes with the responsibility of ensuring your baby\'s health and well-being. Newborn hygiene plays a crucial role in keeping your baby clean, comfortable, and healthy during their early days. In this article, we\'ll discuss essential tips for maintaining proper hygiene for your newborn, from bathing to diaper changing and beyond.';
  String originalSection1 =
      '1. Bathing Your Newborn: Bathing your newborn may seem daunting at first, but it\'s an essential part of maintaining hygiene. Here are some tips for bathing your baby: - Use lukewarm water and a mild baby soap or cleanser. - Support your baby\'s head and neck while bathing, and never leave them unattended in the water. - Keep baths short (around 5-10 minutes) to prevent your baby from getting cold. - Gently pat your baby dry with a soft towel, paying special attention to skin folds.';
  String originalSection2 =
      '2. Umbilical Cord Care: The umbilical cord stump requires special care until it falls off, usually within the first few weeks. Follow these guidelines: - Keep the area clean and dry by gently wiping around the base of the cord with a cotton swab or ball dampened with rubbing alcohol. - Fold down your baby\'s diaper to expose the stump to air and prevent it from getting wet. - Avoid covering the stump with tight clothing or diapers.';
  String originalSection3 =
      '3. Diaper Changing: Frequent diaper changes are essential for keeping your baby clean and preventing diaper rash. Follow these steps: - Change your baby\'s diaper every 2-3 hours, or as soon as it becomes soiled or wet. - Clean your baby\'s diaper area with baby wipes or a damp cloth, wiping from front to back to prevent infections. - Use diaper rash cream or ointment to protect your baby\'s skin from irritation.';
  String originalSection4 =
      '4. Skin Care: Newborn skin is delicate and sensitive, requiring gentle care to keep it healthy. Here are some tips: - Use fragrance-free and hypoallergenic baby products to minimize the risk of irritation. - Keep your baby\'s skin moisturized with a mild baby lotion or oil, especially in dry or cold weather. - Dress your baby in loose-fitting, breathable clothing made from natural fabrics like cotton.';
  String originalSection5 =
      '5. Nail Care: Your baby\'s nails may grow quickly and can be sharp, posing a risk of scratching their delicate skin. Here\'s how to trim their nails safely: - Use baby nail clippers or scissors with rounded tips. - Trim your baby\'s nails while they\'re asleep or calm to minimize movement. - Trim nails straight across and avoid cutting too close to the skin to prevent injury.';
  String originalConclusion =
      'Conclusion: Maintaining proper hygiene for your newborn is essential for their health and well-being. By following these tips for bathing, umbilical cord care, diaper changing, skin care, and nail care, you can keep your baby clean, comfortable, and healthy during their early days. Remember to trust your instincts and seek advice from your pediatrician if you have any concerns about your baby\'s hygiene or health.';

  String translatedIntroduction = '';
  String translatedSection1 = '';
  String translatedSection2 = '';
  String translatedSection3 = '';
  String translatedSection4 = '';
  String translatedSection5 = '';
  String translatedConclusion = '';

  void translateText(String languageCode) async {
    final List<Future<Translation>> translations = [
      translator.translate(
        originalIntroduction,
        to: languageCode,
      ),
      translator.translate(
        originalSection1,
        to: languageCode,
      ),
      translator.translate(
        originalSection2,
        to: languageCode,
      ),
      translator.translate(
        originalSection3,
        to: languageCode,
      ),
      translator.translate(
        originalSection4,
        to: languageCode,
      ),
      translator.translate(
        originalSection5,
        to: languageCode,
      ),
      translator.translate(
        originalConclusion,
        to: languageCode,
      ),
    ];

    final translatedTexts = await Future.wait(translations);
    setState(() {
      translatedIntroduction = translatedTexts[0].text;
      translatedSection1 = translatedTexts[1].text;
      translatedSection2 = translatedTexts[2].text;
      translatedSection3 = translatedTexts[3].text;
      translatedSection4 = translatedTexts[4].text;
      translatedSection5 = translatedTexts[5].text;
      translatedConclusion = translatedTexts[6].text;
    });
  }

  @override
  void initState() {
    super.initState();
    translateText('en'); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article: Newborn Hygiene'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                  if (newValue == 'English') {
                    translatedIntroduction = originalIntroduction;
                    translatedSection1 = originalSection1;
                    translatedSection2 = originalSection2;
                    translatedSection3 = originalSection3;
                    translatedSection4 = originalSection4;
                    translatedSection5 = originalSection5;
                    translatedConclusion = originalConclusion;
                  } else if (newValue == 'Hindi') {
                    translateText('hi');
                  }
                  // Add more languages as needed
                });
              },
              items: <String>['English', 'Hindi']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Introduction:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedLanguage == 'English'
                  ? originalIntroduction
                  : translatedIntroduction,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/images/hygine1.png',
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              '1. Bathing Your Newborn:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedLanguage == 'English'
                  ? originalSection1
                  : translatedSection1,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '2. Umbilical Cord Care:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedLanguage == 'English'
                  ? originalSection2
                  : translatedSection2,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '3. Diaper Changing:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedLanguage == 'English'
                  ? originalSection3
                  : translatedSection3,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '4. Skin Care:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedLanguage == 'English'
                  ? originalSection4
                  : translatedSection4,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '5. Nail Care:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedLanguage == 'English'
                  ? originalSection5
                  : translatedSection5,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Conclusion:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedLanguage == 'English'
                  ? originalConclusion
                  : translatedConclusion,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

//____________________________________________________________________________________

class NewPage5 extends StatefulWidget {
  @override
  _NewPage5State createState() => _NewPage5State();
}

class _NewPage5State extends State<NewPage5> {
  final translator = GoogleTranslator();
  String selectedLanguage = 'English'; // Default language

  String originalIntroduction =
      'Introduction: Bringing a newborn home is an exciting and joyous time, but it also comes with the responsibility of ensuring your baby\'s health and well-being. Newborn hygiene plays a crucial role in keeping your baby clean, comfortable, and healthy during their early days. In this article, we\'ll discuss essential tips for maintaining proper hygiene for your newborn, from bathing to diaper changing and beyond.';
  String originalSection1 =
      '1. Bathing Your Newborn: Bathing your newborn may seem daunting at first, but it\'s an essential part of maintaining hygiene. Here are some tips for bathing your baby: - Use lukewarm water and a mild baby soap or cleanser. - Support your baby\'s head and neck while bathing, and never leave them unattended in the water. - Keep baths short (around 5-10 minutes) to prevent your baby from getting cold. - Gently pat your baby dry with a soft towel, paying special attention to skin folds.';
  String originalSection2 =
      '2. Umbilical Cord Care: The umbilical cord stump requires special care until it falls off, usually within the first few weeks. Follow these guidelines: - Keep the area clean and dry by gently wiping around the base of the cord with a cotton swab or ball dampened with rubbing alcohol. - Fold down your baby\'s diaper to expose the stump to air and prevent it from getting wet. - Avoid covering the stump with tight clothing or diapers.';
  String originalSection3 =
      '3. Diaper Changing: Frequent diaper changes are essential for keeping your baby clean and preventing diaper rash. Follow these steps: - Change your baby\'s diaper every 2-3 hours, or as soon as it becomes soiled or wet. - Clean your baby\'s diaper area with baby wipes or a damp cloth, wiping from front to back to prevent infections. - Use diaper rash cream or ointment to protect your baby\'s skin from irritation.';
  String originalSection4 =
      '4. Skin Care: Newborn skin is delicate and sensitive, requiring gentle care to keep it healthy. Here are some tips: - Use fragrance-free and hypoallergenic baby products to minimize the risk of irritation. - Keep your baby\'s skin moisturized with a mild baby lotion or oil, especially in dry or cold weather. - Dress your baby in loose-fitting, breathable clothing made from natural fabrics like cotton.';
  String originalSection5 =
      '5. Nail Care: Your baby\'s nails may grow quickly and can be sharp, posing a risk of scratching their delicate skin. Here\'s how to trim their nails safely: - Use baby nail clippers or scissors with rounded tips. - Trim your baby\'s nails while they\'re asleep or calm to minimize movement. - Trim nails straight across and avoid cutting too close to the skin to prevent injury.';
  String originalConclusion =
      'Conclusion: Maintaining proper hygiene for your newborn is essential for their health and well-being. By following these tips for bathing, umbilical cord care, diaper changing, skin care, and nail care, you can keep your baby clean, comfortable, and healthy during their early days. Remember to trust your instincts and seek advice from your pediatrician if you have any concerns about your baby\'s hygiene or health.';

  String translatedIntroduction = '';
  String translatedSection1 = '';
  String translatedSection2 = '';
  String translatedSection3 = '';
  String translatedSection4 = '';
  String translatedSection5 = '';
  String translatedConclusion = '';

  void translateText(String languageCode) async {
    final List<Future<Translation>> translations = [
      translator.translate(
        originalIntroduction,
        to: languageCode,
      ),
      translator.translate(
        originalSection1,
        to: languageCode,
      ),
      translator.translate(
        originalSection2,
        to: languageCode,
      ),
      translator.translate(
        originalSection3,
        to: languageCode,
      ),
      translator.translate(
        originalSection4,
        to: languageCode,
      ),
      translator.translate(
        originalSection5,
        to: languageCode,
      ),
      translator.translate(
        originalConclusion,
        to: languageCode,
      ),
    ];

    final translatedTexts = await Future.wait(translations);
    setState(() {
      translatedIntroduction = translatedTexts[0].text;
      translatedSection1 = translatedTexts[1].text;
      translatedSection2 = translatedTexts[2].text;
      translatedSection3 = translatedTexts[3].text;
      translatedSection4 = translatedTexts[4].text;
      translatedSection5 = translatedTexts[5].text;
      translatedConclusion = translatedTexts[6].text;
    });
  }

  @override
  void initState() {
    super.initState();
    translateText('en'); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article: Newborn Hygiene'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                  if (newValue == 'English') {
                    translatedIntroduction = originalIntroduction;
                    translatedSection1 = originalSection1;
                    translatedSection2 = originalSection2;
                    translatedSection3 = originalSection3;
                    translatedSection4 = originalSection4;
                    translatedSection5 = originalSection5;
                    translatedConclusion = originalConclusion;
                  } else if (newValue == 'Hindi') {
                    translateText('hi');
                  }
                  // Add more languages as needed
                });
              },
              items: <String>['English', 'Hindi']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Introduction:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedLanguage == 'English'
                  ? originalIntroduction
                  : translatedIntroduction,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/images/hygine2.png',
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              '1. Bathing Your Newborn:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedLanguage == 'English'
                  ? originalSection1
                  : translatedSection1,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '2. Umbilical Cord Care:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedLanguage == 'English'
                  ? originalSection2
                  : translatedSection2,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '3. Diaper Changing:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedLanguage == 'English'
                  ? originalSection3
                  : translatedSection3,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '4. Skin Care:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedLanguage == 'English'
                  ? originalSection4
                  : translatedSection4,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '5. Nail Care:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedLanguage == 'English'
                  ? originalSection5
                  : translatedSection5,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Conclusion:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedLanguage == 'English'
                  ? originalConclusion
                  : translatedConclusion,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
//________________________________________________________________________________