// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:bapenda_getx2/app/modules/auth/service/auth_cache_service.dart';
import 'package:bapenda_getx2/utils/app_const.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLClientService with AuthCacheService {
  // static HttpLink httpLink = HttpLink('https://api-engine-xopsapi.apps-ocp.gmf-aeroasia.co.id/v1/graphql');
  HttpLink? _httpLink;
  WebSocketLink? _webSocketLink;
  AuthLink? _authLink;
  Link? _link;

  _getGraphQLAccessToken() async {
    _httpLink = HttpLink(GRAPHQL_HTTP_LINK);
    _webSocketLink = WebSocketLink(
      GRAPHQL_WS_LINK,
      config: SocketClientConfig(
          autoReconnect: true,
          inactivityTimeout: const Duration(seconds: 30),
          initialPayload: {
            "headers": {
              "Authorization": "Bearer " + getToken()!,
              // "x-hasura-admin-secret": GRAPHQL_ADMIN_SECRET
            }
          }),
    );
    _authLink = AuthLink(getToken: () => "Bearer " + getToken()!);
    _link = _authLink!.concat(_httpLink!).concat(_webSocketLink!);
  }

  final policies = Policies(
    fetch: FetchPolicy.networkOnly,
  );

  GraphQLClient _client() {
    _getGraphQLAccessToken();
    return GraphQLClient(
        link: Link.split(
            (request) => request.isSubscription, _webSocketLink!, _link!),
        cache: GraphQLCache(
          store: null, //HiveStore(),
        ),
        defaultPolicies: DefaultPolicies(
          watchQuery: policies,
          query: policies,
          mutate: policies,
          subscribe: policies,
        ));
  }

  /// Start Query
  Future<QueryResult> query(
      {required String query, Map<String, dynamic>? variables}) async {
    await _getGraphQLAccessToken();

    final WatchQueryOptions _options = WatchQueryOptions(
      document: gql(query),
      pollInterval: const Duration(seconds: 10),
      fetchResults: true,
      variables: variables as Map<String, dynamic>,
    );

    return await _client().query(_options);
  }

  /// Start mutation
  Future<QueryResult> mutation(
      {required String queries, Map<String, dynamic>? variables}) async {
    final MutationOptions _options = MutationOptions(
      document: gql(queries),
      variables: variables as Map<String, dynamic>,
    );
    return await _client().mutate(_options);
  }

  /// Start subscription
  Stream<QueryResult> subscription(
      {required String queries, Map<String, dynamic>? variables}) {
    final SubscriptionOptions _options = SubscriptionOptions(
      document: gql(queries),
      variables: variables as Map<String, dynamic>,
    );
    return _client().subscribe(_options);
  }

  /// Handle exception
  void handleException(QueryResult queryResult) {
    if (queryResult.exception?.linkException is HttpLinkServerException) {
      HttpLinkServerException httpLink =
          queryResult.exception?.linkException as HttpLinkServerException;
      if (httpLink.parsedResponse?.errors?.isNotEmpty == true) {}

      return;
    }
    if (queryResult.exception?.linkException is NetworkException) {
      NetworkException networkException =
          queryResult.exception?.linkException as NetworkException;
      return;
    }
  }
}
