(
~ncoef = 20;
~decoder = FoaDecoder(decoderType:'stereo');
~graphics = CinderApp(ciAddr: NetAddr("192.168.1.100", 7000));
//~graphics = CinderApp();

~matrix = SparseMatrix(~decoder, ~graphics, 2, ~ncoef);
)


(
~ncoef = 20;
~rate = 20;
~headsize = 16;
~numgenes = 4;

~data = UGepLoader(~headsize, ~numgenes).load;

~sparsedata = UGepLoader().loadFromFile(Paths.devdir +/+ "lambda/supercollider/sparsematrix/2014-01-01/defnames00.scd");

~foa = #[zoom,push];
~player = GepPlayer(~data, ~decoder, ~graphics);

)

~decoder.start

~player.start(~foa)

~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)


// 56-60, 61-62

~indZoom = 61;
~indPush = 62;


~player.playRoutine(~indZoom, Pseq([0.5, 0, 0.5, 0, 0, 0.5]*2, inf), Pseq([0.5, 0.25, 0.25, 0.5, 0.25, 0.25], inf), 'zoom');
~player.playRoutine(~indPush, Pseq([0, 0.5, 0, 0.5, 0.5, 0]*2, inf), Pseq([0.5, 0.25, 0.25, 0.5, 0.25, 0.25], inf), 'push');

~player.stopRoutine(~indZoom);
~player.stopRoutine(~indPush);
