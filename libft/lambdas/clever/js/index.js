exports.handler = async (event) => {
    const response = {
        statusCode: 302,
        headers: 
        {
            Location: "https://uss-staging.auth.us-east-1.amazoncognito.com/oauth2/authorize?response_type=code&client_id=793776eqmckf7u7ujia8hrmee6&redirect_uri=https%3A%2F%2Fmytutorlearning.co%2Fauth%2Flogin&state=qweqw2131a123a1231212&identity_provider=Clever&scope=aws.cognito.signin.user.admin+openid+profile",
        }
        };
    return response;
};
