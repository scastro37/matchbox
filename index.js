const shell = require('shelljs');

shell.chmod('+x','./files-config.sh')
shell.exec('./files-config.sh '+process.argv[2]);
