Class {
	#name : #ToBasicFiniteListElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'l'
	],
	#category : #'Toplo-Widget-List-Tests-Core-FiniteListElement'
}

{ #category : #accessing }
ToBasicFiniteListElementTest >> statesOfAmerica [

	^ { #Alabama. #Alaska. #Arizona. #Arkansas. #California. #Colorado.
		#Connecticut. #Delaware. #Florida. #Georgia. #Hawaii. #Idaho. #Illinois. #Indiana.
		#Iowa. #Kansas. #Kentucky. #Louisiana. #Maine. #Maryland. #Massachusetts.
		#Michigan. #Minnesota. #Mississippi. #Missouri. #Montana. #Nebraska.
		#Nevada. #'New Hampshire'. #'New Jersey'. #'New Mexico'.
		#'New York'. #'North Carolina'. #'North Dakota'. #Ohio. #Oklahoma.
		#Oregon. #'Pennsylvania Rhode Island'. #'South Carolina'.
		#'South Dakota'. #Tennessee. #Texas. #Utah. #Vermont. #Virginia.
		#Washington. #'West Virginia'. #Wisconsin. #Wyoming }.
]

{ #category : #tests }
ToBasicFiniteListElementTest >> testDataAccessorAddAll [

	l := ToBasicListElement finite.
	l dataAccessor addAll: self statesOfAmerica.
	space deferAndSettle: [ space root addChild: l ].

	self assert: l dataSource size equals: self statesOfAmerica size
]

{ #category : #tests }
ToBasicFiniteListElementTest >> testDataAccessorAddAllAfterAttach [

	l := ToBasicListElement finite.
	space deferAndSettle: [
		space root addChild: l.
		l dataAccessor addAll: self statesOfAmerica ].

	self assert: l dataSource size equals: self statesOfAmerica size
]
