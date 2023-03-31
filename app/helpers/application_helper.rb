module ApplicationHelper
    def javascript_path
        "#{controller_path}/#{action_name}.js"
    end
end
