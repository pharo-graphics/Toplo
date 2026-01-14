"
A ToCheckableBarElementTest is a test class for testing the behavior of ToCheckableBarElement
"
Class {
	#name : #ToCheckableListElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'bar'
	],
	#category : #'Toplo-Widget-List-Tests-ItemFiniteList'
}

{ #category : #tests }
ToCheckableListElementTest >> add2Items [

	bar addItem: (ToToggleButton new labelText: 'First').
	bar addItem: (ToToggleButton new labelText: 'Second').
	self waitTestingSpaces.
	self assert: bar items size equals: 2.
	bar items withIndexDo: [ :it :idx |
		self assert: it holder position equals: idx ]
]

{ #category : #tests }
ToCheckableListElementTest >> addAllItems [

	bar addAllItems:
		((self statesOfAmerica "copyFrom: 1 to: 2") collect: [ :l |
			 ToToggleButton new labelText: l ]).
	bar forceLayout.
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
ToCheckableListElementTest >> addItem [

	bar addItem: (ToToggleButton new labelText: 'First').
	self waitTestingSpaces.
	self assert: bar isVertical.
	self assert: bar items size equals: 1.
	bar items withIndexDo: [ :it :idx |
		self assert: it holder position equals: idx ]
]

{ #category : #tests }
ToCheckableListElementTest >> bar2 [

	self statesOfAmerica do: [ :l |
		bar addItem: (ToToggleButton new labelText: l) ].
	self waitTestingSpaces.
	self assert: bar items size equals: self statesOfAmerica size.
	bar items withIndexDo: [ :it :idx |
		self assert: it holder position equals: idx ]
]

{ #category : #tests }
ToCheckableListElementTest >> itemChecked [

	self statesOfAmerica do: [ :l |
		bar addItem: (ToToggleButton new labelText: l) ].
	self waitTestingSpaces.
	bar items first checked: true.
	self assert: bar items first isChecked.
	self waitTestingSpaces.
	self assert: bar selectionModel selectedIndexes equals: #( 1 )
]

{ #category : #tests }
ToCheckableListElementTest >> itemHResizer [

	self statesOfAmerica do: [ :l |
		bar addItem: (ToToggleButton new labelText: l) ].
	self waitTestingSpaces.
	bar items do: [ :item | self assert: item isHMatchParent ]
]

{ #category : #tests }
ToCheckableListElementTest >> itemHeight [

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
ToCheckableListElementTest >> itemSelected [

	self statesOfAmerica do: [ :l |
		bar addItem: (ToToggleButton new labelText: l) ].
	bar selecter selectIndex: 1.
	bar forceLayout.
	self waitTestingSpaces.
	self assert: bar items first isChecked.
	self waitTestingSpaces.
	self assert: bar selectionModel selectedIndexes equals: #( 1 )
]

{ #category : #tests }
ToCheckableListElementTest >> itemVResizer [

	self statesOfAmerica do: [ :l |
		bar addItem: (ToToggleButton new labelText: l) ].
	self waitTestingSpaces.
	bar items do: [ :item | self assert: item isVFitContent ]
]

{ #category : #tests }
ToCheckableListElementTest >> itemWidth [

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

{ #category : #running }
ToCheckableListElementTest >> setUp [ 

	super setUp.
	bar := ToCheckableListElement new.
	space root addChild: bar.
	bar matchParent.
	bar height: 30000.

]

{ #category : #accessing }
ToCheckableListElementTest >> statesOfAmerica [

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
ToCheckableListElementTest >> testFiniteAdd2Items [

	bar useInfiniteLayout: false.
	self add2Items 
]

{ #category : #tests }
ToCheckableListElementTest >> testFiniteAddAllItems [

	bar useInfiniteLayout: false.
	self addAllItems 
]

{ #category : #tests }
ToCheckableListElementTest >> testFiniteAddItem [

	bar useInfiniteLayout: false.
	self addItem
]

{ #category : #tests }
ToCheckableListElementTest >> testFiniteBar2 [

	bar useInfiniteLayout: false.
	self bar2
]

{ #category : #tests }
ToCheckableListElementTest >> testFiniteItemChecked [

	bar useInfiniteLayout: false.
	self itemChecked 
]

{ #category : #tests }
ToCheckableListElementTest >> testFiniteItemHResizer [

	bar useInfiniteLayout: false.
	self itemHResizer 
]

{ #category : #tests }
ToCheckableListElementTest >> testFiniteItemHeight [

	bar useInfiniteLayout: false.
	self itemHeight 
]

{ #category : #tests }
ToCheckableListElementTest >> testFiniteItemSelected [

	bar useInfiniteLayout: false.
	self itemSelected
]

{ #category : #tests }
ToCheckableListElementTest >> testFiniteItemVResizer [

	bar useInfiniteLayout: false.
	self itemVResizer 
]

{ #category : #tests }
ToCheckableListElementTest >> testFiniteItemWidth [

	bar useInfiniteLayout: false.
	self itemWidth
]

{ #category : #tests }
ToCheckableListElementTest >> testInfiniteAdd2Items [

	bar useInfiniteLayout: true.
	self add2Items 
]

{ #category : #tests }
ToCheckableListElementTest >> testInfiniteAddAllItems [

	bar useInfiniteLayout: true.
	self addAllItems 
]

{ #category : #tests }
ToCheckableListElementTest >> testInfiniteAddItem [

	bar useInfiniteLayout: true.
	self addItem
]

{ #category : #tests }
ToCheckableListElementTest >> testInfiniteBar2 [

	bar useInfiniteLayout: true.
	self bar2
]

{ #category : #tests }
ToCheckableListElementTest >> testInfiniteItemChecked [

	bar useInfiniteLayout: true.
	self itemChecked 
]

{ #category : #tests }
ToCheckableListElementTest >> testInfiniteItemHResizer [

	bar useInfiniteLayout: true.
	self itemHResizer 
]

{ #category : #tests }
ToCheckableListElementTest >> testInfiniteItemHeight [

	bar useInfiniteLayout: true.
	self itemHeight 
]

{ #category : #tests }
ToCheckableListElementTest >> testInfiniteItemSelected [

	bar useInfiniteLayout: true.
	self itemSelected
]

{ #category : #tests }
ToCheckableListElementTest >> testInfiniteItemVResizer [

	bar useInfiniteLayout: true.
	self itemVResizer 
]

{ #category : #tests }
ToCheckableListElementTest >> testInfiniteItemWidth [

	bar useInfiniteLayout: true.
	self itemWidth
]
