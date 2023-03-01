interface APIGatewayProxyResult {
  statusCode: number;
  headers?: {
    [header: string]: boolean | number | string;
  };
  multiValueHeaders?: {
    [header: string]: Array<boolean | number | string>;
  };
  body: string;
  isBase64Encoded?: boolean;
}

export interface HttpEventRequest<T = unknown> {
  args: T;
  context?: {
    identity?: {
      sub?: string;
    };
  };
  source: string;
}

export type HttpResponse = Promise<APIGatewayProxyResult>;
