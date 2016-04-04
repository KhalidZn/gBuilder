namespace gBuilder {
  public class gBuilderApplication : Application {

    private const string APPNAME = "gBuilder";
    private const string VERSION = "0.1";

    private static bool version = false;
    private static bool clean   = false;
    private static bool library = false;
    private static bool exec    = false;

    //private static string? directory = null;

    private const GLib.OptionEntry[] options = {
      // --version
      { "version", 'v', 0, OptionArg.NONE, ref version, "Display version number", null },
      { "library", 'L', 0, OptionArg.NONE, ref library, "Builde library     "   , null },
      { "create" , 'c', 0, OptionArg.NONE, ref clean  , "Create new  project"   , null },
      { "clean"  ,  0 , 0, OptionArg.NONE, ref clean  , "Clean project"         , null },
      { "run"    , 'r', 0, OptionArg.NONE, ref exec    ,"Run & exec bin"        , null },


      // --directory FIlENAME || -o FILENAME
      //{ "directory", 'o', 0, OptionArg.FILENAME, ref directory, "Output directory", "DIRECTORY" },

      { null }
    };

  	private gBuilderApplication () {
  		Object (application_id: "org.aye7.gBuilder", flags: ApplicationFlags.HANDLES_COMMAND_LINE);
  		//set_inactivity_timeout (10000);
  	}
/*
  	public override void activate () {
      this.hold ();
  		this.release ();
  	}
*/

  	private int _command_line (ApplicationCommandLine command_line) {

  		string[] args = command_line.get_arguments ();
  		string*[] _args = new string[args.length];
  		for (int i = 0; i < args.length; i++) {
  			_args[i] = args[i];
  		}

  		try {
  			var opt_context = new OptionContext ("- OptionContext example");
  			opt_context.set_help_enabled (true);
  			opt_context.add_main_entries (options, null);
  			unowned string[] tmp = _args;
  			opt_context.parse (ref tmp);
  		} catch (OptionError e) {
  			command_line.print ("error: %s\n", e.message);
  			command_line.print ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
  			return 0;
  		}

  		if (version) {
  			command_line.print (@"$APPNAME version $VERSION\n(C) 2016 Aissat <aye7> .\nEmail: mr.aissat@gmail.com");
  			return 0;
  		}
      if (library) {

      }

      stdout.printf("Compiler Output:\n");
      gBuilder build = new gBuilder ();
      stdout.printf("%i:\n", build.resources_result);

  		return 0;
  	}

  	public override int command_line (ApplicationCommandLine command_line) {
  		// keep the application running until we are done with this commandline
  		this.hold ();
  		int res = _command_line (command_line);
  		this.release ();
  		return res;
  	}

  	public static int main (string[] args) {
  		gBuilderApplication app = new gBuilderApplication ();
  		int status = app.run (args);

  		return status;
  	}
  }
}
