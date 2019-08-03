# frozen_string_literal: true

module Biovision
  module Components
    # Handler for partners component
    class PartnersComponent < BaseComponent
      SLUG = 'partners'

      def use_parameters?
        false
      end

      def allow?(options = {})
        UserPrivilege.user_has_privilege?(user, :partners_manager)
      end
    end
  end
end
