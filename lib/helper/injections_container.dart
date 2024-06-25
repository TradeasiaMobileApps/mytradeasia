import 'package:get_it/get_it.dart';
import 'package:mytradeasia/features/data/data_sources/firebase/auth_user_firebase.dart';
import 'package:mytradeasia/features/data/data_sources/firebase/cart_firebase.dart';
import 'package:mytradeasia/features/data/data_sources/remote/all_industry_service.dart';
import 'package:mytradeasia/features/data/data_sources/remote/auth_service.dart';
import 'package:mytradeasia/features/data/data_sources/remote/category_service.dart';
import 'package:mytradeasia/features/data/data_sources/remote/country_service.dart';
import 'package:mytradeasia/features/data/data_sources/remote/detail_product_service.dart';
import 'package:mytradeasia/features/data/data_sources/remote/dhl_shipment_service.dart';
import 'package:mytradeasia/features/data/data_sources/remote/dropdown_service.dart';
import 'package:mytradeasia/features/data/data_sources/remote/faq_service.dart';
import 'package:mytradeasia/features/data/data_sources/remote/home_service.dart';
import 'package:mytradeasia/features/data/data_sources/remote/list_product_service.dart';
import 'package:mytradeasia/features/data/data_sources/remote/quote_service.dart';
import 'package:mytradeasia/features/data/data_sources/remote/otp_service.dart';
import 'package:mytradeasia/features/data/data_sources/remote/recently_seen_product_service.dart';
import 'package:mytradeasia/features/data/data_sources/remote/rfq_service.dart';
import 'package:mytradeasia/features/data/data_sources/remote/sales_force_data_service.dart';
import 'package:mytradeasia/features/data/data_sources/remote/sales_force_detail_service.dart';
import 'package:mytradeasia/features/data/data_sources/remote/sales_force_login_service.dart';
import 'package:mytradeasia/features/data/data_sources/remote/searates_service.dart';
import 'package:mytradeasia/features/data/data_sources/remote/search_product_service.dart';
import 'package:mytradeasia/features/data/data_sources/remote/top_products_service.dart';
import 'package:mytradeasia/features/data/repository/cart_repository_impl.dart';
import 'package:mytradeasia/features/data/repository/category_repository_impl.dart';
import 'package:mytradeasia/features/data/repository/country_repository_impl.dart';
import 'package:mytradeasia/features/data/repository/detail_product_repository.dart';
import 'package:mytradeasia/features/data/repository/dhl_shipment_repository.dart';
import 'package:mytradeasia/features/data/repository/dropdown_repository_impl.dart';
import 'package:mytradeasia/features/data/repository/faq_repository.dart';
import 'package:mytradeasia/features/data/repository/home_repository_impl.dart';
import 'package:mytradeasia/features/data/repository/industry_repository.dart';
import 'package:mytradeasia/features/data/repository/list_product_repository.dart';
import 'package:mytradeasia/features/data/repository/quote_repository_impl.dart';
import 'package:mytradeasia/features/data/repository/otp_repository_impl.dart';
import 'package:mytradeasia/features/data/repository/rfq_repository_impl.dart';
import 'package:mytradeasia/features/data/repository/sales_force_data_repository.dart';
import 'package:mytradeasia/features/data/repository/sales_force_detail_repository.dart';
import 'package:mytradeasia/features/data/repository/sales_force_login_repository.dart';
import 'package:mytradeasia/features/data/repository/searates_route_repository_impl.dart';
import 'package:mytradeasia/features/data/repository/search_product_repository.dart';
import 'package:mytradeasia/features/data/repository/top_product_repository.dart';
import 'package:mytradeasia/features/data/repository/user_repository_impl.dart';
import 'package:mytradeasia/features/domain/repository/cart_repository.dart';
import 'package:mytradeasia/features/domain/repository/category_repository.dart';
import 'package:mytradeasia/features/domain/repository/country_repository.dart';
import 'package:mytradeasia/features/domain/repository/detail_product_repository.dart';
import 'package:mytradeasia/features/domain/repository/dhl_shipment_repository.dart';
import 'package:mytradeasia/features/domain/repository/dropdown_repository.dart';
import 'package:mytradeasia/features/domain/repository/faq_repository.dart';
import 'package:mytradeasia/features/domain/repository/home_repository.dart';
import 'package:mytradeasia/features/domain/repository/industry_repository.dart';
import 'package:mytradeasia/features/domain/repository/quote_repository.dart';
import 'package:mytradeasia/features/domain/repository/otp_repository.dart';
import 'package:mytradeasia/features/domain/repository/searates_repository.dart';
import 'package:mytradeasia/features/domain/repository/list_product_repository.dart';
import 'package:mytradeasia/features/domain/repository/rfq_repository.dart';
import 'package:mytradeasia/features/domain/repository/sales_force_data_repository.dart';
import 'package:mytradeasia/features/domain/repository/sales_force_detail_repository.dart';
import 'package:mytradeasia/features/domain/repository/sales_force_login_repository.dart';
import 'package:mytradeasia/features/domain/repository/search_product_repository.dart';
import 'package:mytradeasia/features/domain/repository/top_product_repository.dart';
import 'package:mytradeasia/features/domain/repository/user_repository.dart';
import 'package:mytradeasia/features/domain/usecases/cart_usecases/add_cart.dart';
import 'package:mytradeasia/features/domain/usecases/cart_usecases/delete_cart_item.dart';
import 'package:mytradeasia/features/domain/usecases/cart_usecases/get_cart.dart';
import 'package:mytradeasia/features/domain/usecases/cart_usecases/update_cart.dart';
import 'package:mytradeasia/features/domain/usecases/category_usecases/get_category_usecases.dart';
import 'package:mytradeasia/features/domain/usecases/country_usecases/get_country_usecase.dart';
import 'package:mytradeasia/features/domain/usecases/country_usecases/search_country_usecase.dart';
import 'package:mytradeasia/features/domain/usecases/detail_product_usecases/get_detail_product.dart';
import 'package:mytradeasia/features/domain/usecases/dhl_shipment_usecases/get_dhl_shipment.dart';
import 'package:mytradeasia/features/domain/usecases/dropdown_usecases/get_currency_usecase.dart';
import 'package:mytradeasia/features/domain/usecases/dropdown_usecases/get_incoterm_usecase.dart';
import 'package:mytradeasia/features/domain/usecases/dropdown_usecases/get_uom_usecase.dart';
import 'package:mytradeasia/features/domain/usecases/faq_usecases/get_faq_data.dart';
import 'package:mytradeasia/features/domain/usecases/home_usecases/get_home_data.dart';
import 'package:mytradeasia/features/domain/usecases/industry_usecases/get_industry.dart';
import 'package:mytradeasia/features/domain/usecases/quote_usecases/get_quote_usecase.dart';
import 'package:mytradeasia/features/domain/usecases/rfq_usecases/approve_quote.dart';
import 'package:mytradeasia/features/domain/usecases/rfq_usecases/get_rfq_list.dart';
import 'package:mytradeasia/features/domain/usecases/rfq_usecases/reject_quote.dart';
import 'package:mytradeasia/features/domain/usecases/otp_usecases/send_otp.dart';
import 'package:mytradeasia/features/domain/usecases/otp_usecases/verify_otp.dart';
import 'package:mytradeasia/features/domain/usecases/sales_force_data_usecases/create_sales_force_account.dart';
import 'package:mytradeasia/features/domain/usecases/sales_force_data_usecases/create_sales_force_opportunity.dart';
import 'package:mytradeasia/features/domain/usecases/sales_force_data_usecases/get_sales_force_cp.dart';
import 'package:mytradeasia/features/domain/usecases/sales_force_data_usecases/get_sales_force_opportunity.dart';
import 'package:mytradeasia/features/domain/usecases/searates_usecases/get_searates_route.dart';
import 'package:mytradeasia/features/domain/usecases/searates_usecases/track_by_bl.dart';
import 'package:mytradeasia/features/domain/usecases/list_product_usecases/get_list_product.dart';
import 'package:mytradeasia/features/domain/usecases/rfq_usecases/submit_rfq.dart';
import 'package:mytradeasia/features/domain/usecases/sales_force_data_usecases/get_sales_force_data.dart';
import 'package:mytradeasia/features/domain/usecases/sales_force_detail_usecases/get_sales_force_detail.dart';
import 'package:mytradeasia/features/domain/usecases/sales_force_login_usecases/get_sales_force_login.dart';
import 'package:mytradeasia/features/domain/usecases/search_product_usecases/get_search_product.dart';
import 'package:mytradeasia/features/domain/usecases/top_product_usecases/get_top_product.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/add_recently_seen.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/check_user_exist.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/delete_account.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/delete_recently_seen.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/get_current_userid.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/get_recently_seen.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/get_user_credentials.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/get_user_data.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/get_user_snapshot.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/login.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/login_sales.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/logout.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/phone_authentication.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/register.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/send_reset_pass.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/sso_register_user.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/update_email.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/update_profile.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/user_usecase_index.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/verify_otp.dart';
import 'package:mytradeasia/features/domain/usecases/user_usecases/google_auth.dart';
import 'package:mytradeasia/features/presentation/state_management/auth_bloc/auth_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/cart_bloc/cart_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/category_bloc/category_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/countries_bloc/countries_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/dhl_shipment_bloc/dhl_shipment_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/dropdown_currency_bloc/dropdown_currency_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/dropdown_incoterm_bloc/dropdown_incoterm_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/dropdown_uom_bloc/dropdown_uom_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/home_bloc/home_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/industry_bloc/industry_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/faq_bloc/faq_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/product_bloc/detail_product_bloc/detail_product_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/product_bloc/list_product/list_product_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/product_bloc/search_product/search_product_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/quotations_bloc/quotations_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/recently_seen_bloc/recently_seen_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/rfq_bloc/rfq_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/salesforce_bloc/salesforce_data/salesforce_data_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/salesforce_bloc/salesforce_detail/salesforce_detail_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/salesforce_bloc/salesforce_login/salesforce_login_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/searates_bloc/searates_bl/searates_bl_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/searates_bloc/searates_route/searates_route_bloc.dart';
import 'package:mytradeasia/features/presentation/state_management/top_products_bloc/top_products_bloc.dart';

