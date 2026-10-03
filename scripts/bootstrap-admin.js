const readline = require('node:readline/promises');
const { stdin, stdout } = require('node:process');

function promptHidden(label) {
    if (!stdin.isTTY || typeof stdin.setRawMode !== 'function') {
        return Promise.reject(new Error('Run this script from an interactive terminal.'));
    }

    return new Promise((resolve, reject) => {
        let value = '';
        const onData = chunk => {
            for (const character of chunk.toString('utf8')) {
                if (character === '\u0003') {
                    cleanup();
                    reject(new Error('Input cancelled.'));
                    return;
                }
                if (character === '\r' || character === '\n') {
                    cleanup();
                    stdout.write('\n');
                    resolve(value);
                    return;
                }
                if (character === '\u007f' || character === '\b') {
                    value = value.slice(0, -1);
                } else if (character >= ' ') {
                    value += character;
                }
            }
        };
        const cleanup = () => {
            stdin.off('data', onData);
            stdin.setRawMode(false);
            stdin.pause();
        };

        stdout.write(label);
        stdin.setRawMode(true);
        stdin.setEncoding('utf8');
        stdin.resume();
        stdin.on('data', onData);
    });
}

async function main() {
    const prompt = readline.createInterface({ input: stdin, output: stdout });
    let username;
    let firstName;
    let lastName;
    let email;
    try {
        username = await prompt.question('Admin username (max 10 characters): ');
        firstName = await prompt.question('First name: ');
        lastName = await prompt.question('Last name: ');
        email = await prompt.question('Email: ');
    } finally {
        prompt.close();
    }

    const password = await promptHidden('Admin password (minimum 12 characters): ');
    const confirmation = await promptHidden('Confirm password: ');
    if (password !== confirmation) {
        throw new Error('Passwords do not match.');
    }

    const endpoint = process.env.AUTH_API_URL ||
        'http://localhost:4004/odata/v4/authentication/bootstrapAdmin';
    const response = await fetch(endpoint, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Accept: 'application/json' },
        body: JSON.stringify({ username, password, firstName, lastName, email })
    });
    const result = await response.json().catch(() => ({}));
    if (!response.ok) {
        throw new Error(result.error?.message || `Bootstrap failed with HTTP ${response.status}.`);
    }

    console.log(`Created administrator account: ${result.id || username}`);
    console.log('You can now sign in at http://localhost:4004/login.html.');
}

main().catch(error => {
    console.error(error.message);
    process.exitCode = 1;
});