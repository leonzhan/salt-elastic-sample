base:
  '*':
    - common_packages
  'roles:elasticsearch':
    - match: grain
    - elasticsearch
