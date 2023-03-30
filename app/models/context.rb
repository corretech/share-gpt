class Context < ApplicationRecord
    belongs_to :upper_chat, class_name: 'Chat'
    belongs_to :bottom_chat, class_name: 'Chat'
end
