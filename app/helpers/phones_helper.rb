module PhonesHelper
  def panel_link path: nil, icon: nil, text: nil
    render 'application/phone/panel_link', path: path, icon_name: icon, text: text
  end
end