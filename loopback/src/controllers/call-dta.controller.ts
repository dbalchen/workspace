import {Request, RestBindings, get, ResponseObject} from '@loopback/rest';
import {inject} from '@loopback/core';

const SPOOGE_RESPONSE: ResponseObject = {
  description: 'Spooge Response',
  content: {
    'application/json': {
      schema: {
        type: 'object',
        title: 'Spooge Response',
        properties: {
          greeting: {type: 'string'},
          date: {type: 'string'},
          url: {type: 'string'},
          headers: {
            type: 'object',
            properties: {
              'Content-Type': {type: 'string'},
            },
            additionalProperties: true,
          },
        },
      },
    },
  },
};

/**
 * A simple controller to bounce back http requests
 */
export class SpoogeController {
  constructor(@inject(RestBindings.Http.REQUEST) private req: Request) {}

  // Map to `GET /ping`
  @get('/spooge', {
    responses: {
      '200': SPOOGE_RESPONSE,
    },
  })
  spooge(): object {
    // Reply with a greeting, the current time, the url, and request headers
    return {
      greeting: 'Hello from Spooge LoopBack',
      date: new Date(),
      url: this.req.url,
      headers: Object.assign({}, this.req.headers),
    };
  }
}
