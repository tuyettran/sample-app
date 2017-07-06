class Ckeditor::Picture < Ckeditor::Asset
  def url_content
    url(:content)
  end
end
