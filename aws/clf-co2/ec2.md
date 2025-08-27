# EC2

## Basic Definition
  Building block for Amazon Web Services
  Virtual servers on the cloud 
  Same components as a personal computer
  Attach Network (VPCs) Security Services
  Can attach Amazon EC2 AutoScalling (Up and Down )
  Amazon Machine Image ( AMI ) Recovery or move to another AZs
 


## Purchase Options
 SO -> (Mac, Windows or Linux)
 Interruption (AWS automatically interrupts your instance if someone else buy for another higher price)

 OnDemand Instances
    -> No Interruptions
    -> Critical Workloads w/o interruptions, short term workloads ( Use Cases )
    -> Capacity Reservation option (Always have EC2 capacity ) scenarios where you NEED guaratee compute capacity
    -> Windows Pay by the Hour | Linux Pay by second
    -> Pay as you go no long term commitment, control over instance state
    -> Highes Cost among other EC2 Options

  Spot Instances
    -> Spared Unused EC2 instance that vary accordion to AWS Global Infraestructure
    -> Lowest cost ( Supply and Demand of the Available compute capacity )
    -> Can interrupt and allocate your spot (Not good for critical services )
    -> Development and test enviroments, Workloads that can be intereptured, Peak load for onDemand instances ( Use Cases )
    -> SpotFleet and SpotBlock are the types

  Dedidacted
    ->
  Savings Plans
    ->
  Reserved
    -> 
  Capacity Reservation

