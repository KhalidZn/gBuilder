using Gee;
namespace gBuilder {

  class FileLocator : GLib.Object {

  	public File directory;

  	public FileLocator() {
  		this.directory = File.new_for_path(".");
  	}

  	public FileLocator.with_directory(string directory) {
  		this.directory = File.new_for_path(directory);
  	}

  	public Gee.List<File> get_source_files() {
  		return get_source_files_recursive(this.directory);
  	}

  	private Gee.List<File> get_source_files_recursive(File directory) {
  		Gee.List<File> sourcefiles = new ArrayList<File>();
  		try {
  			var children = directory.enumerate_children(FileAttribute.STANDARD_NAME, 0);

  			FileInfo child;
  			while((child = children.next_file()) != null) {

  				if(child.get_file_type() == FileType.DIRECTORY) {
  					sourcefiles.add_all(get_source_files_recursive(directory.get_child(child.get_name())));
  				} else {
  					if(child.get_name().has_suffix(".vala")) {
  						//stdout.printf("%s \n",child.get_name ());
  						sourcefiles.add(directory.get_child(child.get_name()));
  					}
  				}
  			}

  		} catch(Error e) {
  			stderr.printf("Error finding source files\n");
  		}

  		return sourcefiles;
  	}
  }


}
