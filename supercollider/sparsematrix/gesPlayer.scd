(
~headsize = 16;
~numgenes = 4;

~data = UGepLoader(~headsize, ~numgenes).load;

)


~decoder = FoaDecoder(decoderType: 'stereo');

~player = GepPlayer(~data, ~decoder, CinderApp());


~foa = #[zoom,focus,push,press];

~decoder.start

~player.start(~foa)


(

~player.setFoa('zoom', 1.0);
~player.setFoa('focus', 1.0);
~player.setFoa('push', 1.0);
~player.setFoa('press', 1.0);

)

normalizeSum

~indZoom = 6;
~indFocus = 15;


~player.playRoutine(~indZoom, Pseq([0.5, 0, 0.5, 0], inf), Pseq([3, 1, 1.5, 3], inf), 'zoom');
~player.playRoutine(~indFocus, Pseq([0, 0.5, 0, 0.5], inf), Pseq([3, 1, 1.5, 3], inf), 'focus');

~player.stopRoutine(~indZoom);
~player.stopRoutine(~indFocus);



~indZoom = 24;
~indFocus = 25;

~player.playRoutine(~indZoom, Pseq([1.0, 0, 1.0, 0]*0.2, inf), Pseq([0.4, 0.4, 0.8, 0.4], inf), 'zoom');
~player.playRoutine(~indFocus, Pseq([0, 1.0, 0, 1.0]*0.2, inf), Pseq([0.4, 0.4, 0.8, 0.4], inf), 'focus');

~player.stopRoutine(~indZoom);
~player.stopRoutine(~indFocus);




~indZoom = 26;
~indFocus = 27;

~player.playRoutine(~indZoom, Pseq([1.0, 0, 1.0, 0]*0.2, inf), Pseq([0.4, 0.4, 0.8, 0.4], inf), 'zoom');
~player.playRoutine(~indFocus, Pseq([0, 1.0, 0, 1.0]*0.7, inf), Pseq([0.4, 0.4, 0.8, 0.4], inf), 'focus');

~player.stopRoutine(~indZoom);
~player.stopRoutine(~indFocus);





~indZoom = 24

~player.playRoutine(~indZoom, Pseq([0, 0.5, 0, 0.5], inf), Pseq([0.4, 0.4, 0.8, 0.4], inf), 'zoom');

~player.stopRoutine(~indZoom);


~indZoom = 25

~player.play(~indZoom, 0.5, 'zoom', 0)

~player.set(~indZoom, 0.5)

~player.free(~indZoom)




~player.playRoutine(~indFocus, Pseq([0, 0.5, 0, 0, 0.5], inf), Pseq([3, 1, 1.5, 1.5, 1.5], inf), 'focus');



~indFocus = 15

~player.play(~indFocus, 1.0, 'focus', 0)

~player.set(~indFocus, 0.5)


~player.free(~indFocus)


s.queryAllNodes

s.sendMsg("/n_free", 1340)


~indPush = 21

~player.play(~indPush, 1.0, 'push', 0)

~player.set(~indPush, 0.5)

~player.free(~indPush)


~player.playRoutine(~indPush, Pseq([1.0, 0, 1.0, 0], inf), Pseq([0.25, 0.25, 0.25, 0.5, 0.25, 0.5], inf), 'push');


~player.stopRoutine(~indPush);



~indPress = 23

~player.play(~indPress, 0.25, 'press', 0)

~player.set(~indPress, 0.8)

~player.free(~indPress)

~player.playRoutine(~indPress, Pseq([0, 1.0, 0, 1.0], inf), Pseq([0.25, 0.25, 0.25, 0.5, 0.25, 0.5], inf), 'press');

~player.stopRoutine(~indPress);



s.queryAllNodes



p=Pseq([3, 1, 1.5, 3])

p.list = p.list.round((140/60).reciprocal)

~beatdur = (140/60).reciprocal

~sum = [3, 1, 1.5, 3]*~mul

([3, 1, 1.5, 3]*~mul).sum

~mul=(~beatdur*(~sum/~beatdur).round(1))/~sum

~beatdur*20
