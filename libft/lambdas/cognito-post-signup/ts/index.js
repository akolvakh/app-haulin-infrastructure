import { default as axios } from 'axios';

const { SERVER_ORIGIN } = process.env;

export const postSignUpHandler = async (context) => {
  if (SERVER_ORIGIN === undefined || SERVER_ORIGIN === null) {
    throw new Error(`Server origin undefined`);
  }

  const {
    request: { userAttributes },
  } = context;

  console.log('context -', JSON.stringify(context, null, 4));

  console.log('request url -', `${SERVER_ORIGIN}/accounts`);

  let res;
  try {
    res = await axios.post(
      `${SERVER_ORIGIN}/accounts`,
      {
        id: userAttributes.sub,
        email: userAttributes.email,
      },
      { timeout: 30000 },
    );
  } catch (e) {
    throw new Error(JSON.stringify(res, null, 2));
  }

  console.log('res -', res);

  return context;
};
