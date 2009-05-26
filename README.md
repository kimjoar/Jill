# Jill

Simple backup using Dropbox. Creates a Tarball of the backup before it is moved to Dropbox.

An example on how to use Jill:

<pre>
  require 'jill'

  backup = Jill.new
  backup.dropbox_base_path = "/Users/kimjoarbekkelund/.dropbox/"
  backup.add("/Users/kimjoarbekkelund/Documents")
  backup.exclude(".git")
  backup.exclude(".svn")
  backup.exclude(".DS_Store")
  backup.backup!
</pre>

Only tested on Mac OS X Leopard.

Name inspired by [Jill Price](http://en.wikipedia.org/wiki/Jill_Price).