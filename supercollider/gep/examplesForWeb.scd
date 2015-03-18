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


~player.defStrings.collect(_.postcs)

~player.data[61].args.args.postcs

// 56-60, 61-62

~indZoom = 56;
~indPush = 60;


~player.playRoutine(~indZoom, Pseq([0.5, 0, 0.5, 0, 0, 0.5]*2, inf), Pseq([0.5, 0.25, 0.25, 0.5, 0.25, 0.25], inf), 'zoom');
~player.playRoutine(~indPush, Pseq([0, 0.5, 0, 0.5, 0.5, 0]*2, inf), Pseq([0.5, 0.25, 0.25, 0.5, 0.25, 0.25], inf), 'push');

~player.stopRoutine(~indZoom);
~player.stopRoutine(~indPush);





[ 'a', 0.1115700006485, 'b', 0.77172410488129, 'c', 0.52038955688477, 'd', -0.02635669708252, 'e', 0.27769124507904, 'f', 0.79808080196381, 'g', 1.6263536214828, 'h', 1179.9007568359, 'i', 1621.2987060547, 'j', 221.96908569336, 'k', 2.9571228027344, 'l', 0.223140001297, 'm', 43.225498199463, 'n', 1179.9007568359, 'o', 0.0, 'p', 1.4598795175552, 'q', 1.2504259347916, 'r', 69.865112304688, 's', 0.18674159049988, 't', 0.10172452777624, 'u', 2.23140001297, 'v', 81.843925476074, 'w', 70.046562194824, 'x', 214.18852233887, 'y', 0.61487245559692 ]