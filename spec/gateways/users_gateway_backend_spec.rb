require 'spec_helper'

class UsersGatewayBackendSpec < BackendSpec

  let(:user)                    { build_serialized_user }
  let(:user_to_update)  { build_serialized_user(:uid => 1, :nickname => 'new') }
  let(:backend)             { Gateways::UsersGatewayBackend.new }

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

  describe "get" do
    it "returns nil if the the user is not persisted" do
      assert_nil backend.get(23)
    end

    it "stores the serialized data in database" do
      backend.insert(user)
      result = backend.get(1)

      assert_storage(result)
    end
  end

  describe "all" do
    it "returns an empty array if the backend is empty" do
      assert_empty backend.all
    end

    it "returns all items in the backend" do
      backend.insert(user)
      backend.insert(user)
      result = backend.all

      assert_equal 2, result.size
      assert_equal user[:favorites], result[0][:favorites]
      assert_equal user[:added], result[0][:added]
    end
  end

  describe "update" do
    describe "without a persisted user" do
      it "fails" do
        assert_failure { backend.update(user) }
      end
    end

    it "updates any changed attributes" do
      backend.insert(user)
      backend.update(user_to_update)
      result = backend.get(user_to_update[:uid])

      refute_equal user, result
      assert_equal 'new', result[:nickname]
    end
  end

  private

  def assert_storage(actual)
    assert_equal user[:nickname],  actual[:nickname]
    assert_equal user[:email],          actual[:email]
    assert_equal user[:auth_key],   actual[:auth_key]
    assert_equal user[:favorites],    actual[:favorites]
    assert_equal user[:added],        actual[:added]
    assert_equal_terms(actual)
  end

  def assert_equal_terms(actual)
    assert_equal "1", actual[:terms] if user[:terms] == true
    assert_equal "0", actual[:terms] if user[:terms] == false
  end


end
