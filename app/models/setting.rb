class Setting < ApplicationRecord
	enum user_type: { "Provider Price" => 1, "Customer Price" => 2 }
	enum file_type: { "ECG" => 1, "Polygraphie" => 2 }
	enum workflow_type: { "workflow 1" => 1, "workflow 2" => 2 }
	enum payment_type: { "by patient" => 1, "by customer or establishment" => 2 }
end
