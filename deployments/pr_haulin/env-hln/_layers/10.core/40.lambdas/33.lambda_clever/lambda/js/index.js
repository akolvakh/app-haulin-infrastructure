exports.handler = async (event) => {
    const url = process.env.URL;
    const response = {
        statusCode: 302,
        headers: 
        {
            Location: url,
        }
        };
    return response;
};
