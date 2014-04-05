~ncoef = 20;
~rate = 20;
~headsize = 12;
~numgenes = 2;

~meta = UGenExpressionTree.loadMetadataFromDir.select({|data| data.args.isKindOf(Event) });

~data = ~meta.select({|meta|
	var data, include, path = UGEP.archDir +/+ meta.defname.asString ++ "." ++ UGEP.fileExt;
	if (File.exists(path))
	{
		data = UGEP.loadData(path)
	};
	include = (data.header.headsize == ~headsize).and(data.header.numgenes == ~numgenes);
	if (include)
	{
		meta.data = data
	};
	include
})

