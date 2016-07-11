require 'json'
class SoulOwner::Api < Sinatra::Base
  before do
    headers "Content-Type" => "application/json"
  end

  put '/recursive_file_permissions' do
    SoulOwner::SetRecursiveFilePermissions.new.perform(params[:path], params[:uid])
    { status: 'success' }.to_json
  end

  put '/permissions_after_upload' do
    SoulOwner::SetFilePermissionsAfterUpload.new.perform(params[:path], params[:uid], params[:mtime])
    { status: 'success' }.to_json
  end
end