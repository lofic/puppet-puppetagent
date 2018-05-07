begin
  require 'facter/util/puppet_settings'
rescue LoadError => e
  # puppet apply does not add module lib directories to the $LOAD_PATH (See
  # #4248). It should (in the future) but for the time being we need to be
  # defensive which is what this rescue block is doing.
  rb_file = File.join(File.dirname(__FILE__), 'util', 'puppet_settings.rb')
  load rb_file if File.exist?(rb_file) || raise(e)
end

Facter.add(:pupenv) do
  setcode do
    Facter::Util::PuppetSettings.with_puppet do
      Puppet[:environment]
    end
  end
end
