# clang in Docker

[![invasy/docker-remote-dev @ GitHub][badge-github]][github]
[![GitHub Workflow Status][badge-github-wf]][github-wf]

[![invasy/docker-remote-dev @ GitLab][badge-gitlab]][gitlab]
[![GitLab CI Pipeline Status][badge-gitlab-ci]][gitlab-ci]

[![invasy/docker-remote-dev @ Bitbucket][badge-bitbucket]][bitbucket]

[![invasy/remote-dev-clang @ DockerHub][badge-dockerhub]][dockerhub]
[![Docker Image Size (latest by date)][badge-size]][dockerhub]
[![Docker Pulls][badge-pulls]][dockerhub]

## Toolchain
| Tool                                     | Version                     |
|------------------------------------------|-----------------------------|
| [Debian] ([slim])                        | [11.4 (Bullseye)][bullseye] |
| [OpenSSH] server                         | 8.4p1                       |
| [rsync]                                  | 3.2.3                       |
| [GNU Make][make]                         | 4.3                         |
| [GNU Debugger][gdb] (gdb) with gdbserver | 10.1                        |
| [CMake]                                  | 3.22.5                      |
| [ninja]                                  | 1.11.0                      |
| [clang]/[llvm]                           | 14                          |

## Usage
1. Build image:
    ```bash
    make clang-build
    ```
2. Run service:
    ```bash
    make clang-up
    ```
3. Set up CLion toolchain (_see below_).
4. Build, run, debug your project using toolchain in the container.
5. Stop service:
    ```bash
    make clang-down
    ```

### CLion Configuration
#### Toolchains
![Toolchains](../images/clion-toolchains.png "Toolchains")

- **Name**: `remote-dev-clang`
- **Credentials**: _see **SSH Configurations** below_
- **CMake**: `/usr/local/bin/cmake`
- **Make**: `/usr/local/bin/ninja` (_see also **CMake** below_)
- **C Compiler**: `/usr/bin/clang-14` (_should be detected_)
- **C++ Compiler**: `/usr/bin/clang++-14` (_should be detected_)
- **Debugger**: `/usr/bin/gdb` (_should be detected_)

#### SSH Configurations
![SSH Configurations](../images/clion-ssh.png "SSH Configurations")

- **Host**: `127.0.0.1`
- **Port**: `22001`
- **Authentication type**: `Password`
- **User name**: `builder`
- **Password**: `builder`

#### CMake
![CMake](../images/clion-cmake.png "CMake")

- **Profiles**:
  - **Debug** (_or any other profile_):
    - **CMake options**: `-G Ninja`

## SSH
### Configuration
```
# ~/.ssh/config
Host remote-dev-clang
User builder
HostName 127.0.0.1
Port 22001
HostKeyAlias remote-dev-clang
StrictHostKeyChecking no
NoHostAuthenticationForLocalhost yes
PreferredAuthentications password
PasswordAuthentication yes
PubkeyAuthentication no
```

Remove old host key from `~/.ssh/known_hosts` after image rebuilding (_note `HostKeyAlias` in config above_):
```bash
ssh-keygen -f "$HOME/.ssh/known_hosts" -R 'remote-dev-clang'
```

### Connection
```bash
ssh remote-dev-clang
```
- User name: `builder`
- Password: `builder`

## See Also
- [Remote development | CLion](https://www.jetbrains.com/help/clion/remote-development.html "Remote development | CLion")
- [Using Docker with CLion — The CLion Blog](https://blog.jetbrains.com/clion/2020/01/using-docker-with-clion/ "Using Docker with CLion — The CLion Blog")

[github]: https://github.com/invasy/docker-remote-dev "invasy/docker-remote-dev @ GitHub"
[badge-github]: https://img.shields.io/badge/GitHub-invasy%2Fdocker--remote--dev-informational?logo=github "invasy/docker-remote-dev @ GitHub"
[github-wf]: https://github.com/invasy/docker-remote-dev/actions "GitHub Workflow Status"
[badge-github-wf]: https://github.com/invasy/docker-remote-dev/actions/workflows/docker.yml/badge.svg "GitHub Workflow Status"

[gitlab]: https://gitlab.com/invasy/docker-remote-dev "invasy/docker-remote-dev @ GitLab"
[badge-gitlab]: https://img.shields.io/badge/GitLab-invasy%2Fdocker--remote--dev-informational?logo=gitlab "invasy/docker-remote-dev @ GitLab"
[gitlab-ci]: https://gitlab.com/invasy/docker-remote-dev/-/pipelines/latest "GitLab CI Pipeline Status"
[badge-gitlab-ci]: https://gitlab.com/invasy/docker-remote-dev/badges/master/pipeline.svg "GitLab CI Pipeline Status"

[bitbucket]: https://bitbucket.org/invasy/docker-remote-dev "invasy/docker-remote-dev @ Bitbucket"
[badge-bitbucket]: https://img.shields.io/badge/Bitbucket-invasy%2Fdocker--remote--dev-informational?logo=bitbucket "invasy/docker-remote-dev @ Bitbucket"

[dockerhub]: https://hub.docker.com/r/invasy/remote-dev-clang "invasy/remote-dev-clang @ Docker Hub"
[badge-dockerhub]: https://img.shields.io/badge/Docker%20Hub-invasy%2Fremote--dev--clang-informational?logo=docker "invasy/remote-dev-clang @ Docker Hub"
[badge-size]: https://img.shields.io/docker/image-size/invasy/remote-dev-clang?sort=date "Docker Image Size (latest by date)"
[badge-pulls]: https://img.shields.io/docker/pulls/invasy/remote-dev-clang "Docker Pulls"

[Debian]: https://www.debian.org/ "Debian"
[bullseye]: https://www.debian.org/releases/bullseye/amd64/release-notes/index.en.html "Debian 11.4 (Bullseye) Release Notes"
[slim]: https://hub.docker.com/_/debian "Debian — Docker Hub"
[OpenSSH]: https://www.openssh.com/ "OpenSSH"
[rsync]: https://rsync.samba.org/ "rsync"
[make]: https://www.gnu.org/software/make/ "GNU Make"
[gdb]: https://www.gnu.org/software/gdb/ "GNU Debugger"
[CMake]: https://cmake.org/ "CMake"
[ninja]: https://ninja-build.org/ "Ninja, a small build system with a focus on speed"
[clang]: https://clang.llvm.org/ "Clang: a C language family frontend for LLVM"
[llvm]: https://llvm.org/ "The LLVM Compiler Infrastructure"
