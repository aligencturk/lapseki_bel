import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../widgets/language_switcher.dart';

class TarihceScreen extends StatelessWidget {
  const TarihceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tarihçe',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryBlue,
        actions: [const LanguageSwitcher(), const SizedBox(width: 8)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Lâpseki İlçesinin Kuruluşu',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Lâpseki İlçesinin Kuruluşu M.Ö.600 yıllarına uzanmaktadır. Antik çağda Pityausa adı ile varlığını sürdüren LAMPSAKOS\'u Foçalıların kurduğu sanılmaktadır. İlçenin isminin kaynağı ile ilgili iki rivayet bulunmaktadır.',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'İsim Rivayetleri',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Birinci rivayete göre; Bebrykos\'lar denen ve bu bölgede yaşayan yerli halkın saldırısına uğrayan Foçalı göçmenler tam öldürülecekleri sırada Kral Mandrom\'un kızı Lampseke araya girerek göçmenleri kurtarmış bu nedenle Helen göçmenleri Lampseke\'ye bir tanrıça gibi tapmışlar ve sonradan ele geçirdikleri Pityausa kentine onun adını vererek şükran duygularını ifade etmişlerdir.',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'İkinci rivayet ise Evliya ÇELEBİ\'nin seyahatnamesinde rastlanmaktadır. Evliya ÇELEBİ\'ye göre deniz kenarından uzak bir bayır ve seki üzerinde incirli bir orman vardı. Türkler incire Löp derdi. İşte burada yapılan bu şehre de incirli seki anlamında Lâpseki denilmiştir ki adı Löpseki\'den gelir.',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Antik Çağ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Çok eski bir yerleşim yeri olan ve Antik çağda Pityausa adı ile varlığını sürdüren Lamsakos daha sonraları Fransa\'da Marsilya kentini kuran Focalıların ve ondan sonra da Miletoslıların eline geçti. Boğazın kilit noktasında bulunması ve Trakya ile Anadolu\'nun geçit yerinde olmasından dolayı tarihin her devrinde ya işgale uğradı, ya da şehrin düzenini bozan büyük göçlerin tesiri altında kaldı.',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Daha sonra Perslerin Yunan site devletlerinin (Atina, Isparta) sonra sırasıyla İskender İmparatorluğunun en son Roma İmparatorluğunun yönetim altında kalmıştır. Gelibolu\'nun Bizans Döneminde ticaret ve liman bakımından önem kazanması dolayısıyla Lapseki\'nin eski durumunu muhafaza etmesine imkan kalmadı. Çıkan buluntuların büyük kısmı Roma egemenliği döneminden kalmadır.',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Osmanlı Dönemi',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Osman Bey zamanında bir aşiret görünümdeki Osmanlı Devleti, Orhan Bey zamanında devlet hüviyetine sahip olmuş ve kuvvetleri ile Karesi ve Saruhan Beylikleri ortadan kaldırdıktan sonra Lapseki ve çevresini de ele geçirmişti. Orhan Gazi zamanında Süleyman Paşa önderliğindeki Osmanlı ordusu Rumeli\'ye geçmeden az önce Lapseki\'yi fethetmek için yürümüştür.',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Gazi Süleyman Paşa, Lapseki\'de bugünkü camiyi yaptırdı. Gazi Süleyman Paşa ve maiyeti denizden geçişi kolaylaştıracak bir yer ararlarken Marmara Denizinin giriş çıkış kapısı niteliğindeki Lapseki (Çardak) Mevkiine geldiler. Gazi Süleyman Paşa bugünkü Çardak beldesinde bir mescit yaptırdı.',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Evliya Çelebi (1611-1682) seyahatnamesinde Osmanlı dönemindeki Lapseki\'yi şöyle anlatmaktadır: "deniz kenarında olup hakimi vardır.150 akçelik kazadır. Halkı Rum ve Ermenidir. 1300 adet bağlı bahçeli, kiremit örtülü yan yana evleri vardır. Bir camii, hanları ve bir hamamı vardır. Çarşısı çok az ise de bağ ve bahçeleri çoktur. Karpuzu, üzüm turşusu ve bulaması ve şırası ünlüdür."',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Bu yüzyılda Lapseki\'de Yeniçeri serdarı, sipahi kethüda yeri, subaşısı, bacdarı ve muhtesibi vardı. Ayanı azdı. 1831\'de Sultan II Mahmud zamanında Şahap Efendinin yaptığı nüfus sayımına göre 2442 Müslüman halkın yaşadığı tespit edilmiştir.',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Çanakkale Savaşları',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Çanakkale savaşları boyunca Lapseki bir idari lojistik merkez olarak üzerine düşen görevi yerine getirmiştir. Gelibolu\'da bulunan Ordu Menzil Müfettişliği bu suretle Lapseki\'ye taşınmıştır. Ayrıca Gelibolu\'daki erzak ve cephane depoları da Lapseki\'ye nakledilmiştir. Ayrıca Lapseki\'de 300 yataklı bir hastane kurulmuştur.',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Kurtuluş Savaşı',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Kurtuluş Savaşı sırasında Lapseki Yunanlıların işgal yürüyüşleri sırasında 22 Haziran 1920\'de toplu saldırıya geçen Yunanlılar tarafından ele geçirildi. 1356 Yılından beri Türklerin elinde bulunan Lapseki, Çanakkale deniz ve kara savaşlarında yaralanan ve ölen binlerce askerimizin barındığı ve gömüldüğü yer olmuştur.',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Şu anki hükümet binası civarında ve Lapseki\'nin doğusundaki mezarlıkta en az 15.000 şehit yatmakta olup, bunların anısına ilçe mezarlığında küçük bir abide dikilmiştir. İlçemiz 3 km mesafedeki Çardak Beldesinde gömülen binlerce şehidimiz için Arıburnu şehitliği düzenlenmiştir.',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'İstiklal Savaşında da ilçe düşman işgaline uğramamış sadece birkaç kez İngiliz müfrezesi kısa bir süre için ilçe ve köylere zarar vermeden gelip geçmiştir. 25 Eylül 1922 tarihinde ilçeye girmek isteyen birkaç İngiliz müfrezesini ilçe halkımız kahramanca mücadele ederek ilçeye sokmamıştır. Lapseki\'nin kurtuluşu 25 Eylül 1922 olarak kabul edilmiş olup, her yıl 25 Eylül günü Lapseki\'nin kurtuluş bayramı olarak kutlanmaktadır.',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
