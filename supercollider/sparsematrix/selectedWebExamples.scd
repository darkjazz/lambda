~synth=SynthDef('gep_gen002_075_130802_203937', {|out=0,amp=0,dur=1,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y|  Out.ar(out,Pan2.ar(Normalizer.ar(LeakDC.ar((  LFNoise1.ar( FMGrain.ar(h,  PMOsc.ar(y, e, l, b, u, x ),  Dust2.ar(j, t, e ), y, p,  Ball.ar(n, v, v, n ), e ), l,  HenonL.ar( FMGrain.ar(n, n, w, d, j, d, i ), m, d,  Blip.ar(b, v, u, x ),  FMGrain.ar(l, f, d, q, t, c, d ), j, n ) ))*( InGrain.ar( LFPulse.ar(r, u,  Spring.ar( LFNoise2.ar(c, m, i ), j, f ), c,  CML0.ar(x, v, d, f, x, y ) ),  Pulse.ar( LFPulse.ar(b, p, j, t, g ), o, a,  InGrain.ar(q, p, s, r, n ) ), i, l, d ))*( CuspL.ar( Spring.ar( Logist0.ar( SawDPW.ar(k, j, s, c ),  QuadL.ar(j, b, w, n, o, v, g ), p, a, w ),  Logist0.ar(e, x, g, u, i ),  Crackle.ar(x, d, m ) ),  LFDNoise0.ar( LFDNoise0.ar(x, i, w ), f,  LFDNoise0.ar(r, d, a ) ), p, p, o, t ))*( FMGrain.ar( Blip.ar(v,  CuspL.ar(l, w, f, y, g, e ),  LFTri.ar(j, w, i, u ),  SinGrain.ar(m, p, u, v, n ) ), w, w, g, f,  SinOsc.ar( LFDNoise0.ar(n, t, r ),  PMOsc.ar(b, u, u, g, x, h ),  HenonL.ar(k, y, g, i, p, p, d ),  FMGrain.ar(p, d, p, b, a, b, y ) ), r ) ))),0,amp)) }).play(args: 
[ 'a', 1.6420102119446, 'b', 13.110636711121, 'c', -0.86799949407578, 'd', 0.027232756838202, 'e', 0.56061327457428, 'f', 1.087641119957, 'g', 0.38823771476746, 'h', -0.25842821598053, 'i', 0, 'j', 446.90447998047, 'k', 0.43448439240456, 'l', 1.1984220743179, 'm', -12.711162567139, 'n', 0.1513260602951, 'o', 0.81048035621643, 'p', 0.97161960601807, 'q', 14.569178581238, 'r', 0, 's', 0.42289450764656, 't', 0.17267155647278, 'u', 0.09271328151226, 'v', 1.4842553138733, 'w', 255.04020690918, 'x', 0.98315191268921, 'y', 1.3111319541931 ]
)
~synth.set('amp', 0.3)
~synth.free

~synth=SynthDef('gep_gen002_225_130721_220022', {|out=0,amp=0,dur=1,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y|  Out.ar(out,Pan2.ar(Normalizer.ar(LeakDC.ar((  Saw.ar(i, r,  Pulse.ar(t, h, i,  SinOsc.ar(y, r, i, p ) ) ))*( StandardL.ar(m, h,  SawDPW.ar(s,  HenonL.ar(d, s, n, t, o, d, r ),  LFDNoise0.ar(r, f, p ),  Crackle.ar(e, v, h ) ), a,  FMGrain.ar( LFSaw.ar(l, w, h, j ),  Pluck.ar(c, y, a, g, t, g, x, d ),  LFNoise2.ar(u, j, c ),  LFNoise1.ar(h, y, s ), j, y, k ),  LFDNoise0.ar(a, e, b ) ))*( HPF.ar( LFNoise1.ar(p,  SyncSaw.ar(r,  StandardL.ar(d, j, k, x, o, j ), g, n ),  GbmanL.ar( SinOsc.ar(j, b, c, d ), o, l, h, i ) ),  Saw.ar( HenonL.ar(e, p, q, y, n, p, l ),  Crackle.ar(w, r, h ),  Logist0.ar(n, r, a, g, g ) ), j, i ))*( SinOsc.ar(h, y, e,  DelayL.ar(b,  SinGrain.ar(q, x,  LFPulse.ar(k, k, q, d, w ),  LFNoise2.ar(e, j, c ), h ), k, p, n ) ) ))),0,amp)) }).play(args: [ 'a', 1.8553959131241, 'b', 0.51838505268097, 'c', -0.0, 'd', 1.0, 'e', 1.3515774011612, 'f', 13.44327545166, 'g', 100.0, 'h', 0.47877484560013, 'i', 0.19178818166256, 'j', 10.339004516602, 'k', 0.62915289402008, 'l', 1.1528444290161, 'm', 1.712232708931, 'n', -99.176498413086, 'o', 0.30813097953796, 'p', 1.6116172075272, 'q', 100.0, 'r', -0.922816157341, 's', 2.7296350002289, 't', 29.545949935913, 'u', 0.84798073768616, 'v', 0.72206455469131, 'w', 0.61274516582489, 'x', 0.34379503130913, 'y', -0.021308589726686 ]
)
~synth.set('amp', 0.4)
~synth.free 

