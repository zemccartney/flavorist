#!/usr/bin/env node

const Bossy = require('bossy');
const ChildProcess = require('child_process');

// TODO SUPPORT ACCEPTING A CUSTOM COMMIT MESSAGE!!!
// MAKE IT REQUIRED; GIT REQUIRES IT!!!
const argvSchema = {
    h: {
        description: 'Show help',
        alias: 'help',
        type: 'boolean',
        default: undefined
    },
    // TODO Do we need this?
    v: {
        description: 'Version number, to pair with a descriptive name set in the first arg position',
        alias: 'version',
        type: 'string'
    },
    r: {
        description: 'Remote to which the new tags will be published',
        alias: 'remote',
        type: 'string',
        default: 'origin'
    },
    // TODO Do we need this option?
    m: {
        description: 'Branch you',
        alias: 'master',
        type: 'string',
        default: 'master'
    }
};

const args = Bossy.parse(argvSchema);

if (args.h || (!args._ || !args._[0])) {
    console.log(`\n*** UNEXPECTED USAGE *** \n ${Bossy.usage(argvSchema, '\nflavorist <tagName>')}`);
    return;
}

const { version, remote, master } = args;
const tagName = args._[0];

const params = Object.keys(argvSchema)
  .filter((key) => !(args[key] === undefined || args[key] === false))
  .map((key) => `-${key} ${args[key]}`)
  .join(' ');

// TODO Will this path work when executed remotely?
// TODO Will file permissions be a problem for using this file? Or will they be set
// according to installee's access on install?
const command = `${__dirname}/git-tag.sh ${tagName} ${params}`;

ChildProcess.exec(command, (err, stdout, stderr) => {
  // TODO Below's plagiarized from Node's docs: https://nodejs.org/api/child_process.html#child_process_child_process_exec_command_options_callback
  // What do we need here?
  if (err) {
    console.error(`exec error: ${err}`);
    return;
  }
  console.log(`stdout: ${stdout}`);
  console.log(`stderr: ${stderr}`);
});

// npx flavorist name -v version -r origin -m master
// npx flavorist swagger -v 2.1.4 -m pal

// node ../../cli.js swagger -v 2.1.4 -m pal
