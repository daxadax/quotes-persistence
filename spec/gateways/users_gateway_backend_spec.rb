require 'spec_helper'

class UsersGatewayBackendSpec < BackendSpec

  let(:user)    { build_serialized_user }
  let(:backend) { Gateways::UsersGatewayBackend.new }

  describe "insert" do
    it "ensures the added object is a Hash" do
      assert_failure { backend.insert(23) }
    end

    describe "with an already added user" do
      let(:user) { build_serialized_user(:uid => "already_here!") }

      it "fails" do
        assert_failure { backend.insert(user) }
      end
    end

    it "returns the uid of the inserted user on success" do
      user_uid = backend.insert(user)

      assert_equal 1, user_uid
    end
  end

end