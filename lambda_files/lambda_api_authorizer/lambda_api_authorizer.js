
// A simple token-based authorizer example to demonstrate how to use an authorization token 
// to allow or deny a request. In this example, the caller named 'user' is allowed to invoke 
// a request if the client-supplied token value is 'allow'. The caller is not allowed to invoke 
// the request if the token value is 'deny'. If the token value is 'unauthorized' or an empty
// string, the authorizer function returns an HTTP 401 status code. For any other token value, 
// the authorizer returns an HTTP 500 status code. 
// Note that token values are case-sensitive.

exports.handler =  function(event, context, callback) {
  var token = event.authorizationToken;
  switch (token) {
      case 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoic2FmcmEtc2VjcmV0IiwianRpIjoiMTcwNjBkMzktZTc3Yi00Y2YxLTgxYWUtNGY4MmM0ODg3NjMxIiwiaWF0IjoxNTk5ODgyNDI2LCJleHAiOjE1OTk4ODYwMjZ9.f-LhhN5uLcpVCGldireDayaAJsfSWhYlxI11wAinIac':
          callback(null, generatePolicy('user', 'Allow', event.methodArn));
          break;
      default:
          callback("Error: Invalid token"); // Return a 500 Invalid token response
  }
};

// Help function to generate an IAM policy
var generatePolicy = function(principalId, effect, resource) {
  var authResponse = {};
  var resourceItems = resource.split("/");
  var resourcePolicy = resourceItems[0]+"/"+resourceItems[1]+"/*/*";

  authResponse.principalId = principalId;
  if (effect && resource) {
      var policyDocument = {};
      policyDocument.Version = '2012-10-17'; 
      policyDocument.Statement = [];
      var statementOne = {};
      statementOne.Action = 'execute-api:Invoke'; 
      statementOne.Effect = effect;
      statementOne.Resource = resourcePolicy;
      policyDocument.Statement[0] = statementOne;
      authResponse.policyDocument = policyDocument;
  }
  return authResponse;
}