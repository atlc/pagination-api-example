const esbuild = require('esbuild');
const { createServer, request } = require('http');
const { spawn } = require('child_process');

const clients = new Set();

let ctx;

async function build() {
  try {
    ctx = await esbuild.context({
      entryPoints: ['src/server.ts'],
      bundle: true,
      outfile: 'dist/bundle.js',
      sourcemap: true,
      platform: 'node',
      target: ['node18'],
      plugins: [{
        name: 'live-reload',
        setup(build) {
          build.onEnd(result => {
            clients.forEach(res => res.write('data: update\n\n'));
            if (result.errors.length === 0) {
              console.log('Build succeeded');
              if (serverProcess) {
                serverProcess.kill();
                startServer();
              }
            } else {
              console.error('Build failed:', result.errors);
            }
          });
        },
      }],
    });

    await ctx.watch();
    console.log('Watching for changes...');

  } catch (err) {
    console.error('Build failed:', err);
    process.exit(1);
  }
}

let serverProcess;
function startServer() {
  serverProcess = spawn('node', ['dist/bundle.js'], {
    stdio: 'inherit',
  });
}

build().then(() => {
  startServer();
});

createServer((req, res) => {
  if (req.url === '/esbuild') {
    return res.end('ok');
  }

  res.writeHead(200, {
    'Content-Type': 'text/event-stream',
    'Cache-Control': 'no-cache',
    'Access-Control-Allow-Origin': '*',
    'Connection': 'keep-alive',
  });

  clients.add(res);
  req.on('close', () => clients.delete(res));
}).listen(8082);

console.log('Development server started at http://localhost:8082');

process.on('SIGTERM', shutdown);
process.on('SIGINT', shutdown);

async function shutdown() {
  console.log('Shutting down...');
  if (ctx) {
    await ctx.dispose();
  }
  if (serverProcess) {
    serverProcess.kill();
  }
  process.exit(0);
} 