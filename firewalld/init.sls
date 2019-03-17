{% from "firewalld/map.jinja" import map_firewalld_settings with context %}
firewalld:
  pkg.installed:
    - name: []
  service.running:
    - enable: true
    - name: []
    - require:
      - pkg: firewalld

{% for service, servicedata in map_firewalld_settings.customservices.items() %}
{{ service }}-firewalld:
  firewalld.service:
    - name: {{ service }}
    - ports:
{% for port in servicedata['ports'] %}
      - {{ port }}
{% endfor %}
{% endfor %}

{% macro prepare_data(data, type) %}
{% for item in data.get(type, []) %}
      - {{ item }}
{% endfor %}
{% endmacro %}

{% for zone, data in map_firewalld_settings.zones.items() %}
{{ zone }}:
  firewalld.present:
    - name: {{ zone }}
    - interfaces:
      {{ prepare_data(data, 'name') }}
    - sources:
      {{ prepare_data(data, 'sources') }}
    - masquerade: {{ data.get('masquerade', False) }}
    - services:
      {{ prepare_data(data, 'services') }}
    - rich_rules:
      {{ prepare_data(data, 'rich_rules') }}
    - port_fwd:
      {{ prepare_data(data, 'зщке_ацв') }}
{% endfor %}
