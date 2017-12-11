class RegisterController < ApplicationController
	include RegisterHelper
	skip_before_action :verify_authenticity_token

	def start
	end
	def file_input
	end
	def command
		execute("refresh")
	end
	def file_input_action
		Rails.logger.debug(params.inspect)
		xml_contents = ""
		file_data = params[:files]
		if file_data.respond_to?(:read)
		  xml_contents = file_data.read
		elsif file_data.respond_to?(:path)
		  xml_contents = File.read(file_data.path)
		else
		  logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
		end
		content ="";
		execute("refresh")
		xml_contents.split("\n").each_with_index do |data,index| 
			content = content + execute(data) + "\n\n";
		end
		send_data(content)
	end
	def execute_command
		content = execute(params["command"])
		render :json => {:message => content}
	end
end
