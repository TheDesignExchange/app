class ContactsController < InheritedResources::Base
  load_and_authorize_resource

	layout "custom"
	def new
		@company = Company.find(params[:company_id])
		@contact = Contact.new(:company_id => @company.id)
	end
end
