require 'spec_helper'

RSpec.describe SoulOwner::SetFilePermissionsAfterUpload do
  describe "#perform" do
    let(:path)  { '/tmp/foo/bar/baz' }
    let(:uid)   { 8007 }
    let(:mtime) { nil }
    let(:do_perform) { subject.perform path, uid, mtime }

    it "changes ownership and permissions on given path in the expected way" do
      expect(SoulOwner.file_utils).to receive(:chown).with(uid, SoulOwner.gid, path)
      expect(SoulOwner.file_utils).to receive(:chmod).with(0660, path)
      
      do_perform
    end

    describe "with mtime given" do
      let(:mtime) { 1468228365 }

      it "additionally touches the file with given mtime" do
        expect(SoulOwner.file_utils).to receive(:chown)
        expect(SoulOwner.file_utils).to receive(:chmod)
        expect(SoulOwner.file_utils).to receive(:touch).with(path, mtime: mtime)

        do_perform
      end
    end
  end
end