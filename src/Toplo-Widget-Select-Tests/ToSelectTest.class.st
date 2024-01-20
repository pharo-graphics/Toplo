"
A ToSelectTest is a test class for testing the behavior of ToSelect
"
Class {
	#name : #ToSelectTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-Select-Tests-Core'
}

{ #category : #accessing }
ToSelectTest >> statesOfAmerica [

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

{ #category : #tests }
ToSelectTest >> testMonoFiltrable [

	| select |
	select := ToSelect new.
	select mode: ToSelectFiltrableMode new.
	select strategy: ToSingleSelectStrategy new.
	self assert: select isFiltrable.
	self deny: select isMultipleSelection
]

{ #category : #tests }
ToSelectTest >> testMonoNotFiltrable [

	| select |
	select := ToSelect new.
	select mode: ToSelectReadOnlyMode new.
	select strategy: ToSingleSelectStrategy new.
	self deny: select isFiltrable.
	self deny: select isMultipleSelection
]

{ #category : #tests }
ToSelectTest >> testMultiFiltrable [

	| select |
	select := ToSelect new.
	select mode: ToSelectFiltrableMode new.
	select strategy: ToMultipleSelectStrategy new.
	self assert: select isFiltrable.
	self assert: select isMultipleSelection
]

{ #category : #tests }
ToSelectTest >> testMultiNotFiltrable [

	| select |
	select := ToSelect new.
	select mode: ToSelectReadOnlyMode new.
	select strategy: ToMultipleSelectStrategy new.
	self deny: select isFiltrable.
	self assert: select isMultipleSelection
]
