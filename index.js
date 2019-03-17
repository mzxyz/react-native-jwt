
import { NativeModules } from 'react-native';
import { Buffer } from 'buffer';

const { RNJWT } = NativeModules;

const base64ToJson = base64String => {
  const jsonString = Buffer.from(base64String, 'base64').toString('utf8');
  return JSON.parse(jsonString);
};

const decodeToken = (token) => {
  if (typeof token !== 'string') {
    throw new Error('Invalid token specified')
  }

  const parts = token.split('.');
  if (parts.length !== 3) {
    throw new Error('jwt malformed')
  }

  const header = parts[0];
  const claims = parts[1];
  const signature = parts[2];

  const { typ, alg } = base64ToJson(header);
  if (typ !== 'JWT') {
    throw new Error('Invalid jwt token');
  }

  return {
    alg,
    header,
    claims,
    signature,
  };
};

export const verify = (token, key) => {
  const { alg, header, claims, signature } = decodeToken(token);
  const content = `${header}.${claims}`;
  const decodedPayload = base64ToJson(claims);

  return RNJWT
          .verify(content, key, signature, alg)
          .then((verified) => verified ? decodedPayload : null );
}
