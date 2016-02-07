module Anki
  class Defaults
    def self.deck
      JSON.parse '{"newToday":[0,0],"revToday":[0,0],"lrnToday":[0,0],"timeToday":[0,0],"conf":1,"usn":0,"desc":"","dyn":0,"collapsed":false,"extendNew":10,"extendRev":50}'
    end

    def self.model deck_id
      JSON.parse %Q({"1451998862056": {"vers": [], "name": "Basic", "tags": [], "did": #{deck_id}, "usn": -1, "req": [[0, "all", [0]]], "flds": [{"name": "Front", "media": [], "sticky": false, "rtl": false, "ord": 0, "font": "Arial", "size": 20}, {"name": "Back", "media": [], "sticky": false, "rtl": false, "ord": 1, "font": "Arial", "size": 20}], "sortf": 0, "latexPre": "\\\\documentclass[12pt]{article}\\n\\\\special{papersize=3in,5in}\\n\\\\usepackage[utf8]{inputenc}\\n\\\\usepackage{amssymb,amsmath}\\n\\\\pagestyle{empty}\\n\\\\setlength{\\\\parindent}{0in}\\n\\\\begin{document}\\n\", "tmpls": [{"name": "Card 1", "qfmt": "{{Front}}", "did": null, "bafmt": "", "afmt": "{{FrontSide}}\\n\\n<hr id=answer>\\n\\n{{Back}}", "ord": 0, "bqfmt": ""}], "latexPost": "\\\\end{document}", "type": 0, "id": 1451998862056, "css": ".card {\\n font-family: arial;\\n font-size: 20px;\\n text-align: center;\\n color: black;\\n background-color: white;\\n}\\n", "mod": 1454538410}})
    end

    def self.conf
      '{"nextPos": 1, "estTimes": true, "activeDecks": [1], "sortType": "noteFld", "timeLim": 0, "sortBackwards": false, "addToCur": true, "curDeck": 1, "newBury": true, "newSpread": 0, "dueCounts": true, "curModel": "1454538453789", "collapseTime": 1200}'
    end

    def self.dconf
      '{"1": {"name": "Default", "replayq": true, "lapse": {"leechFails": 8, "minInt": 1, "delays": [10], "leechAction": 0, "mult": 0}, "rev": {"perDay": 100, "fuzz": 0.05, "ivlFct": 1, "maxIvl": 36500, "ease4": 1.3, "bury": true, "minSpace": 1}, "timer": 0, "maxTaken": 60, "usn": 0, "new": {"perDay": 20, "delays": [1, 10], "separate": true, "ints": [1, 4, 7], "initialFactor": 2500, "bury": true, "order": 1}, "mod": 0, "id": 1, "autoplay": true}}'
    end

    def self.tags
      '{}'
    end
  end
end