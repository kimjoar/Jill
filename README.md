Jill
====

Simple backup using Dropbox. Creates a Tarball of the backup (and optionally encrypts it) before it is moved to Dropbox.

An example on how to use Jill:

<pre>
  require 'jill'

  Jill.backup do
    dropbox  '/Users/kimjoar/.dropbox/'
    add      '/Users/kimjoar/Documents'
    exclude  '/Users/kimjoar/Documents/Virtual Machines/'
    encrypt  'aes-256-cbc', 'password'
  end
</pre>

Only tested on Mac OS X Snow Leopard.

Name inspired by [Jill Price](http://en.wikipedia.org/wiki/Jill_Price).