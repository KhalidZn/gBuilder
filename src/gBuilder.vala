using Jaa;
using Gee;
namespace gBuilder {
/**
 *
 */
	public class gBuilder : GLib.Object {

		/**
		 *
		 */
		 public int  resources_result {get ; set ; default =-1;}
		 public int  lib_result       {get ; set ; default =-1;}
		 public int  gir_result       {get ; set ; default =-1;}
		 public int  compiler_result  {get ; set ; default =-1;}
		 public Bin  builder          {get ; set ; }


		 public gBuilder () {
			try {
				JParser p = new JParser.from_file ("build.json");
				if (p.node.get_node_type () != Json.NodeType.NULL) {
 				JReaderObject<Bin> test = new JReaderObject<Bin>(p.node);
 				builder = test.get_object ();

 				if (builder.resources.active == true) {
 					resources_result = Posix.system(builder.resources.command ());
 				}

 				if (builder.libs.size > 0) {
 					foreach ( var lib in builder.libs ) {
 						lib_result = Posix.system(lib.vcommand ());
 						if (lib.gir == true) {
 							gir_result   = Posix.system(lib.gcommand ());
 						}
 					}
 				}
 				var compiler        =  builder.command ();
 				compiler_result = Posix.system(compiler);
			}
			} catch (Error e) {
				stdout.printf("%s", e.message);
			}

 		}

	}
}
