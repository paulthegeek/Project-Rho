require 'spec_helper'

# describe ComicScraperWorker do
#   context 'response' do
#     response = "[{\tpr_id:\"1333023\",\tpr_ttle:\"Aron Warners Pariah Vol 2 #4\",\tcg_name:\"Comics\",\tchildcat:\"Dark Horse\",\tcg_id:\"61\",\tsu_id:\"16341\",\tmn_name:\"Dark Horse\",\tpr_lprice:\"3.39\",\tpr_price:\"3.99\",\tpr_discount:\"15\",\tpr_qty:\"8\",\tcart:\"0\",\tpr_parentid:\"1333023\",\tpr_simg:\"1\",\tsu_id:\"16341\",\tissubscribe:\"0\",\tartst:\"Brett Weldele\",\twrit:\"Aaron Warner - Phillip Gelatt\",},]"
#     parsed_response = [{"pr_id"=>"1333023", "pr_ttle"=>"Aron Warners Pariah Vol 2 #4", "cg_name"=>"Comics", "childcat"=>"Dark Horse", "cg_id"=>"61", "su_id"=>"16341", "mn_name"=>"Dark Horse", "pr_lprice"=>"3.39", "pr_price"=>"3.99", "pr_discount"=>"15", "pr_qty"=>"8", "cart"=>"0", "pr_parentid"=>"1333023", "pr_simg"=>"1", "issubscribe"=>"0", "artst"=>"Brett Weldele", "writ"=>"Aaron Warner - Phillip Gelatt"}]
#     it '.data_cleanup' do
#       expect(ComicScraperWorker.data_cleanup(response)).to eq parsed_response
#     end
#   end
# end
