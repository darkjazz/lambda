~sparsedata = UGepLoader(headsize: 12, numgenes: 2).load;


~file = File(Document.current.dir +/+ "defnames00.scd", "w");

~sparsedata.collect(_.defname).do({|name|
	~file.write(name ++ "\n")
})

~file.close
