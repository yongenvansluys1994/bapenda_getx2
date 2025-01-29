import 'package:get/get.dart';

import '../modules/ads_detail/bindings/ads_detail_binding.dart';
import '../modules/ads_detail/views/ads_detail_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard.dart';
import '../modules/detailscreen/bindings/detailscreen_binding.dart';
import '../modules/detailscreen/views/detailscreen_view.dart';
import '../modules/ekitiran/bindings/ekitiran_binding.dart';
import '../modules/ekitiran/views/ekitiran_view.dart';
import '../modules/ekitiran_form/bindings/ekitiran_form_binding.dart';
import '../modules/ekitiran_form/views/ekitiran_form_view.dart';
import '../modules/homepage/bindings/homepage_binding.dart';
import '../modules/homepage/views/homepage_view.dart';
import '../modules/kartunpwpd/bindings/kartunpwpd_binding.dart';
import '../modules/kartunpwpd/bindings/kartunpwpd_detail_binding.dart';
import '../modules/kartunpwpd/views/kartunpwpd_detail_view.dart';
import '../modules/kartunpwpd/views/kartunpwpd_view.dart';
import '../modules/lapor_pajak/bindings/ebilling_binding.dart';
import '../modules/lapor_pajak/bindings/lapor_pajak_binding.dart';
import '../modules/lapor_pajak/bindings/lengkapi_data_binding.dart';
import '../modules/lapor_pajak/bindings/pelaporan_detail_binding.dart';
import '../modules/lapor_pajak/bindings/qris_page_binding.dart';
import '../modules/lapor_pajak/bindings/va_page_binding.dart';
import '../modules/lapor_pajak/views/OpenMap.dart';
import '../modules/lapor_pajak/views/OpenMap_npwpdbaru.dart';
import '../modules/lapor_pajak/views/OpenMap_tambahnpwpd.dart';
import '../modules/lapor_pajak/views/ebilling_view.dart';
import '../modules/lapor_pajak/views/lapor_pajak_view.dart';
import '../modules/lapor_pajak/views/lengkapi_data_view.dart';
import '../modules/lapor_pajak/views/pelaporan_detail_view.dart';
import '../modules/lapor_pajak/views/pelaporan_detail_view_cath.dart';
import '../modules/lapor_pajak/views/pelaporan_detail_view_ppj.dart';
import '../modules/lapor_pajak/views/qris_page_view.dart';
import '../modules/lapor_pajak/views/va_page_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/lokasi_kantor/bindings/lokasi_kantor_binding.dart';
import '../modules/lokasi_kantor/views/lokasi_kantor_view.dart';
import '../modules/lupa_password/bindings/lupa_password_binding.dart';
import '../modules/lupa_password/views/lupa_password_view.dart';
import '../modules/myprofil/bindings/myprofil_binding.dart';
import '../modules/myprofil/views/ads.dart';
import '../modules/myprofil/views/myprofil_view.dart';
import '../modules/myprofil/views/profilku_view.dart';
import '../modules/notifikasi/bindings/notifikasi_binding.dart';
import '../modules/notifikasi/views/notifikasi_view.dart';
import '../modules/objekku/bindings/objekku_binding.dart';
import '../modules/objekku/bindings/objekku_detail_binding.dart';
import '../modules/objekku/views/objekku_detail_view.dart';
import '../modules/objekku/views/objekku_view.dart';
import '../modules/panduan/bindings/panduan_binding.dart';
import '../modules/panduan/views/panduan_view.dart';
import '../modules/panduan_detail/bindings/panduan_detail_binding.dart';
import '../modules/panduan_detail/views/panduan_detail_view.dart';
import '../modules/parkir_app/bindings/parkir_app_binding.dart';
import '../modules/parkir_app/views/parkir_app_view.dart';
import '../modules/pbb/bindings/pbb_binding.dart';
import '../modules/pbb/views/pbb_view.dart';
import '../modules/pembayaran/bindings/pembayaran_binding.dart';
import '../modules/pembayaran/views/pembayaran_view.dart';
import '../modules/ppid/bindings/ppid_binding.dart';
import '../modules/ppid/views/ppid_view.dart';
import '../modules/qrispbb/bindings/qrispbb_binding.dart';
import '../modules/qrispbb/views/qrispbb_view.dart';
import '../modules/register/register_baru/bindings/register_baru_binding.dart';
import '../modules/register/register_baru/views/register_baru_view.dart';
import '../modules/register/register_npwpd/bindings/register_npwpd_binding.dart';
import '../modules/register/register_npwpd/views/register_npwpd_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/tambah_npwpd/bindings/tambah_npwpd_binding.dart';
import '../modules/tambah_npwpd/views/tambah_npwpd_view.dart';
import '../modules/tambah_npwpdbaru/bindings/tambah_npwpdbaru_binding.dart';
import '../modules/tambah_npwpdbaru/views/tambah_npwpdbaru_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => Dashboard(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.MYPROFIL,
      page: () => const MyprofilView(),
      binding: MyprofilBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.PROFILKU,
      page: () => const ProfilkuView(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.ADSPAGE,
      binding: MyprofilBinding(),
      page: () => const AdsPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.KARTUNPWPD,
      page: () => const KartunpwpdView(),
      binding: KartunpwpdBinding(),
      transition: Transition.noTransition,
      children: [
        GetPage(
          name: _Paths.KARTUNPWPD_DETAIL,
          page: () => const KartunpwpdDetailView(),
          binding: KartunpwpdDetailBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.OBJEKKU,
      page: () => const ObjekkuView(),
      binding: ObjekkuBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.REGISTER_NPWPD,
      page: () => const RegisterNpwpdView(),
      binding: RegisterNpwpdBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_BARU,
      page: () => const RegisterBaruView(),
      binding: RegisterBaruBinding(),
    ),
    GetPage(
      name: _Paths.LAPOR_PAJAK,
      page: () => LaporPajakView(),
      binding: LaporPajakBinding(),
      children: [
        GetPage(
          name: _Paths.PELAPORAN_DETAIL,
          page: () => PelaporanDetailView(),
          binding: PelaporanDetailBinding(),
        ),
        GetPage(
          name: _Paths.PELAPORAN_DETAIL_CATH,
          page: () => PelaporanDetailViewCath(),
          binding: PelaporanDetailBinding(),
        ),
        GetPage(
          name: _Paths.PELAPORAN_DETAIL_PPJ,
          page: () => PelaporanDetailViewPPJ(),
          binding: PelaporanDetailBinding(),
        ),
        GetPage(
          name: _Paths.EBILLING,
          page: () => const EbillingView(),
          binding: EbillingBinding(),
        ),
        GetPage(
          name: _Paths.VA_PAGE,
          page: () => const VaPageView(),
          binding: VaPageBinding(),
        ),
        GetPage(
          name: _Paths.LENGKAPI_DATA,
          page: () => LengkapiDataView(),
          binding: LengkapiDataBinding(),
        ),
        GetPage(
          name: _Paths.OPENMAP,
          page: () => OpenMap(),
          binding: LengkapiDataBinding(),
        ),
        GetPage(
          name: _Paths.OPENMAP_NPWPDBARU,
          page: () => OpenMapNpwpdBaru(),
          binding: TambahNpwpdbaruBinding(),
        ),
        GetPage(
          name: _Paths.OPENMAP_NPWPD,
          page: () => OpenMapTambahNpwpd(),
          binding: TambahNpwpdBinding(),
        ),
        GetPage(
          name: _Paths.QRIS_PAGE,
          page: () => const QrisPageView(),
          binding: QrisPageBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.PEMBAYARAN,
      page: () => const PembayaranView(),
      binding: PembayaranBinding(),
    ),
    GetPage(
      name: _Paths.ADS_DETAIL,
      page: () => const AdsDetailView(),
      binding: AdsDetailBinding(),
    ),
    GetPage(
      name: _Paths.PANDUAN,
      page: () => const PanduanView(),
      binding: PanduanBinding(),
    ),
    GetPage(
      name: _Paths.PANDUAN_DETAIL,
      page: () => const PanduanDetailView(),
      binding: PanduanDetailBinding(),
    ),
    GetPage(
      name: _Paths.LOKASI_KANTOR,
      page: () => const LokasiKantorView(),
      binding: LokasiKantorBinding(),
    ),
    GetPage(
      name: _Paths.HOMEPAGE,
      page: () => const HomepageView(),
      binding: HomepageBinding(),
    ),
    GetPage(
      name: _Paths.LUPA_PASSWORD,
      page: () => const LupaPasswordView(),
      binding: LupaPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PPID,
      page: () => const PpidView(),
      binding: PpidBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_NPWPDBARU,
      page: () => const TambahNpwpdbaruView(),
      binding: TambahNpwpdbaruBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_NPWPD,
      page: () => const TambahNpwpdView(),
      binding: TambahNpwpdBinding(),
    ),
    GetPage(
      name: _Paths.PARKIR_APP,
      page: () => const ParkirAppView(),
      binding: ParkirAppBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFIKASI,
      page: () => const NotifikasiView(),
      binding: NotifikasiBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.OBJEKKU_DETAIL,
      page: () => const ObjekkuDetailView(),
      binding: ObjekkuDetailBinding(),
    ),
    GetPage(
      name: _Paths.DETAILSCREEN,
      page: () => const DetailscreenView(),
      binding: DetailscreenBinding(),
    ),
    GetPage(
      name: _Paths.PBB,
      page: () => const PbbView(),
      binding: PbbBinding(),
    ),
    GetPage(
      name: _Paths.QRISPBB,
      page: () => const QrispbbView(),
      binding: QrispbbBinding(),
    ),
    GetPage(
      name: _Paths.EKITIRAN,
      page: () => const EkitiranView(),
      binding: EkitiranBinding(),
    ),
    GetPage(
      name: _Paths.EKITIRAN_FORM,
      page: () => const EkitiranFormView(),
      binding: EkitiranFormBinding(),
    ),
  ];
}
