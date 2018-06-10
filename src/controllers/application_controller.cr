require "jasper_helpers"

class ApplicationController < Amber::Controller::Base
  include JasperHelpers
  LAYOUT = "application.ecr"

  private def format_time(time)
    return if time.nil?
    formatter = Time::Format.new("%b %-d, %Y")
    formatter.format(time)
  end
end
