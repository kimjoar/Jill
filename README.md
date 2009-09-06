# Jill

Simple backup using Dropbox. Creates a Tarball of the backup before it is moved to Dropbox.

An example on how to use Jill:

<pre>
  require 'jill'

  backup = Jill.new
  backup.dropbox_base_path = "/Users/kimjoar/.dropbox/"
  backup.add("/Users/kimjoar/Documents")
  backup.exclude("/Users/kimjoar/Documents/VirtualMachines/")
  backup.add("/Users/kimjoar/Library/Application\ Support")
  backup.add("/Users/kimjoar/Library/Preferences")
  backup.backup!
</pre>

Only tested on Mac OS X Leopard.

Name inspired by [Jill Price](http://en.wikipedia.org/wiki/Jill_Price).

## Regular backup using OS X and Jill

* Use Jill to create a backup script
* Create a [plist](http://en.wikipedia.org/wiki/Property_list) to perform the backup script in regular intervals. Example of plist:

<pre>
</pre>

* Place the plist in your `asdf` folder.