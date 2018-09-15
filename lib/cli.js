#!/usr/bin/env node
'use strict';

const Bossy = require('bossy');
const ChildProcess = require('child_process');

const argvSchema = {
    h: {
        description: 'Show help',
        alias: 'help',
        type: 'boolean',
        default: undefined
    },
    v: {
        description: 'Version number, to pair with a descriptive name set in the first arg position',
        alias: 'version',
        type: 'string'
    },
    // TODO SUPPORT ACCEPTING A CUSTOM COMMIT MESSAGE!!!
    // MAKE IT REQUIRED; GIT REQUIRES IT!!!
    m: {
        description: `Message with which to annotate your tag. In flavor mode, this will
        double as the commit message for the squashed commit`,
        alias: 'message',
        type: 'string'
    },
    r: {
        description: `The remote repository to which your new tag(s) will be published. In flavor mode,
        this is also the repository whose target branch you'll reset to before tagging`,
        alias: 'remote',
        type: 'string',
        default: 'origin'
    },
    f: {
        description: 'Runs the tool in flavor mode',
        alias: 'flavor',
        type: 'boolean',
        default: 'false'
    },
    b: {
        description: 'Branch you intend to extend with the new flavor tag (applied in flavor mode only)',
        alias: 'branch',
        type: 'string',
        default: 'master'
    }
};

const args = Bossy.parse(argvSchema);

if (args.h || (!args._ || !args._[0])) {
    // TODO Conditionalize display of input error
    console.log(`\n*** UNEXPECTED USAGE *** \n ${Bossy.usage(argvSchema, '\nflavorist <tagName> -m <message>')}`);
    return;
}

const tagName = args._[0];
const params = Object.keys(argvSchema)
    .filter((key) => !(args[key] === undefined || args[key] === false))
    .map((key) => `-${key} ${args[key]}`)
    .join(' ');

const command = `${__dirname}/git-tag ${tagName} ${params}`;

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
