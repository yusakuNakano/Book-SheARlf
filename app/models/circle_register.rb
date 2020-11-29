class CircleRegister < ApplicationRecord
    validates :user_id, uniqueness:{scope: :circle_id}
    validates :circle_id,{presence: true}

end
