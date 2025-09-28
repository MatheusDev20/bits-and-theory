### AWS Partner Network Technology Partners

Network Access Control Lists -> Stateless Firewalls act a subnet level.
Security Groups -> Sateful firewalls that run on resource level

Elastic Load Balancing
  -> Distributes incoming traffict to multiple targets ( EC2, containers, lambda )
  -> One or Multiple AZs
  -> Suport Path based and host based routing
  -> Http and Https

Types of Load Balancers

  Application Loa Balancer
    - Ballancing HTTP and HTTPS traffic, operates on Layer 7 of OSI models VPC based on the content of the request
  Gateway Load Balancer ( GWLB )
    - Extremely low latency, operates in Layer 3 and 4, bump in the wire device.
  Network Load Balance ( NLB )
    -> Operate on Layer 4 of OSI Model (TCP) or (UDP) protocols


## AWS Cloud Front

  - Speed up static and dynamic content using CDN to improve latency
  - Edge locations can make it run closer to your users and provide caching 

