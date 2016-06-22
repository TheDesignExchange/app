class CompaniesController < InheritedResources::Base
  load_and_authorize_resource

	layout "custom"
end
