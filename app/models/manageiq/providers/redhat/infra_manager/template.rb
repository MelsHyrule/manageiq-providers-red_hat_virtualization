ManageIQ::Providers::Ovirt::InfraManager::Template.include(ActsAsStiLeafClass)

class ManageIQ::Providers::Redhat::InfraManager::Template < ManageIQ::Providers::Ovirt::InfraManager::Template
  include_concern 'ManageIQ::Providers::Redhat::InfraManager::VmOrTemplateShared'

  supports :provisioning do
    if ext_management_system
      unsupported_reason_add(:provisioning, ext_management_system.unsupported_reason(:provisioning)) unless ext_management_system.supports?(:provisioning)
    else
      unsupported_reason_add(:provisioning, _('not connected to ems'))
    end
  end

  supports :kickstart_provisioning

  def provider_object(connection = nil)
    ManageIQ::Providers::Redhat::InfraManager::OvirtServices::V4.new(:ems => ext_management_system).get_template_proxy(self, connection)
  end
end
