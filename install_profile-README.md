# install_profile.sh

## Description

A simple wrapper around [cupertino](https://github.com/mattt/cupertino) to quickly download and install a provisioning profile.

If your provisioning profiles change frequently, it is tedious to update to ensure you are building with the latest profile.  install_profile.sh automates this task by retrieving the latest profile from the iOS dev center and installing it right where Xcode (and xcodebuild) can see it.

Add install_profile.sh to your continuous integration build jobs to ensure that you always have the latest profile before building.

## Usage

    # One time setup
    gem install cupertino
    ios login

    # Usage
    install_profile.sh PROVISIONING_PROFILE_NAME

## License

None - Use it to make your life better.

## Thanks

Matt Thompson for cupertino.

## Contact

Brian Partridge - @brianpartridge on Twitter and alpha.app.net