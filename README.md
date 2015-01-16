# Read Me

## Installation

-       cd packer/
-       packer build template.json

-       cd vagrant/
-       vagrant up


## Crowdwish

- Edit vagrant/puppet/hiera.yaml and add projects you want, example below

      ---
      :backends: yaml

      :yaml:
        :datadir: /vagrant/vagrant/puppet/hiera/

      :hierarchy:
          - environments/development
          - environments/shared

          - projects/development/crowdwish
          - projects/shared/crowdwish

          - roles/database
          - roles/node
          - roles/ruby
          - roles/php
          - roles/web
          - roles/base
          - common

      :logger: console

      :merge_behavior: deeper


- Create **vagrant/puppet/hiera/private.yaml** example below

      ---
      file:
          crowdwish_ssh_gitlab:
              ensure: present
              require:
                  - User[crowdwish]
                  - File[crowdwish_ssh]
              path: /home/crowdwish/.ssh/gitlab.key
              content: "CONTENT HERE"
              owner: crowdwish
              group: crowdwish
              mode: 0600

- Edit the "content" key so the value is your SSH key with new lines replaced with literal "\n" a command below will format your key and copy it to your clipboard

      cat ~/.ssh/id_rsa | perl -p -e 's/\n/\\n/' | pbcopy
