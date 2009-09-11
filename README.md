Jill
====

Simple backup using Dropbox. Creates a Tarball of the backup before it is moved to Dropbox.

An example on how to use Jill:

<pre>
  require 'jill'

  backup = Jill.new
  backup.dropbox_base_path = '/Users/kimjoar/.dropbox/'
  backup.add '/Users/kimjoar/Documents'
  backup.add '/Users/kimjoar/Library/Application Support'
  backup.add '/Users/kimjoar/Library/Preferences'
  backup.exclude '/Users/kimjoar/Documents/VirtualMachines/'
  backup.encrypt 'aes-256-cbc', 'some password'
  backup.backup!
</pre>

Only tested on Mac OS X Snow Leopard.

Name inspired by [Jill Price](http://en.wikipedia.org/wiki/Jill_Price).

Todo
----

* Add readme for regular backup using property lists