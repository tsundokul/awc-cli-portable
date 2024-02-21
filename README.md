## ☁️ Portable single executable build of AWS CLI

This is a single binary builder for [aws-cli](https://github.com/aws/aws-cli) based on a slightly modified spec for pyinstaller and [manylinux_2_28](https://github.com/pypa/manylinux) x86_64.

Need the latest version or want to build it yourself? Just run
```bash
docker build . --progress=plain -o .
```

The executable will be exported in the current folder by the name `awscli-<version>`