(Document.current.dir ++ "/../xcode/build/Debug/lambdaApp.app").unixCmd

r = NetAddr("127.0.0.1", 7000);

// init 3d x, y, z
r.sendMsg("/lambda/world/init", 24, 24, 24)

// init rule
// 0 - continuous, 1 - life, 2 - generations
r.sendMsg("/lambda/world/rule/init", 0);
r.sendMsg("/lambda/world/rule/weights", *(1.0 ! 26))

// set add param for continuous
r.sendMsg("/lambda/world/rule/add", 0.07)

// set initial condition wirecube formation left, bottom, front, width, height, depth
r.sendMsg("/lambda/world/reset/wirecube", 9, 9, 9, 4, 4, 4)

// activate pattern: index, active, alpha, colormap, alhpamap, r, g, b
r.sendMsg("/lambda/graphics/pattern", 15, 1, 1.0, 1, 1, 0.6, 0.8, 1.0)

// interpolate

r.sendMsg("/lambda/world/interpl", 1, 3)

// rotate
r.sendMsg("/lambda/graphics/rotate", 1.0, 0.4, 0.3, 0.01)

// viewpoint
r.sendMsg("/lambda/graphics/view", 0.0, 0.0, 100.0)


// poll indices
(
r.sendMsg("/lambda/world/query/states", *~arr);
o = OSCFunc({|ms|
	~states = ms.drop(1)
}, "/lambda/world/states")
)

~states.clump(24).do(_.postln)
~states.size

~states.do(_.postln)

o.disable
o=nil

r.sendMsg("/lambda/world/query/stop")

// quit app
r.sendMsg("/lambda/quit")


// init 3d x, y, z
r.sendMsg("/lambda/world/init", 16, 16, 16)

// init rule
// 0 - continuous, 1 - life, 2 - generations
r.sendMsg("/lambda/world/rule/init", 2);
r.sendMsg("/lambda/world/rule/births", 3,4,6,7);
r.sendMsg("/lambda/world/rule/survivals", 2,5,6,7);
r.sendMsg("/lambda/world/rule/states", 14);

// set initial condition wirecube formation left, bottom, front, width, height, depth
r.sendMsg("/lambda/world/reset/rand", 4, 4, 4, 10, 10, 10, 0.7, 0)

// activate pattern: index, active, alpha, colormap, alhpamap, r, g, b
r.sendMsg("/lambda/graphics/pattern", 14, 1, 1.0, 1, 1, 0.0, 0.5, 1.0)
