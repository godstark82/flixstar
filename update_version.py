import re

def increment_build_number(version):
    major, minor, patch_build = version.split('.')
    patch, build = patch_build.split('+')
    build = int(build) + 1
    return f"{major}.{minor}.{patch}+{build}"

def main():
    with open('pubspec.yaml', 'r') as file:
        content = file.read()

    version_pattern = re.compile(r'version: (\d+\.\d+\.\d+\+\d+)')
    match = version_pattern.search(content)
    if not match:
        print("No version found in pubspec.yaml")
        return

    old_version = match.group(1)
    new_version = increment_build_number(old_version)
    print(f"Updating version from {old_version} to {new_version}")

    updated_content = version_pattern.sub(f"version: {new_version}", content)
    with open('pubspec.yaml', 'w') as file:
        file.write(updated_content)

if __name__ == "__main__":
    main()