~synth=SynthDef('gep_gen000_022_140412_151110', {|out=0,amp=0,dur=1,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u|  Out.ar(out,Pan2.ar(Normalizer.ar(LeakDC.ar((  LFNoise2.ar( LFDNoise1.ar(f,  Crackle.ar( StandardL.ar( LFPulse.ar(a, p, t, p, a ),  LFSaw.ar(a, s, l, d ), u, n, u, n ), m,  SyncSaw.ar(e, k, h, c ) ), c ), i, r ))*( StandardL.ar( Pulse.ar( StandardL.ar(e, d, q, l, t, p ), t,  LFClipNoise.ar(p, f, j ),  LFCub.ar(h, q, m, f ) ),  SawDPW.ar(r, r, p, e ),  LFCub.ar(e, p, p, u ),  StandardL.ar(h, p, e, t, b, f ), f,  Pulse.ar(c, l, s, s ) ) ))),0,amp)) }).play(args: #[ a, -inf, b, 7.5127568244934, c, 20000, d, 0.33801394701004, e, 221.58908081055, f, 0.00026888391585089, g, 0.84298938512802, h, 2.8826158046722, i, 5.3661518096924, j, 45855.171875, k, 0.86832499504089, l, 20000, m, 20000, n, 0.1672568321228, o, 1.0492409467697, p, 0.94249624013901, q, 16107.75390625, r, 0, s, 2.4334709644318, t, 0, u, 222.01567077637 ])
~synth.set('amp', 0.3)
~synth.free 


~synth=SynthDef('gep_gen000_054_140207_185445', {|out=0,amp=0,dur=1,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s|  Out.ar(out,Pan2.ar(Normalizer.ar(LeakDC.ar((  PMOsc.ar(d,  LFPulse.ar( LFClipNoise.ar(d, k, n ), o, q, r,  LFCub.ar(q, g, i, n ) ),  Formant.ar(j, c, b, n, m ),  LFDNoise1.ar(j, m, i ), d, j ))*( Blip.ar(l, j, h, j ) ))),0,amp)) }).play(args: #[ a, 8.6660928726196, b, 0.55602639913559, c, 0.60943400859833, d, 0.2198121547699, e, 1.6151390075684, f, 0.67369383573532, g, 12.028810501099, h, -0.73037302494049, i, 744.66326904297, j, 0.25825279951096, k, 43.151161193848, l, 0, m, -1.8879414796829, n, 0.066980496048927, o, 1.7984758615494, p, 0.16054487228394, q, 0.54126703739166, r, 0.8998036980629, s, 745.94848632812 ])
~synth.set('amp', 0.3)
~synth.free 

~synth=SynthDef('gep_gen001_056_130501_181619', {|out=0,amp=0,dur=1,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y|  Out.ar(out,Pan2.ar(Normalizer.ar(LeakDC.ar((  SinOsc.ar(x, v, y, b ))*( Blip.ar(g, c,  LFTri.ar( LPF.ar( LFPar.ar(t, x, r, u ), t, r, q ),  SyncSaw.ar(r, s, h, d ),  LFTri.ar(l, h, v, i ), h ), l ))*( PinkNoise.ar( Pulse.ar(v, l,  CML0.ar( Impulse.ar(c, j, r, i ), e, c, x, t, o ),  LFPulse.ar(i, t, c, n, l ) ),  Crackle.ar(d, a,  SinOsc.ar(i, v, l, u ) ) ))*( LFPulse.ar(w, f, c,  Saw.ar( Blip.ar(f, t, v, j ),  Crackle.ar(k, a, k ),  PMOsc.ar(b, u, n, l, d, g ) ),  Blip.ar( LFNoise2.ar(a, w, d ),  Blip.ar(c, g, m, a ), s, r ) ) ))),0,amp)) }).play(args: #[ a, 1.2730071544647, b, 0.77776551246643, c, -2.3435547351837, d, 1.5629274845123, e, 7.3943738937378, f, 0.20331063866615, g, 3.0187730789185, h, 0.16514046490192, i, -0.2454995661974, j, 0.20167124271393, k, 1, l, 0.23352435231209, m, 72.842254638672, n, -0.33126041293144, o, 0.18563492596149, p, 0.67251986265182, q, -0.90473026037216, r, 0.31606477499008, s, -99.631721496582, t, 72.272300720215, u, 0.3682769536972, v, 0.63806933164597, w, 2.6154305934906, x, 0.81047093868256, y, -0.10205411165953 ])
~synth.set('amp', 0.3)
~synth.free 


(
~headsize = 12;
~numgenes = 2;

~decoder = FoaDecoder(decoderType:'stereo');

~data = UGepLoader(~headsize, ~numgenes).load;

~foa = #[zoom,focus];
~player = GepPlayer(~data, ~decoder);

)

~decoder.start

~player.start(~foa)

	
~indZoom = 14
~player.play(~indZoom, 0, 'zoom', 0)
~player.set(~indZoom, 0.1)

s.queryAllNodes

~player.setWithPattern(~indZoom, Pwhite(0.05, 0.2, inf), Pbrown(0.03125, 0.25, 0.03125, inf))

~player.free(~indZoom)

