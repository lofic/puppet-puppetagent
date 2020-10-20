require 'puppet'
Facter.add('pup_classes') do
  setcode do
    classfile="#{Puppet.settings['vardir']}/state/classes.txt"
      if File.file?(classfile)
        File.readlines(classfile).sort.map(&:chomp).uniq.join(',')
      end
  end
end
