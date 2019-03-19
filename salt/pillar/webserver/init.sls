firewalld:
  zones:
    public:
      name:
        - eth0
      services:
        - ssh
        - http
        - https
