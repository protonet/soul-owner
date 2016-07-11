require 'spec_helper'

RSpec.describe SoulOwner::SetRecursiveFilePermissions do
  let(:path)  { '/tmp/foo/bar/baz' }
  
  describe "#perform" do
    let(:uid)   { 8007 }
    let(:do_perform) { subject.perform path, uid }

    it "recursively changes ownership and permissions of a given file" do
      expect(SoulOwner.file_utils).to receive(:chown_R).with(uid, SoulOwner.gid, path)
      expect(SoulOwner.file_utils).to receive(:chmod_R).with(0660, path)
      expect(subject).to receive(:desired_permissions_for_path).with(path).and_return(SoulOwner::FILE_PERMISSIONS)
      
      do_perform
    end

    it "recursively changes ownership and permissions of a given directory" do
      expect(SoulOwner.file_utils).to receive(:chown_R).with(uid, SoulOwner.gid, path)
      expect(SoulOwner.file_utils).to receive(:chmod_R).with(0770, path)
      expect(subject).to receive(:desired_permissions_for_path).with(path).and_return(SoulOwner::DIR_PERMISSIONS)
      
      do_perform
    end
  end

  describe "#desired_permissions_for_path(path)" do
    it "returns file permissions if given path is a file" do
      expect(File).to receive(:file?).with(path).and_return(true)
      expect(subject.desired_permissions_for_path(path)).to be == SoulOwner::FILE_PERMISSIONS
    end

    it "returns file permissions if given path is a directory" do
      expect(File).to receive(:file?).with(path).and_return(false)
      expect(subject.desired_permissions_for_path(path)).to be == SoulOwner::DIR_PERMISSIONS
    end
  end
end