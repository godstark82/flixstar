const fs = require('fs');
const yaml = require('js-yaml');

try {
  const pubspec = yaml.load(fs.readFileSync('pubspec.yaml', 'utf8'));
  console.log(`::set-output name=version::${pubspec.version}`);
} catch (e) {
  console.error(e);
  process.exit(1);
}
