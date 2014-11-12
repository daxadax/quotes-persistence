require 'spec_helper'

class PublicationsGatewayBackendSpec < BackendSpec

  let(:backend) { Gateways::PublicationsGatewayBackend.new }
  let(:publication) { build_serialized_publication(nil) }
  let(:publication_two) { build_serialized_publication(nil, :title => "Different Title") }

  describe "insert" do
    it "ensures the added object is a Hash" do
      assert_failure { backend.insert(23) }
    end

    describe "with an already added publication" do
      let(:publication) { build_serialized_publication(:uid => "already_here!") }

      it "fails" do
        assert_failure { backend.insert(publication) }
      end
    end

    it "returns the id of the inserted publication on success" do
      uid = backend.insert(publication)

      assert_equal 1, uid
    end
  end

  describe "get" do
    it "returns nil if the the publication is not persisted" do
      assert_nil backend.get(23)
    end

    it "stores the serialized data in database" do
      uid = backend.insert(publication_two)
      result = backend.get(uid)

      assert_equal uid, result[:uid]
      assert_equal publication_two[:author], result[:author]
      assert_equal publication_two[:title], result[:title]
      assert_equal publication_two[:publisher], result[:publisher]
      assert_equal publication_two[:year], result[:year]
    end
  end

  describe "update" do
    describe "without a persisted publication" do
      it "fails" do
        assert_failure { backend.update(publication) }
      end
    end

    it "updates any changed attributes" do
      uid = backend.insert(publication)
      backend.update(build_serialized_publication(uid, :title => "New Title"))
      result = backend.get(1)

      refute_equal publication, result
      assert_equal uid, result[:uid]
      assert_equal "New Title", result[:title]
    end
  end

  describe "all" do
    it "returns an empty array if the backend is empty" do
      assert_empty backend.all
    end

    it "returns all items in the backend" do
      backend.insert(publication)
      backend.insert(publication_two)
      result = backend.all

      assert_equal 2, result.size
      assert_equal publication[:tags], result[0][:tags]
      assert_equal publication_two[:tags],  result[1][:tags]
    end
  end

  describe "delete" do
    it "removes the publication associated with the given uid" do
      backend.insert(publication)
      backend.delete(1)

      assert_nil backend.get(1)
    end

    it "doesn't remove other publications" do
      backend.insert(publication)
      backend.insert(publication_two)
      backend.delete(1)

      assert_nil  backend.get(1)
      assert_equal  backend.get(2), publication_two.merge({:uid => 2})
    end
  end


end
