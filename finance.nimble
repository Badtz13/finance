# Package

version       = "0.1.0"
author        = "badtz"
description   = "quick financial tracker"
license       = "MIT"
srcDir        = "src"
bin           = @["calc"]

# Dependencies

requires "nim >= 1.2.0"
requires "therapist >= 0.2.0"

task buildDev, "Build for usage during development":
    exec "nimble build -d:ssl"

task buildProd, "Build for production":
    exec "nimble build -d:ssl -d:release"
