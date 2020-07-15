# Ambari Server


## instructions:

cd ambari_server

echo your_vault_password > vault_pass

ap -i inventory/hadoop.ini -t get_raw_disk ambari.yml -u 'TEST007\user1' -e ansible_sudo_pass=xxxxxxxxxxxxxxxx 
