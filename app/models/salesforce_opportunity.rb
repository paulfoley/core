class SalesforceOpportunity < ActiveRecord::Base
  belongs_to :salesforce_account
  belongs_to :org
end
