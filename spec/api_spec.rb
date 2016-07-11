require 'spec_helper'

RSpec.describe SoulOwner::Api do
  include Rack::Test::Methods
  let(:app) { SoulOwner::Api }

  def expect_success
    expect(last_response.status).to be == 200
    expect(last_response.headers["Content-Type"]).to be == "application/json"
    expect(JSON.parse(last_response.body)).to be == { "status" => "success" }
  end

  describe "PUT /recursive_file_permissions" do
    let(:do_request) { put '/recursive_file_permissions', params }
    let(:params) do
      { 
        path: '/tmp/foo/bar',
        uid:  "8007"
      }
    end

    describe "with valid params" do
      it "performs a SetRecursiveFilePermissions job and responds with success" do
        expect_any_instance_of(SoulOwner::SetRecursiveFilePermissions).to receive(:perform).with(params[:path], params[:uid])
        do_request
        expect_success
      end
    end
  end

  describe "PUT /permissions_after_upload" do
    let(:do_request) { put '/permissions_after_upload', params }
    let(:params) do
      { 
        path: '/tmp/foo/bar',
        uid:  "8007",
        mtime: "1468230357"
      }
    end

    describe "with valid params" do
      it "performs a SetFilePermissionsAfterUpload job and responds with success" do
        expect_any_instance_of(SoulOwner::SetFilePermissionsAfterUpload).to receive(:perform).with(params[:path], params[:uid], params[:mtime])
        do_request
        expect_success
      end
    end
  end
end