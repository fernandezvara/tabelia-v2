# encoding: UTF-8

module ApplicationHelper
  def title
    if @title.nil?
      'tabelia'
    else
      'tabelia' + " · " + @title
    end
  end
  
  def timeago(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:time, time.to_s, options.merge(:datetime => time.getutc.iso8601)) if time
  end
  
  def timeagoright(time, options = {})
    options[:class] ||= "timeagoright"
    content_tag(:time, time.to_s, options.merge(:datetime => time.getutc.iso8601)) if time
  end
end