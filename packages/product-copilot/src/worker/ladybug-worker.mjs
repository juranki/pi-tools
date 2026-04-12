import readline from 'node:readline';

function send(message) {
  process.stdout.write(`${JSON.stringify(message)}\n`);
}

const rl = readline.createInterface({
  input: process.stdin,
  crlfDelay: Infinity,
});

send({
  type: 'ready',
  ok: true,
  pid: process.pid,
  note: 'Product Copilot Ladybug worker scaffold is ready.',
});

rl.on('line', (line) => {
  let message;
  try {
    message = JSON.parse(line);
  } catch (error) {
    send({
      ok: false,
      error: 'invalid_json',
      details: String(error),
    });
    return;
  }

  if (message.type === 'ping') {
    send({
      id: message.id,
      ok: true,
      result: {
        pong: true,
        pid: process.pid,
      },
    });
    return;
  }

  if (message.type === 'describe') {
    send({
      id: message.id,
      ok: true,
      result: {
        pid: process.pid,
        cwd: process.cwd(),
        note: 'Scaffold worker only. LadybugDB ownership is not wired yet.',
      },
    });
    return;
  }

  send({
    id: message.id,
    ok: false,
    error: `unknown_message_type:${String(message.type)}`,
  });
});
