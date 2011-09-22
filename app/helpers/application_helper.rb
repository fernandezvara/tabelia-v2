# encoding: UTF-8

module ApplicationHelper
  def title
    if @title.nil?
      'tabelia'
    else
      'tabelia' + " · " + @title
    end
  end
end