final injections = GetIt.instance;

Future<void> initializeDependencies() async {
  //Services Dependencies
  injections.registerSingleton<AllIndustryService>(AllIndustryService());
  injections.registerSingleton<DetailProductService>(DetailProductService());
  injections.registerSingleton<DhlShipmentService>(DhlShipmentService());
  injections.registerSingleton<FaqService>(FaqService());
  injections.registerSingleton<ListProductService>(ListProductService());
  injections.registerSingleton<SalesforceDataService>(SalesforceDataService());
  injections
      .registerSingleton<SalesforceDetailService>(SalesforceDetailService());
  injections
      .registerSingleton<SalesforceLoginService>(SalesforceLoginService());
  injections.registerSingleton<SearchProductService>(SearchProductService());
  injections.registerSingleton<TopProductsService>(TopProductsService());
  injections.registerSingleton<AuthUserFirebase>(AuthUserFirebase());
  injections.registerSingleton<RfqService>(RfqService());
  injections.registerSingleton<CartFirebase>(CartFirebase());
  injections.registerSingleton<SearatesService>(SearatesService());
  injections.registerSingleton<CountryService>(CountryService());
  injections.registerSingleton<QuoteService>(QuoteService());
  injections.registerSingleton<CategoryService>(CategoryService());
  injections.registerSingleton<HomeService>(HomeService());
  injections.registerSingleton<OtpService>(OtpService());
  injections.registerSingleton<DropdownService>(DropdownService());
  injections.registerSingleton<RecentlySeenProductService>(
      RecentlySeenProductService());
  injections.registerSingleton<AuthService>(AuthService());

  //Repositories Dependencies
  injections.registerSingleton<DetailProductRepository>(
      DetailProductRepositoryImpl(injections()));
  injections.registerSingleton<DhlShipmentRepo>(
      DhlShipmentRepositoryImpl(injections()));
  injections.registerSingleton<FaqRepository>(FaqRepositoryImpl(injections()));
  injections.registerSingleton<IndustryRepository>(
      IndustryRepositoryImpl(injections()));
  injections.registerSingleton<ListProductRepository>(
      ListProductRepositoryImpl(injections()));
  injections.registerSingleton<SalesForceDataRepository>(
      SalesforceDataRepositoryImpl(injections()));
  injections.registerSingleton<SalesForceDetailRepo>(
      SalesforceDetailRepositoryImpl(injections()));
  injections.registerSingleton<SalesforceLoginRepo>(
      SalesforceLoginRepositoryImpl(injections()));
  injections.registerSingleton<SearchProductRepo>(
      SearchProductRepositoryImpl(injections()));
  injections.registerSingleton<TopProductRepository>(
      TopProductRepositoryImpl(injections()));
  injections.registerSingleton<UserRepository>(
      UserRepositoryImpl(injections(), injections(), injections()));
  injections.registerSingleton<RfqRepository>(RfqRepositoryImpl(injections()));
  injections
      .registerSingleton<CartRepository>(CartRepositoryImpl(injections()));
  injections.registerSingleton<SearatesRepository>(
      SearatesRepositoryImpl(injections()));
  injections
      .registerSingleton<CountryRepository>(CountryRepoImpl(injections()));
  injections
      .registerSingleton<QuoteRepository>(QuoteRepositoryImpl(injections()));
  injections.registerSingleton<CategoryRepository>(
      CategoryRepositoryImpl(injections()));
  injections
      .registerSingleton<HomeRepository>(HomeRepositoryImpl(injections()));
  injections.registerSingleton<OTPRepository>(OTPRepositoryImpl(injections()));
  injections.registerSingleton<DropdownRepository>(
      DropdownRepositoryImpl(injections()));

  //UseCases Dependencies
  injections
      .registerSingleton<GetDetailProduct>(GetDetailProduct(injections()));
  injections.registerSingleton<GetDhlShipment>(GetDhlShipment(injections()));
  injections.registerSingleton<GetFaqData>(GetFaqData(injections()));
  injections.registerSingleton<GetIndustryData>(GetIndustryData(injections()));
  injections.registerSingleton<GetListProduct>(GetListProduct(injections()));
  injections
      .registerSingleton<GetSalesForceData>(GetSalesForceData(injections()));
  injections.registerSingleton<GetSalesForceCP>(GetSalesForceCP(injections()));
  injections.registerSingleton<GetSalesforceDetail>(
      GetSalesforceDetail(injections()));
  injections
      .registerSingleton<GetSalesforceLogin>(GetSalesforceLogin(injections()));
  injections
      .registerSingleton<GetSearchProduct>(GetSearchProduct(injections()));
  injections.registerSingleton<GetTopProductUseCase>(
      GetTopProductUseCase(injections()));
  injections.registerSingleton<RegisterUser>(RegisterUser(injections()));
  injections.registerSingleton<SSORegisterUser>(SSORegisterUser(injections()));

  injections.registerSingleton<LoginUser>(LoginUser(injections()));
  injections.registerSingleton<LoginSales>(LoginSales(injections()));

  injections
      .registerSingleton<SubmitRfqUseCase>(SubmitRfqUseCase(injections()));
  injections.registerSingleton<GetUserSnapshot>(GetUserSnapshot(injections()));
  injections
      .registerSingleton<GetCurrentUserId>(GetCurrentUserId(injections()));
  injections.registerSingleton<AddRecentlySeen>(AddRecentlySeen(injections()));
  injections.registerSingleton<GetCart>(GetCart(injections()));
  injections.registerSingleton<GetRecentlySeen>(GetRecentlySeen(injections()));
  injections.registerSingleton<GetUserData>(GetUserData(injections()));
  injections.registerSingleton<AddCart>(AddCart(injections()));
  injections.registerSingleton<DeleteCartItem>(DeleteCartItem(injections()));
  injections.registerSingleton<UpdateCart>(UpdateCart(injections()));
  injections.registerSingleton<LogOutUser>(LogOutUser(injections()));
  injections
      .registerSingleton<GetUserCredentials>(GetUserCredentials(injections()));
  injections.registerSingleton<UpdateProfile>(UpdateProfile(injections()));
  injections.registerSingleton<PhoneAuthentication>(
      PhoneAuthentication(injections()));
  injections.registerSingleton<VerifyOtp>(VerifyOtp(injections()));
  injections
      .registerSingleton<GetSearatesRoute>(GetSearatesRoute(injections()));
  injections.registerSingleton<TrackByBL>(TrackByBL(injections()));
  injections.registerSingleton<SendResetPass>(SendResetPass(injections()));
  injections.registerSingleton<DeleteAccount>(DeleteAccount(injections()));
  injections.registerSingleton<UpdateEmail>(UpdateEmail(injections()));
  injections
      .registerSingleton<DeleteRecentlySeen>(DeleteRecentlySeen(injections()));
  injections.registerSingleton<CreateSalesForceAccount>(
      CreateSalesForceAccount(injections()));
  injections.registerSingleton<CreateSalesForceOpportunity>(
      CreateSalesForceOpportunity(injections()));
  injections
      .registerSingleton<GetCountryUsecase>(GetCountryUsecase(injections()));
  injections.registerSingleton<GetSalesForceOpportunity>(
      GetSalesForceOpportunity(injections()));
  injections.registerSingleton<SearchCountryUsecase>(
      SearchCountryUsecase(injections()));
  injections.registerSingleton<GetRfqList>(GetRfqList(injections()));
  injections.registerSingleton<GetQuote>(GetQuote(injections()));
  injections.registerSingleton<ApproveQuote>(ApproveQuote(injections()));
  injections.registerSingleton<RejectQuote>(RejectQuote(injections()));
  injections
      .registerSingleton<GetCategoryUseCase>(GetCategoryUseCase(injections()));
  injections.registerSingleton<GetHomeData>(GetHomeData(injections()));
  injections.registerSingleton<SendOTP>(SendOTP(injections()));
  injections.registerSingleton<VerifyOTP>(VerifyOTP(injections()));
  injections
      .registerSingleton<GetIncotermUsecase>(GetIncotermUsecase(injections()));
  injections
      .registerSingleton<GetCurrencyUsecase>(GetCurrencyUsecase(injections()));
  injections.registerSingleton<GetUomUsecase>(GetUomUsecase(injections()));
  injections
      .registerSingleton<UserUsecaseIndex>(UserUsecaseIndex(injections()));
  injections.registerSingleton<GoogleAuth>(GoogleAuth(injections()));
  injections.registerSingleton<CheckUserExist>(CheckUserExist(injections()));

  //Bloc
  injections
      .registerFactory<ListProductBloc>(() => ListProductBloc(injections()));
  injections.registerFactory<IndustryBloc>(() => IndustryBloc(injections()));
  injections.registerFactory<SearchProductBloc>(
      () => SearchProductBloc(injections()));

  injections.registerFactory<FaqBloc>(() => FaqBloc(injections()));
  injections
      .registerFactory<TopProductBloc>(() => TopProductBloc(injections()));
  injections
      .registerFactory<DhlShipmentBloc>(() => DhlShipmentBloc(injections()));
  injections.registerFactory<DetailProductBloc>(
      () => DetailProductBloc(injections()));
  injections.registerFactory<SalesforceLoginBloc>(
      () => SalesforceLoginBloc(injections()));
  injections.registerFactory<SalesforceDataBloc>(() => SalesforceDataBloc(
      injections(), injections(), injections(), injections(), injections()));
  injections.registerFactory<SalesforceDetailBloc>(
      () => SalesforceDetailBloc(injections()));
  injections.registerFactory<AuthBloc>(() => AuthBloc(injections()));
  injections.registerFactory<CartBloc>(
      () => CartBloc(injections(), injections(), injections(), injections()));
  // injections
  //     .registerFactory<ChannelListBloc>(() => ChannelListBloc(injections()));
  injections.registerFactory<SearatesRouteBloc>(
      () => SearatesRouteBloc(injections()));
  injections
      .registerFactory<SearatesBLBloc>(() => SearatesBLBloc(injections()));
  injections.registerFactory<RecentlySeenBloc>(
      () => RecentlySeenBloc(injections(), injections(), injections()));
  injections.registerFactory<CountriesBloc>(
      () => CountriesBloc(injections(), injections()));
  injections.registerFactory<RfqBloc>(() => RfqBloc(injections()));
  injections.registerFactory<QuotationBloc>(() => QuotationBloc(injections()));
  injections.registerFactory<CategoryBloc>(() => CategoryBloc(injections()));
  injections.registerFactory<HomeBloc>(() => HomeBloc(injections()));
  injections.registerFactory<DropdownIncotermBloc>(
      () => DropdownIncotermBloc(injections()));
  injections.registerFactory<DropdownCurrencyBloc>(
      () => DropdownCurrencyBloc(injections()));
  injections
      .registerFactory<DropdownUomBloc>(() => DropdownUomBloc(injections()));
}
