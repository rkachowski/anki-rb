require 'test_helper'

class ExportTest < Minitest::Test
  def test_export
    deck = Anki::Deck.new 'ExportTestDeck'
    deck.add_card Anki::Card.new(front: 'front', back: 'back')

    Dir.mktmpdir do |tmp|
      Dir.chdir(tmp) do
        file_path = File.join(tmp, 'ExportTestDeck.apkg')

        Anki::apkg.export deck, tmp
        assert File.exists?(file_path), "package file should exist at #{file_path}"

        unzip_file 'ExportTestDeck.apkg'

        db = SQLite3::Database.new 'collection.anki2'

        flds = db.execute('select flds from notes').flatten.first
        sfld = db.execute 'select sfld from notes'


        #utf-8 "front\x1fback"
        python_flds_result = '66:72:6f:6e:74:1f:62:61:63:6b'
        ruby_flds_result = flds.bytes.to_a.map { |i| i.to_s(16) }.join ':'

        assert_equal python_flds_result, ruby_flds_result, 'hex values of strings should be equal'
      end
    end
  end
end
