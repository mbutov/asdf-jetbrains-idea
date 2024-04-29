<div align="center">

# asdf-jetbrains-idea [![Build](https://github.com/mbutov/asdf-jetbrains-idea/actions/workflows/build.yml/badge.svg)](https://github.com/mbutov/asdf-jetbrains-idea/actions/workflows/build.yml) [![Lint](https://github.com/mbutov/asdf-jetbrains-idea/actions/workflows/lint.yml/badge.svg)](https://github.com/mbutov/asdf-jetbrains-idea/actions/workflows/lint.yml)

[jetbrains-idea](https://github.com/mbutov/asdf-jetbrains-idea) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add jetbrains-idea
# or
asdf plugin add jetbrains-idea https://github.com/mbutov/asdf-jetbrains-idea.git
```

jetbrains-idea:

```shell
# Show all installable versions
asdf list-all jetbrains-idea

# Install specific version
asdf install jetbrains-idea latest

# Set a version globally (on your ~/.tool-versions file)
asdf global jetbrains-idea latest

# Now jetbrains-idea commands are available
idea.sh --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/mbutov/asdf-jetbrains-idea/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Maxim Butov](https://github.com/mbutov/)
