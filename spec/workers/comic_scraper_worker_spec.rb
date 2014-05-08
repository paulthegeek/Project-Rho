require 'spec_helper'

describe ComicScraperWorker do
  context 'response' do
    response = <<-END_OF_STRING
      [{  pr_id:"1327410",  pr_ttle:"Buffy The Vampire Slayer Season 10 #2 Cover A Regular Steve Morris Cover", cg_name:"Comics", childcat:"Dark Horse",  cg_id:"61", su_id:"10694",  mn_name:"Dark Horse", pr_lprice:"2.97", pr_price:"3.5", pr_discount:"15", pr_qty:"23",  cart:"0", pr_parentid:"1327410",  pr_simg:"1",  su_id:"10694",  issubscribe:"0",  artst:"Rebekah Isaacs", writ:"Christos N. Gage",},{ pr_id:"1327409",  pr_ttle:"Buffy The Vampire Slayer Season 10 #2 Cover B Variant Rebekah Isaacs Cover", cg_name:"Comics", childcat:"Dark Horse",  cg_id:"61", su_id:"14421",  mn_name:"Dark Horse", pr_lprice:"2.97", pr_price:"3.5", pr_discount:"15", pr_qty:"16",  cart:"0", pr_parentid:"1327409",  pr_simg:"1",  su_id:"14421",  issubscribe:"0",  artst:"Rebekah Isaacs", writ:"Christos N. Gage",},{ pr_id:"1327412",  pr_ttle:"Conan The Avenger #1", cg_name:"Comics", childcat:"Dark Horse",  cg_id:"61", su_id:"11114",  mn_name:"Dark Horse", pr_lprice:"2.97", pr_price:"3.5", pr_discount:"15", pr_qty:"26",  cart:"0", pr_parentid:"1327412",  pr_simg:"1",  su_id:"11114",  issubscribe:"0",  artst:"Brian Ching",  writ:"Fred Van Lente",},{ pr_id:"1327133",  pr_ttle:"All Star Western Vol 3 #30", cg_name:"Comics", childcat:"DC",  cg_id:"61", su_id:"12113",  mn_name:"DC", pr_lprice:"3.39", pr_price:"3.99",  pr_discount:"15", pr_qty:"29",  cart:"0", pr_parentid:"1327133",  pr_simg:"1",  su_id:"12113",  issubscribe:"0",  artst:"", writ:"Justin Gray - Jimmy Palmiott",}]
    END_OF_STRING
    it '.encode_response'
  end
end
