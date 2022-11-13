const Hapi = require('hapi');

const server = Hapi.server({
    port: 4000,
    routes: { cors: { origin: ['*'] } },
    host: '0.0.0.0'
});

server.route({
    method: 'GET',
    path: '/happy/',
    handler: (request, h) => {
        return 'Hey folks, I am HAPI!';
    }
});

server.route({
    method: 'GET',
    path: '/happy/{name}',
    handler: (request, h) => {
        return 'Hello, ' + encodeURIComponent(request.params.name) + '!';
    }
});

server.route({  
  method: 'GET',
  path: '/happy/multiply',
  handler: (request, h) => {
    const params = request.query
    const result = params.num1 * params.num2;
    return result;
  }
});

server.route({  
  method: 'GET',
  path: '/happy/divide',
  handler: (request, h) => {
    const params = request.query
    const result = params.num1 / params.num2;
    return result;
  }
});

server.route({
    method: 'GET',
    path: '/happy/healthz',
    handler: (request, h) => {
        return 'I am healthy!';
    }
});

server.events.on('response', function (request) {
    console.log(request.info.remoteAddress + ': ' + request.method.toUpperCase() + ' ' + request.url.path + ' --> ' + request.response.statusCode);
});

const init = async () => {
    await server.start();
    console.log(`Server running at: ${server.info.uri}`);
};

process.on('unhandledRejection', (err) => {
    console.log(err);
    process.exit(1);
});

init();