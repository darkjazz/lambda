(Document.current.dir ++ "/../xcode/build/Debug/lambdaApp.app").unixCmd

r = NetAddr("127.0.0.1", 7000);

// init 3d
r.sendMsg("/lambda/world/init", 16, 16, 16)

// init 2d
r.sendMsg("/lambda/world/init", 16, 16, 1)

// 0 - continuous, 1 - life, 2 - generations
r.sendMsg("/lambda/world/rule/init", 0)

// set add param for continuous
r.sendMsg("/lambda/world/rule/add", 0.05)

// set nhood weights
r.sendMsg("/lambda/world/rule/weights", *(1 ! 26))
