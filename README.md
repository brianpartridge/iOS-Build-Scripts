# iOS Build Scripts

## Description

My build scripts for iOS projects, for use with manual builds or with CI systems.

See [my presentation on using Jenkins with iOS](https://github.com/brianpartridge/CI-With-Jenkins-For-iOS) for more information on how I use these scripts and why I don't use Jenkins plugins for performing these tasks.

## Assumptions

- You are building one target, which has one IPA and one dSYM as output files.
- Your project has multiple build configurations (Debug, AdHoc, etc).
- Deployment is only performed for AdHoc build configurations.

## Usage

- Copy build.sh and deploy.sh into the directory with your xcodeproj.
- Save your keychain password to a file that the build scripts can read.

    echo "My Keychain Password" > ~/.keychain_password

- Edit deploy.sh to specify your tokens for TestFlight and specify your distribution lists.
- Run the scripts:

    ./build.sh "My Fancy Target"
    
- In Jenkins, add an "Execute Script" build step, with the same command, and save the job.

## Known Issues

- Jenkins is the only supported CI system.
  - Each script specifies the environment variable that it expects to exist at runtime.  If a variable is not set, a sane default is used.  You may need to adjust the script or manually set the expected environment variables to accommodate your CI system.

### build.sh

- Support for xcworkspace has not been tested.
- No support for multiple xcodeproj files.
  - You may need to modify the script to support xcodebuild's -project flag.
- The method used to unlock the keychain is not secure.  
  - Since the keychain password is stored in plain text on your file system, make sure that your system is locked down.  I'm open to suggestions for better ways to keep the password secure.
- The keychain is left unlocked.
  - Since there may be concurrent builds running, locking the keychain could cause a race condition as one job tries to lock the keychain after another has unlocked it, but not yet finished code signing.
  
### deploy.sh

- Only TestFlight is supported.
  - It shouldn't be very hard to add support for HockeyKit or another OTA distribution system though.
- The deploy.sh TestFlight settings should be moved out into a configuration file or passed into the script from the command line, rather than editing the script.
- The output IPA and dSYM.zip files have an assumed location.
  - These should also probably be passed in on the command line to reduce enironment variable dependencies.

## License

None - Use them to make your life better.

## Contact

Brian Partridge - @brianpartridge on Twitter and alpha.app.net