Class {
	#name : #ToInfiniteElementTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Widget-List-Tests-Infinite'
}

{ #category : #accessing }
ToInfiniteElementTest >> statesOfAmerica [

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
ToInfiniteElementTest >> testEmptyInfinite [

	| l |
	l := ToInfiniteElement new.
	l fitContent.
	self assert: l data isEmpty.
	l forceLayout.
	self assert: l children size equals: 0.
	self
		assert: l size
		equals:
		l padding left + l padding right
		@ (l padding top + l padding bottom)
]

{ #category : #tests }
ToInfiniteElementTest >> testInfiniteWithOneElement [

	| l |
	l := ToInfiniteElement new.
	self assert: l data isEmpty.
	l data add: self statesOfAmerica first.
	self assert: l children size equals: 0.
	l forceLayout.
	self assert: l children size equals: 1.

]
