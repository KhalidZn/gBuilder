namespace gBuilder {

  /**
   * Resources
   *  glib-compile-resources gresource.xml --target=resources.c --generate-source
   */
  public class Resources : GLib.Object {
  	public string  gresource { set ; get;	}
  	public string  target    { set ; get;	}
  	public string  sources    { set ; get;	}
  	public bool    active    { set ; get;	 default = false;}
  	private const string GLIB_COMPILER = "glib-compile-resources ";
  	private string _command = GLIB_COMPILER;

  	/**
  	 *
  	 */
  	 public Resources (){ }

  	 public string command (){
  		 _command += " --sourcedir="+ sources + @" $sources/$gresource" + " --target=" + @"$sources/$target" + " --generate-source";
  		 stdout.printf("%s\n",_command);
  		 return _command;
  	 }
  }

}
