class Location < ActiveRecord::Base
  STYLES = ["Double", "Single", "Double - Apartment", "Single - Apartment", "Double - Suite", "Other"]
  CAMPUSES = ["livingston", "college avenue", "busch", "cook/douglass"]

  BUILDINGS_LIVINGSTON = ["livingston apartments", "lynton towers north", "lynton towers south", "quad 1", "quad 2", "quad 3"]
  BUILDINGS_BUSCH = ["allen hall", "barr hall", "best", "crosby suites", "davidson hall", "judson suites", "mattia hall", "mccormick suites", "metzger hall", "morrow suites", "nichols apartments", "richardson apartments", "silvers apartments", "thomas suites", "winkler suites", "marvin apartments", "buell apartments", "johnson apartments"]
  BUILDINGS_COLLEGE_AVENUE = ["brett hall", "campbell hall", "clothier hall", "demarest hall", "frelinghuysen hall", "hardenbergh hall", "hegeman hall", "leupp hall", "mettler hall", "pell hall", "stonier hall", "tinsley hall", "university center at easton ave apartments", "wessels hall"]
  BUILDINGS_COOK_DOUGLASS = ["heylar house", "henderson apartments", "jameson hall", "katzenbach hall", "lippincott hall", "new gibbons hall", "newell apartments", "nicholas hall", "old gibbons hall", "perry hall", "voorhees hall", "woodbury bunting-cobb hall", "starkey apartments"]
end
