metadata :name        => "drush",
         :description => "Drush agent for mcollective",
         :author      => "Julien Pivotto",
         :license     => "GPLv2",
         :version     => "1.0",
         :url         => "https://github.com/roidelapluie/mcollective-drush",
         :timeout     => 600

["updatedb", "cache-clear", "features-revert-all", "php-eval"].each do |act|
    action act, :description => "Run drush #{act} over a drupal installation" do
        input :root,
              :prompt      => "Root directory",
              :description => "Drupal root directory to use.",
              :type        => :string,
              :validation  => '^/[a-zA-Z\-_\d/.]+$',
              :optional    => false,
              :maxlength   => 255

        input :drush_path,
              :prompt      => "Path to drush",
              :description => "Path to the drush executable.",
              :type        => :string,
              :validation  => '^/[a-zA-Z\-_\d/.]+$',
              :default     => "/usr/bin/drush",
              :optional    => true,
              :maxlength   => 255

        input :uri,
              :prompt      => "URI",
              :description => "URI of the drupal site to use (only needed in multisite environments or when running on an alternate port).",
              :type        => :string,
              :validation  => '^[:a-zA-Z\-_\d/.]+$',
              :optional    => true,
              :maxlength   => 255

        input :yes,
              :prompt      => "Assume Yes",
              :description => "Assume 'yes' as answer to all prompts.",
              :type        => :boolean,
              :default     => false,
              :optional    => true

        input :no,
              :prompt      => "Assume No",
              :description => "Assume 'no' as answer to all prompts.",
              :type        => :boolean,
              :default     => false,
              :optional    => true

        input :simulate,
              :prompt      => "Simulate",
              :description => "Simulate all relevant actions (don't actually change the system).",
              :type        => :boolean,
              :default     => false,
              :optional    => true

        input :run_user,
              :prompt      => "User to use",
              :description => "User under who drush should run.",
              :type        => :string,
              :validation  => '^[a-zA-Z\-_\d/.]+$',
              :optional    => true,
              :maxlength   => 255

        output :stdout,
               :description => "Output of drush.",
               :display_as  => "Message"

        output :stderr,
               :description => "Error output of drush.",
               :display_as  => "Message"

        output :exitcode,
               :description => "Exitcode of drush.",
               :display_as  => "Message"

        if act == "cache-clear" then
            input :type,
                  :prompt      => "type",
                  :description => "The particular cache to clear.",
                  :type        => :string,
                  :validation  => '^[a-zA-Z\-_\d]+$',
                  :optional    => false,
                  :maxlength   => 32
        end
        if act == "php-eval" then
            input :type,
                  :prompt      => "code",
                  :description => "The particular code to evaluate.",
                  :type        => :string,
                  :validation  => '^[a-zA-Z\-_\d]+$',
                  :optional    => false,
                  :maxlength   => 255
        end
    end
end

