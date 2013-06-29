~im = Image("/Users/alo/Pictures/fx/fx_hairs8.tiff")


1024/4

663/3

221+221+221

// neg z
~im.crop(Rect(0, 221, 221, 221))
~im.write("/Users/alo/Development/lambda/resources/fxh8_neg_z.png")
~im.free
~im=nil

// neg x
~im.crop(Rect(221, 221, 221, 221))
~im.write("/Users/alo/Development/lambda/resources/fxh8_neg_x.png")
~im.free
~im=nil

// pos z
~im.crop(Rect(442, 221, 221, 221))
~im.write("/Users/alo/Development/lambda/resources/fxh8_pos_z.png")
~im.free
~im=nil

// pos x
~im.crop(Rect(663, 221, 221, 221))
~im.write("/Users/alo/Development/lambda/resources/fxh8_pos_x.png")
~im.free
~im=nil

// pos y
~im.crop(Rect(442, 0, 221, 221))
~im.write("/Users/alo/Development/lambda/resources/fxh8_pos_y.png")
~im.free
~im=nil

// neg y
~im.crop(Rect(442, 442, 221, 221))
~im.write("/Users/alo/Development/lambda/resources/fxh8_neg_y.png")
~im.free
~im=nil

~im.plot
