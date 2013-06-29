v = UserView(Window("----", Rect(400, 400, 400, 400)).front, Rect(0, 0, 400, 400));
v.background_(Color.black)
v.clearOnRefresh_(false)
(
z = 0;
m = 512;
y = 0;
n = 96;
r = 130;
v.drawFunc = {
	Pen.color = Color.grey(0.4, 0.8);
	p = Spherical(130+(sin(2pi/n*y)*40), 2pi/m*z, 0);
	Pen.fillOval(Rect(p.x+200, p.y+200, 20, 20));
	z = (z + 1).wrap(0, m-1);
	y = (y + 1).wrap(0, n-1);
}
)

2pi/512

Tdef(\anim, { loop({ {v.refresh}.defer; 0.01.wait }) })

Tdef(\anim).play

Tdef(\anim).stop


(
p = Spherical(130, 0, 0);
r = 0;
t = 0;
v.drawFunc = {
	Pen.color = Color.grey(0.4, 0.8);
	p.rho = 130+(sin(r)*50);
	p.theta = (p.theta + 0.033).wrap(0.3pi, 1.5pi);
	Pen.strokeOval(Rect(p.x+200, p.y+200, 20, 20));
	r = (r + 0.072).wrap(0, 2pi);
}
)
2pi/128

(
z = 0;
m = 16;
y = 0;
n = 16;
32.do({
	p = Spherical(130+(sin(2pi/n*y)*40), 2pi/m*z, 0);	
	[p.theta, p.rho].postln;
	z = (z + 1).wrap(0, m-1);
	y = (y + 1).wrap(0, n-1);
	
})
)


(
b=0;
d=0;
32.do({|i|
	d = (130+(sin(b)*60));
	[b, sin(b), d].postln;
	b = b + (2pi/16);
})
)






(
v = UserView(Window("----", Rect(400, 400, 400, 400)).front, Rect(0, 0, 400, 400));
v.background_(Color.black);
v.clearOnRefresh_(false);

r = Rotation(130, 0.072, 130, 170, 0, 0.033, 0, 0);
v.drawFunc = {
	Pen.color = Color.grey(0.4, 0.8);
	Pen.strokeOval(Rect(r.x+200, r.y+200, 20, 20));
	r.update
};

Tdef(\anim, { loop({ {v.refresh}.defer; 0.01.wait }) })

)


Tdef(\anim).play

Tdef(\anim).stop
