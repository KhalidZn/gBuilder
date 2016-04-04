namespace gBuilder {
  /**
   * bin
   */
  public class Bin : GLib.Object {
  	public Gee.List <string> flags    { get; set construct; 	}
  	public Gee.List <string> packages { get; set construct; 	}
  	public Gee.List <Lib>    libs     { get; set construct; 	}
  	public string sources             { get; set construct; 	}
  	public string  output             { get; set construct; 	}
  	public Resources resources        {get ; set construct;   }

  	private const string VALAC = "valac ";
  	private string _command = VALAC;
  	private FileLocator locator;

  	/**
  	 *
  	 */
  	public Bin () {

  	}

  	construct{
  		this.flags    = new Gee.ArrayList<string> ();
  		this.packages = new Gee.ArrayList<string> ();
  		this.libs     = new Gee.ArrayList<Lib>    ();
  		this.resources = new Resources ();
  	}

  	public string command (){
  		string vapiname = "";

  		if (sources!= null) {
  			locator = new FileLocator.with_directory(sources);
  		}
  		else	locator = new FileLocator ();

  		var source_files = locator.get_source_files();
  		//this.resources.command ();


  		foreach (var package in packages ) {
  			_command += "--pkg " + package + " ";
  		}

  		foreach (var flag in flags ) {
  			_command += flag + " ";
  		}
  		if (resources.active != false) {
  			_command +=  "--gresources " + resources.sources+"/"+resources.gresource + " " + resources.sources+"/"+resources.target +" ";
  		}
  		if (libs != null) {
  			foreach ( var lib in libs ) {
  				vapiname = "bin/"+lib.name+".vapi ";
  				_command += vapiname + " -X bin/" + lib.output +".so -X -I. ";
  			}
  		}

  		if (output != null) {
  			_command += "-o " + output + " ";
  		}else	_command += "-o app ";

  		foreach (var source in source_files ) {
  			_command += source.get_path  () + " ";
  		}
			_command += "-d bin";

  		stdout.printf("%s\n",_command);
  		return _command;
  	}

  }

}
