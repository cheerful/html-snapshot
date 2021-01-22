require "test_helper"

class HTMLSnapshotTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Html::Snapshot::VERSION
  end
end
