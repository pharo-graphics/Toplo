Class {
	#name : #ToInfiniteCollectionDataSourceTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'l'
	],
	#category : #'Toplo-Widget-List-Tests-Infinite'
}

{ #category : #running }
ToInfiniteCollectionDataSourceTest >> setUp [

	super setUp.
	l := ToInfiniteElement onListElement: ToListElement new.
	space root addChild: l

	
]

{ #category : #accessing }
ToInfiniteCollectionDataSourceTest >> statesOfAmerica [

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
ToInfiniteCollectionDataSourceTest >> testEmptyInfinite [

	l constraintsDo: [ :c |
			c vertical fitContent.
			c horizontal fitContent ].

	l forceLayout.
	self assert: l children size equals: 0.
	self
		assert: l extent
		equals:
		l padding left + l padding right
		@ (l padding top + l padding bottom)
]

{ #category : #tests }
ToInfiniteCollectionDataSourceTest >> testInfiniteWithOneElement [

	l dataSource collection add: self statesOfAmerica first.
	l constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent ].

	self assert: l children size equals: 0.
	self waitTestingSpaces.
	self assert: l children size equals: 1
]

{ #category : #tests }
ToInfiniteCollectionDataSourceTest >> testRangeChangedNotification [

	| rangeEvent |
	l dataSource addEventHandler: (BlEventHandler
			 on: BlInfiniteDataSourceItemRangeChanged
			 do: [ :event | rangeEvent := event ]).
	l dataSource addAll: self statesOfAmerica.
	self assert: rangeEvent isNil.

	l dataSource  at: 2 put: nil.
	self assert: rangeEvent notNil.
	self assert: rangeEvent position equals: 2.
	self assert: rangeEvent itemCount equals: 1.
	self assert: l dataSource itemCount equals: l dataSource itemCount.

	l dataSource
		replaceFrom: 2
		to: 10
		with: ((2 to: 10) collect: [ :p | p ])
		startingAt: 1.
	(2 to: 10) do: [ :p | self assert: (l dataSource at: p) equals: p ].
	self assert: rangeEvent position equals: 2.
	self assert: rangeEvent itemCount equals: 9
]

{ #category : #tests }
ToInfiniteCollectionDataSourceTest >> testRangeInsertedNotification [

	| rangeEvent |
	l dataSource addEventHandler: (BlEventHandler
			 on: BlInfiniteDataSourceItemRangeInserted
			 do: [ :event | rangeEvent := event ]).
	l dataSource addAll: self statesOfAmerica.
	self assert: rangeEvent notNil.
	self assert: rangeEvent position equals: 1.
	self assert: rangeEvent itemCount equals: self statesOfAmerica size.
	self assert: l dataSource size equals: l dataSource itemCount.
	l dataSource add: Object new afterIndex: 1.
	self assert: rangeEvent position equals: 2.
	self assert: rangeEvent itemCount equals: 1
]

{ #category : #tests }
ToInfiniteCollectionDataSourceTest >> testRangeRemovedNotification [

	| rangeEvent |
	
	l dataSource addEventHandler: (BlEventHandler
			 on: BlInfiniteDataSourceItemRangeRemoved
			 do: [ :event | rangeEvent := event ]).
	l dataSource addAll: self statesOfAmerica.
	l dataSource remove: self statesOfAmerica first.
	self assert: rangeEvent notNil.
	self assert: rangeEvent position equals: 1.
	self assert: rangeEvent itemCount equals: 1.
	self
		assert: l dataSource itemCount
		equals: self statesOfAmerica size - 1.
	l dataSource remove: self statesOfAmerica last.
	self
		assert: rangeEvent position
		equals: self statesOfAmerica size - 1.
	self assert: rangeEvent itemCount equals: 1.
	self
		assert: l dataSource itemCount
		equals: self statesOfAmerica size - 2.
	l dataSource removeAll.
	self assert: rangeEvent position equals: 1.
	self
		assert: rangeEvent itemCount
		equals: self statesOfAmerica size - 2
]

{ #category : #tests }
ToInfiniteCollectionDataSourceTest >> testWithData [

	l dataSource addAll: self statesOfAmerica.
	self assert: l dataSource size equals: self statesOfAmerica size.
	self assert: l dataSource hasStableIds not
]
