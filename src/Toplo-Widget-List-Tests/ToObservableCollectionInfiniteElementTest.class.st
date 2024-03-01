Class {
	#name : #ToObservableCollectionInfiniteElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'l'
	],
	#category : #'Toplo-Widget-List-Tests-Infinite'
}

{ #category : #running }
ToObservableCollectionInfiniteElementTest >> setUp [

	super setUp.
	l := ToObservableCollectionInfiniteElement new.
	space root addChild: l

	
]

{ #category : #accessing }
ToObservableCollectionInfiniteElementTest >> statesOfAmerica [

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
ToObservableCollectionInfiniteElementTest >> testEmptyInfinite [

	self assert: l dataAccessor isEmpty.
	l fitContent.
	l forceLayout.
	self assert: l children size equals: 0.
	self
		assert: l size
		equals:
		l padding left + l padding right
		@ (l padding top + l padding bottom)
]

{ #category : #tests }
ToObservableCollectionInfiniteElementTest >> testInfiniteWithOneElement [

	l dataAccessor add: self statesOfAmerica first.
	l matchParent.
	self assert: l children size equals: 0.
	self waitTestingSpaces.
	self assert: l children size equals: 1.

]

{ #category : #tests }
ToObservableCollectionInfiniteElementTest >> testRangeChangedNotification [

	| rangeEvent |
	l addEventHandler: (BlEventHandler
			 on: BlInfiniteDataSourceItemRangeChanged
			 do: [ :event | rangeEvent := event ]).
	l dataAccessor addAll: self statesOfAmerica.
	self assert: rangeEvent isNil.

	l dataAccessor at: 2 put: nil.
	self assert: rangeEvent notNil.
	self assert: rangeEvent position equals: 2.
	self assert: rangeEvent itemCount equals: 1.
	self assert: l dataSource itemCount equals: l dataAccessor size.

	l dataAccessor
		replaceFrom: 2
		to: 10
		with: ((2 to: 10) collect: [ :p | p ])
		startingAt: 1.
	(2 to: 10) do: [ :p | self assert: (l dataAccessor at: p) equals: p ].
	self assert: rangeEvent position equals: 2.
	self assert: rangeEvent itemCount equals: 9
]

{ #category : #tests }
ToObservableCollectionInfiniteElementTest >> testRangeInsertedNotification [

	| rangeEvent |
	l addEventHandler: (BlEventHandler
			 on: BlInfiniteDataSourceItemRangeInserted
			 do: [ :event | rangeEvent := event ]).
	l dataAccessor addAll: self statesOfAmerica.
	self assert: rangeEvent notNil.
	self assert: rangeEvent position equals: 1.
	self assert: rangeEvent itemCount equals: self statesOfAmerica size.
	self assert: l dataAccessor size equals: l dataSource itemCount.
	l dataAccessor add: Object new afterIndex: 1.
	self assert: rangeEvent position equals: 2.
	self assert: rangeEvent itemCount equals: 1
]

{ #category : #tests }
ToObservableCollectionInfiniteElementTest >> testRangeRemovedNotification [

	| rangeEvent |
	
	l addEventHandler: (BlEventHandler
			 on: BlInfiniteDataSourceItemRangeRemoved
			 do: [ :event | rangeEvent := event ]).
	l dataAccessor addAll: self statesOfAmerica.
	l dataAccessor remove: self statesOfAmerica first.
	self assert: rangeEvent notNil.
	self assert: rangeEvent position equals: 1.
	self assert: rangeEvent itemCount equals: 1.
	self
		assert: l dataSource itemCount
		equals: self statesOfAmerica size - 1.
	l dataAccessor remove: self statesOfAmerica last.
	self
		assert: rangeEvent position
		equals: self statesOfAmerica size - 1.
	self assert: rangeEvent itemCount equals: 1.
	self
		assert: l dataSource itemCount
		equals: self statesOfAmerica size - 2.
	l dataAccessor removeAll.
	self assert: rangeEvent position equals: 1.
	self
		assert: rangeEvent itemCount
		equals: self statesOfAmerica size - 2
]

{ #category : #tests }
ToObservableCollectionInfiniteElementTest >> testWithData [

	l dataAccessor addAll: self statesOfAmerica.
	self assert: l dataAccessor size equals: self statesOfAmerica size.
	self assert: l dataSource hasStableIds not
]
