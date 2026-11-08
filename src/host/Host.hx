import sys.io.File;
import haxe.io.Bytes;
import cpp.cppia.Module;
import sys.FileSystem;
import cpp.cppia.Host as CHost;

class Host {
	static var scripts:Array<String> = [];

	static public function main():Void {
		trace('Hello from cppia HOST');

		for (file in FileSystem.readDirectory('scripts/'))
			if (!FileSystem.isDirectory('scripts/$file'))
				scripts.push('scripts/$file');

		for (script in scripts)
			if (specialScriptCondition(script))
				CHost.runFile(script); // <- load and execute the .cppia script file
	}

	static function specialScriptCondition(script:String) {
		var lines = [for (a in File.getContent(script).split('\n')) StringTools.replace(a, '\n', '')];

		var typeCount = Std.parseInt(lines[1]);
		var classCount = Std.parseInt(lines[2 + typeCount]);
		var buffer = lines[4 + typeCount + classCount];

		var types = [for (i => b in lines) if (i > 0 && i < 2 + typeCount) b];
		var classes = [for (i => c in lines) if (i > 2 + typeCount && i < 3 + typeCount + classCount) c];

		// trace(types);
		// trace(classes);

		return true;
	}
}
