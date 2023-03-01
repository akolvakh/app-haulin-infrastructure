import { default as axios } from 'axios';

const { SERVER_ORIGIN } = process.env;

export const preSignUpHandler = async (event, context, callback) => {
  if (SERVER_ORIGIN === undefined || SERVER_ORIGIN === null) {
    throw new Error(`Server origin undefined`);
  }

  const {
    request: {
      userAttributes: { email },
    },
  } = event;

  console.log('request url -', `${SERVER_ORIGIN}/accounts`);

  let res;
  try {
    res = await axios.get(`${SERVER_ORIGIN}/accounts`, {
      params: {
        email,
      },
      timeout: 30000,
    });
  } catch (e) {
    throw new Error(JSON.stringify(e, null, 2));
  }

  console.log('res -', res);

  const { data: accounts } = res;

  if (accounts && accounts.length) {
    throw new Error('Account with such email already exist');
  }

  console.log('event -', event);

  if (event.request.userAttributes.hasOwnProperty('email')) {
    event.response.autoVerifyEmail = true;
  }

  // Set the phone number as verified if it is in the request
  if (event.request.userAttributes.hasOwnProperty('phone_number')) {
    event.response.autoVerifyPhone = true;
  }

  event.response.autoConfirmUser = true;
  return event;
};
