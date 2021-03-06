# Include the ``java`` sls in order to use oracle_java_pkg
include:
    - java

# Note: this is only valid for the Debian repo / package
# You should filter on grain['os'] conditional for apt-based distros
elasticsearch_repo:
    pkgrepo.managed:
        - humanname: Elasticsearch Official Debian Repository
        - name: deb http://packages.elastic.co/elasticsearch/2.x/debian stable main
        - dist: stable
        - key_url: salt://elasticsearch/GPG-KEY-elasticsearch
        - file: /etc/apt/sources.list.d/elasticsearch-2.x.list

elasticsearch:
    pkg:
        - installed
        - require:
            - pkg: oracle_java_pkg
            - pkgrepo: elasticsearch_repo
    service:
        - running
        - enable: True
        - require:
            - pkg: elasticsearch
            - file: /etc/elasticsearch/elasticsearch.yml

/etc/elasticsearch/elasticsearch.yml:
  file:
    - managed
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - source: salt://elasticsearch/elasticsearch.yml
