# Read Me



## Configuring a user

- Create a new file under provisioners/puppet/hiera/private.yaml


## Installing a project

- Edit provisioners/puppet/hiera.yaml to include the project e.g.

       - projects/development/blog
       - projects/shared/blog

- Open up the project file located under provisioners/puppet/hiera/ 

      provisioners/puppet/hiera/projects/shared/blog

- Take note of the resource type e.g. project::static and resource name e.g. blog



## Configuring a project

- Create a new file under provisioners/puppet/hiera/private.yaml

- Add a following entry where you replace <type> with the resource type, <name> with the resource type, <private key> with your private SSH key that's authorised to clone the repo and finally <public key>

      <type>:
          <name>:
              ssh_private_key: "<private key>"
              ssh_public_key: "<public key>"

- Your private and public key should be formated with new lines as literal "\n" if in double you can use the following command to get your private/public key on Mac OS X

	  cat ~/.ssh/id_rsa | perl -p -i -e 's/\n/\\n/g' | pbcopy