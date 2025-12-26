"
A ToCheckableBarElementTest is a test class for testing the behavior of ToCheckableBarElement
"
Class {
	#name : #ToCheckableFiniteListElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'bar'
	],
	#category : #'Toplo-Widget-List-Tests-ItemFiniteList'
}

{ #category : #running }
ToCheckableFiniteListElementTest >> setUp [ 

	super setUp.
	bar := ToCheckableFiniteListElement new.
	space root addChild: bar.
	bar matchParent.
	bar height: 10000.

]

{ #category : #accessing }
ToCheckableFiniteListElementTest >> statesOfAmerica [

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
ToCheckableFiniteListElementTest >> testAdd2Items [

	bar addItem: (ToToggleButton new labelText: 'First').
	bar addItem: (ToToggleButton new labelText: 'Second').
	self waitTestingSpaces.
	self assert: bar items size equals: 2.
	bar items withIndexDo: [ :it :idx |
		self assert: it holder position equals: idx ]
]

{ #category : #tests }
ToCheckableFiniteListElementTest >> testAddAllItems [

	bar height: 10000.
	bar forceLayout.
	bar addAllItems:
		(self statesOfAmerica collect: [ :l |
			 ToToggleButton new labelText: l ]).
	self waitTestingSpaces.
	self assert: bar items size equals: self statesOfAmerica size.
	bar nodeContainers withIndexDo: [ :it :idx |
		self assert: it holder position equals: idx ].
	bar nodeContainers withIndexDo: [ :it :idx |
			self assert: it holder position equals: idx.
			self assert: it node holder position equals: idx.
			self assert: it node item holder position equals: idx.
			self assert: (bar items at: idx) holder identicalTo: it holder.
			self assert: (bar items at: idx) holder position identicalTo: idx ].
	bar nodes withIndexDo: [ :it :idx |
		self assert: it holder position equals: idx ].
	bar nodeContainers do: [ :it |
		self assert: it holder identicalTo: it node holder ].
	bar nodeContainers do: [ :it |
		self assert: it holder identicalTo: it node item holder ].
	bar nodeContainers withIndexDo: [ :it :idx |
		self assert: it node item identicalTo: (bar items at: idx) ].
	1 to: self statesOfAmerica size do: [ :pos |
	self assert: (bar items at: pos) holder position equals: pos ].
	bar items withIndexDo: [ :it :idx |
		self assert: it holder position equals: idx ]
]

{ #category : #tests }
ToCheckableFiniteListElementTest >> testAddItem [

	bar addItem: (ToToggleButton new labelText: 'First').
	self waitTestingSpaces.
	self assert: bar isVertical.
	self assert: bar items size equals: 1.
	bar items withIndexDo: [ :it :idx |
		self assert: it holder position equals: idx ]
]

{ #category : #tests }
ToCheckableFiniteListElementTest >> testBar2 [

	self statesOfAmerica do: [ :l |
		bar addItem: (ToToggleButton new labelText: l) ].
	self waitTestingSpaces.
	self assert: bar items size equals: self statesOfAmerica size.
	bar items withIndexDo: [ :it :idx |
		self assert: it holder position equals: idx ]
]

{ #category : #tests }
ToCheckableFiniteListElementTest >> testItemChecked [

	self statesOfAmerica do: [ :l |
		bar addItem: (ToToggleButton new labelText: l) ].
	self waitTestingSpaces.
	bar items first checked: true.
	self assert: bar items first isChecked.
	self waitTestingSpaces.
	self assert: bar selectionModel selectedIndexes equals: #( 1 )
]

{ #category : #tests }
ToCheckableFiniteListElementTest >> testItemHResizer [

	self statesOfAmerica do: [ :l |
		bar addItem: (ToToggleButton new labelText: l) ].
	self waitTestingSpaces.
	bar items do: [ :item | self assert: item isHMatchParent ]
]

{ #category : #tests }
ToCheckableFiniteListElementTest >> testItemHeight [

	bar removeAllItems.
	self assert: bar items size equals: 0.
	self statesOfAmerica do: [ :l |
			bar addItem: (ToToggleButton new
					 labelText: l;
					 height: 100;
					 yourself) ].
	self waitTestingSpaces.
	bar items do: [ :item | self assert: item height equals: 100 ]
]

{ #category : #tests }
ToCheckableFiniteListElementTest >> testItemSelected [

	self statesOfAmerica do: [ :l |
		bar addItem: (ToToggleButton new labelText: l) ].
	bar selecter selectIndex: 1.
	self waitTestingSpaces.
	self assert: bar items first isChecked.
	self waitTestingSpaces.
	self assert: bar selectionModel selectedIndexes equals: #( 1 )
]

{ #category : #tests }
ToCheckableFiniteListElementTest >> testItemVResizer [

	self statesOfAmerica do: [ :l |
		bar addItem: (ToToggleButton new labelText: l) ].
	self waitTestingSpaces.
	bar items do: [ :item | self assert: item isVFitContent ]
]

{ #category : #tests }
ToCheckableFiniteListElementTest >> testItemWidth [

	bar removeAllItems.
	self assert: bar items size equals: 0.
	self statesOfAmerica do: [ :l |
			bar addItem: (ToToggleButton new
					 labelText: l;
					 width: 1000;
					 yourself) ].
	self waitTestingSpaces.
	bar items do: [ :item | self assert: item width equals: 1000 ]
]
