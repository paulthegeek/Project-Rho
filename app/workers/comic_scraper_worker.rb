require 'open-uri'

class ComicScraperWorker
  include Sidekiq::Worker

  def perform
    today = Date.today.to_s
    next_wednesday = 1.week.from_now.to_s
    scrape_release_dates(today)
    scrape_release_dates(next_wednesday)
  end

  def scrape_release_dates(date)
    response = <<-END_OF_STRING
      [{  pr_id:"1327410",  pr_ttle:"Buffy The Vampire Slayer Season 10 #2 Cover A Regular Steve Morris Cover", cg_name:"Comics", childcat:"Dark Horse",  cg_id:"61", su_id:"10694",  mn_name:"Dark Horse", pr_lprice:"2.97", pr_price:"3.5", pr_discount:"15", pr_qty:"23",  cart:"0", pr_parentid:"1327410",  pr_simg:"1",  su_id:"10694",  issubscribe:"0",  artst:"Rebekah Isaacs", writ:"Christos N. Gage",},{ pr_id:"1327409",  pr_ttle:"Buffy The Vampire Slayer Season 10 #2 Cover B Variant Rebekah Isaacs Cover", cg_name:"Comics", childcat:"Dark Horse",  cg_id:"61", su_id:"14421",  mn_name:"Dark Horse", pr_lprice:"2.97", pr_price:"3.5", pr_discount:"15", pr_qty:"16",  cart:"0", pr_parentid:"1327409",  pr_simg:"1",  su_id:"14421",  issubscribe:"0",  artst:"Rebekah Isaacs", writ:"Christos N. Gage",},{ pr_id:"1327412",  pr_ttle:"Conan The Avenger #1", cg_name:"Comics", childcat:"Dark Horse",  cg_id:"61", su_id:"11114",  mn_name:"Dark Horse", pr_lprice:"2.97", pr_price:"3.5", pr_discount:"15", pr_qty:"26",  cart:"0", pr_parentid:"1327412",  pr_simg:"1",  su_id:"11114",  issubscribe:"0",  artst:"Brian Ching",  writ:"Fred Van Lente",},{ pr_id:"1327133",  pr_ttle:"All Star Western Vol 3 #30", cg_name:"Comics", childcat:"DC",  cg_id:"61", su_id:"12113",  mn_name:"DC", pr_lprice:"3.39", pr_price:"3.99",  pr_discount:"15", pr_qty:"29",  cart:"0", pr_parentid:"1327133",  pr_simg:"1",  su_id:"12113",  issubscribe:"0",  artst:"", writ:"Justin Gray - Jimmy Palmiott",}]
    END_OF_STRING

    uri = 'http://www.midtowncomics.com/store/ajax_wr_online.asp?cat=61&wdate='

    response = HTTParty.post(uri + date)
    encode_response(response)
    eval_response(response)

    PublisherWorker.create_publishers(parsed_response)
  end

  def encode_response(response)
    response.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
  end

  def eval_response(response)
    context = V8::Context.new
    parsed_response = context.eval(w)
  end
end
