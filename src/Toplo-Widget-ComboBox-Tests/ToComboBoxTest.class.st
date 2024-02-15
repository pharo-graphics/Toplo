Class {
	#name : 'ToComboBoxTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Widget-ComboBox-Tests',
	#package : 'Toplo-Widget-ComboBox-Tests'
}

{ #category : 'combobox' }
ToComboBoxTest >> colors [

	^ Color registeredColorNames collect: [ :c | Color named: c ]
]

{ #category : 'combobox' }
ToComboBoxTest >> statesOfAmerica [

	^ { #Alabama. #Alaska. #Arizona. #Arkansas. #California. #Colorado.
		#Connecticut. #Delaware. #Florida. #Georgia. #Hawaii. #Idaho. #'Illinois Indiana'.
		#Iowa. #Kansas. #Kentucky. #Louisiana. #Maine. #Maryland. #Massachusetts.
		#Michigan. #Minnesota. #Mississippi. #Missouri. #Montana. #Nebraska.
		#Nevada. #'New Hampshire'. #'New Jersey'. #'New Mexico'.
		#'New York'. #'North Carolina'. #'North Dakota'. #Ohio. #Oklahoma.
		#Oregon. #'Pennsylvania Rhode Island'. #'South Carolina'.
		#'South Dakota'. #Tennessee. #Texas. #Utah. #Vermont. #Virginia.
		#Washington. #'West Virginia'. #Wisconsin. #Wyoming }.
]
