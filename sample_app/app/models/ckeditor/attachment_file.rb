class Ckeditor::AttachmentFile < Ckeditor::Asset
  def url_thumb
    @url_thumb ||= Ckeditor::Utils.filethumb(filename)
  end
end
