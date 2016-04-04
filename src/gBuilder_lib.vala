namespace gBuilder {

  /**
   *
   */
  public class Lib : GLib.Object {

  	public Gee.List <string> flags    { get; set construct; 	}
  	public Gee.List <string> packages { get; set construct; 	}
  	public string sources             { get; set construct; 	}
  	public string name                { get; set construct; 	}
  	public string namespace           { get; set construct; 	}
  	public string version             {get ; set construct;   }
  	public string output              {get ; set construct;   }
  	public bool   gir                 {get ; set construct;   }

  	private const string VALAC = "valac ";
  	private const string GIRC  = "g-ir-compiler  ";
  	private string _vcommand = VALAC;
  	private string _gcommand = GIRC;
  	private FileLocator locator;
  	/**
  	 *
  	 */
  	public Lib () {
  	}
  	construct{
  		this.flags    = new Gee.ArrayList<string> ();
  		this.packages = new Gee.ArrayList<string> ();
  	}

  	public string vcommand (){
  		var girfile  = @"$namespace-$version";
  		var girtype  = @"$girfile.gir";

  		if (sources != null) {
  			locator = new FileLocator.with_directory(sources);
  		}
  		else	locator = new FileLocator ();

  		var source_files = locator.get_source_files();
  		//this.resources.command ();
  		_vcommand += @"--library=$name -H $name.h ";
  		foreach (var source in source_files ) {
  			_vcommand += source.get_path  () + " ";
  		}
  		if(output != null) {
  			_vcommand += @" -X -fPIC -X -shared -o $output.so "  ;

  		}else{
  			_vcommand += @" -X -fPIC -X -shared -o $name.so "  ;
  			this.output = name+".so";
  		}

  		foreach (var flag in flags ) {
  			_vcommand += flag + " ";
  		}

  		foreach (var package in packages ) {
  			_vcommand += "--pkg " + package + " ";
  		}

  		if (gir == true) {
  			_vcommand += @"--gir=$girtype";
  		}
			_vcommand += "-d bin";
  		stdout.printf("%s \n",_vcommand);
  		stdout.printf("%s \n",gir.to_string());
  		return _vcommand;
  	}

  	public string gcommand (){
  		var girfile  = @"$namespace-$version";
  		var girtype  = @"$girfile.gir";
  		var typelib  = @"$girfile.typelib";

  		if (gir == true) {
  			_gcommand += @"--shared-library=$name.so --output=$typelib $girtype";
  		}
  		stdout.printf("%s \n",_gcommand);
  		return _gcommand;


  	}

  }

}
