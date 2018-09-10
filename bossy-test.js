const Bossy = require('bossy');
const ChildProcess = require('child_process');

const argvSchema = {
    h: {
        description: 'Show help',
        alias: 'help',
        type: 'boolean'
    },
    // TODO Do we need this?
    v: {
        description: 'Version number, to pair with a descriptive name set in the first arg position',
        alias: 'version',
        type: 'number'
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
const shellArgs = [tagName, version, remote, master];

// TODO Will this path work when executed remotely?
console.log(`./flavor.sh ${tagName}${shellArgs.filter((arg) => arg !== undefined).join(' ')}`);


// npx flavorist name -v version -r origin -m master
// npx flavorist swagger -v 2.1.4 -m pal
