
# TPS Disk Role

## Get Disk Info

### requirements.yml
\- name: tps_disk <br>
  &nbsp;&nbsp;src: /tps_disk.git <br>
  &nbsp;&nbsp;scm: git <br>
  
### Call from remote yml with tag:  

\- name: call tps_disk role <br>
   &nbsp;&nbsp;hosts: all <br>
   &nbsp;&nbsp;become: true <br>
   &nbsp;&nbsp;roles: <br>
   &nbsp;&nbsp;&nbsp;&nbsp;\- { role: tps_disk, get_raw_disk: true }  <br>
   &nbsp;&nbsp;tags: get_disk <br>

## Format and Mount Disk

Not yet added

