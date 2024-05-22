"
A ToSelectTest is a test class for testing the behavior of ToSelect
"
Class {
	#name : #ToSelectElementTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-Select-Tests-Core'
}

{ #category : #accessing }
ToSelectElementTest >> statesOfAmerica [

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
ToSelectElementTest >> testMonoFiltrable [

	| select |
	select := ToSelectElement new.
	select filtrable: true.
	self assert: select isFiltrable
]

{ #category : #tests }
ToSelectElementTest >> testMonoNotFiltrable [

	| select |
	select := ToSelectElement new.
	select filtrable: false.

	self deny: select isFiltrable.

]

{ #category : #tests }
ToSelectElementTest >> testMultiFiltrable [

	| select |
	select := ToMultiSelectElement new.
	select filtrable: true.
	select multipleSelection: true.
	self assert: select isFiltrable.
	self assert: select isMultipleSelection
]

{ #category : #tests }
ToSelectElementTest >> testMultiNotFiltrable [

	| select |
	select := ToMultiSelectElement new.
	select filtrable: false.
	select multipleSelection: true.
	self deny: select isFiltrable.
	self assert: select isMultipleSelection
]
