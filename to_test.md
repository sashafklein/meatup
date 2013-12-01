##Animal
- create_real_cuts!
- close_animal!
- check_for_sold!
- weight creation

##Butcher
- wrapping_price

##Charge
- Test controller
-- successful charge updates order status and sends two emails, then redirects
-- unsuccesssful flashes and redirects with error

##CutCalc
- Units left, total, expected
- Pounds sold
- rev expected

##Line
- self.from_attrs(single attr array)
- rollback -- kills line and updates rc
- revenue -- differs based on whether weighed

##Order
- order-controller new test
- rollback -- destroys all relevant

##Package
- cut_siblings

##Ranch
- has?
- price_for

##RealCut
- self.create_from!(a,c)
- prep_options takes both into account

