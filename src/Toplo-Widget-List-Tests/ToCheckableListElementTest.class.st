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

	space deferAndSettle: [ 
		bar addItem: (ToToggleButton labelText: 'First').
		bar addItem: (ToToggleButton labelText: 'Second') ].
	self assert: bar items size equals: 2.

	bar items withIndexDo: [ :it :idx |
		self assert: it holder position equals: idx ]
]

{ #category : #tests }
ToCheckableListElementTest >> addAllItems [

	space deferAndSettle: [ 
		bar addAllItems:
			((self statesOfAmerica) collect: [ :l |
				 ToToggleButton labelText: l ]) ].
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

	space deferAndSettle: [
		bar addItem: (ToToggleButton labelText: 'First') ].
	self assert: bar isVertical.
	self assert: bar items size equals: 1.

	bar items withIndexDo: [ :it :idx |
		self assert: it holder position equals: idx ]
]

{ #category : #tests }
ToCheckableListElementTest >> bar2 [

	space deferAndSettle: [ 
		self statesOfAmerica do: [ :l |
			bar addItem: (ToToggleButton labelText: l) ] ].

	self
		assert: bar items size
		equals: self statesOfAmerica size.

	bar items withIndexDo: [ :it :idx |
		self assert: it holder position equals: idx ]
]

{ #category : #tests }
ToCheckableListElementTest >> itemChecked [

	space deferAndSettle: [
		self statesOfAmerica do: [ :l |
			bar addItem: (ToToggleButton labelText: l) ] ].
	"Must be in a separate block to let the layout loop add children before setting checking state"
	space deferAndSettle: [ bar items first checked: true ].
	self assert: bar items first isChecked.
	self assert: bar selectionModel selectedIndexes equals: #( 1 )
]

{ #category : #tests }
ToCheckableListElementTest >> itemHResizer [

	space deferAndSettle: [ 
		self statesOfAmerica do: [ :l |
			bar addItem: (ToToggleButton labelText: l) ] ].
	bar items do: [ :item |
		| isMatchParent |
		isMatchParent := item isHMatchParent.
		self assert: isMatchParent ]
]

{ #category : #tests }
ToCheckableListElementTest >> itemHeight [

	| sizeBefore |
	space deferAndSettle: [ 
		bar removeAllItems.
		sizeBefore := bar items size.
		self statesOfAmerica do: [ :l |
			bar addItem:
				(ToToggleButton new
					 labelText: l;
					 height: 100;
					 yourself) ] ].
	self assert: sizeBefore equals: 0.

	bar items do: [ :item |
		| h |
		h := item constraints vertical resizer size.
		self assert: h equals: 100 ]
]

{ #category : #tests }
ToCheckableListElementTest >> itemSelected [

	space deferAndSettle: [
		self statesOfAmerica do: [ :l |
			bar addItem: (ToToggleButton labelText: l) ] ].
	"Must be in a separate block to let the layout loop add children before setting selection state"
	space deferAndSettle: [ bar selecter selectIndex: 1 ].
	self assert: bar items first isChecked.
	self assert: bar selectionModel selectedIndexes equals: #( 1 )
]

{ #category : #tests }
ToCheckableListElementTest >> itemVResizer [

	space deferAndSettle: [ 
		self statesOfAmerica do: [ :l |
			bar addItem: (ToToggleButton labelText: l) ] ].
	bar items do: [ :item |
		| isFitContent |
		isFitContent := item isVFitContent.
		self assert: isFitContent ]
]

{ #category : #tests }
ToCheckableListElementTest >> itemWidth [

	| sizeBefore |
	space deferAndSettle: [ 
		bar removeAllItems.
		sizeBefore := bar items size.
		self statesOfAmerica do: [ :l |
			bar addItem:
				(ToToggleButton new
					 labelText: l;
					 width: 1000;
					 yourself) ] ].

	self assert: sizeBefore equals: 0.
	bar items do: [ :item |
		| w |
		w := item constraints horizontal resizer size.
		self assert: w equals: 1000 ]
]

{ #category : #running }
ToCheckableListElementTest >> setUp [ 

	super setUp.
	bar := ToCheckableListElement new.
	space deferAndSettle: [ 
		space root addChild: bar.
		bar matchParent.
		bar height: 30000 ].
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
		#Washington. #'West Virginia'. #Wisconsin. #Wyoming }
]

{ #category : #tests }
ToCheckableListElementTest >> testFiniteAdd2Items [

	space deferAndSettle: [ bar useInfiniteLayout: false ].
	self add2Items 
]

{ #category : #tests }
ToCheckableListElementTest >> testFiniteAddAllItems [

	space deferAndSettle: [ bar useInfiniteLayout: false ].
	self addAllItems 
]

{ #category : #tests }
ToCheckableListElementTest >> testFiniteAddItem [

	space deferAndSettle: [ bar useInfiniteLayout: false ].
	self addItem
]

{ #category : #tests }
ToCheckableListElementTest >> testFiniteBar2 [

	space deferAndSettle: [ bar useInfiniteLayout: false ].
	self bar2
]

{ #category : #tests }
ToCheckableListElementTest >> testFiniteItemChecked [

	space deferAndSettle: [ bar useInfiniteLayout: false ].
	self itemChecked 
]

{ #category : #tests }
ToCheckableListElementTest >> testFiniteItemHResizer [

	space deferAndSettle: [ bar useInfiniteLayout: false ].
	self itemHResizer 
]

{ #category : #tests }
ToCheckableListElementTest >> testFiniteItemHeight [

	space deferAndSettle: [ bar useInfiniteLayout: false ].
	self itemHeight 
]

{ #category : #tests }
ToCheckableListElementTest >> testFiniteItemSelected [

	space deferAndSettle: [ bar useInfiniteLayout: false ].
	self itemSelected
]

{ #category : #tests }
ToCheckableListElementTest >> testFiniteItemVResizer [

	space deferAndSettle: [ bar useInfiniteLayout: false ].
	self itemVResizer 
]

{ #category : #tests }
ToCheckableListElementTest >> testFiniteItemWidth [

	space deferAndSettle: [ bar useInfiniteLayout: false ].
	self itemWidth
]

{ #category : #tests }
ToCheckableListElementTest >> testInfiniteAdd2Items [

	space deferAndSettle: [ bar useInfiniteLayout: true ].
	self add2Items 
]

{ #category : #tests }
ToCheckableListElementTest >> testInfiniteAddAllItems [

	space deferAndSettle: [ bar useInfiniteLayout: true ].
	self addAllItems 
]

{ #category : #tests }
ToCheckableListElementTest >> testInfiniteAddItem [

	space deferAndSettle: [ bar useInfiniteLayout: true ].
	self addItem
]

{ #category : #tests }
ToCheckableListElementTest >> testInfiniteBar2 [

	space deferAndSettle: [ bar useInfiniteLayout: true ].
	self bar2
]

{ #category : #tests }
ToCheckableListElementTest >> testInfiniteItemChecked [

	space deferAndSettle: [ bar useInfiniteLayout: true ].
	self itemChecked 
]

{ #category : #tests }
ToCheckableListElementTest >> testInfiniteItemHResizer [

	space deferAndSettle: [ bar useInfiniteLayout: true ].
	self itemHResizer 
]

{ #category : #tests }
ToCheckableListElementTest >> testInfiniteItemHeight [

	space deferAndSettle: [ bar useInfiniteLayout: true ].
	self itemHeight 
]

{ #category : #tests }
ToCheckableListElementTest >> testInfiniteItemSelected [

	space deferAndSettle: [ bar useInfiniteLayout: true ].
	self itemSelected
]

{ #category : #tests }
ToCheckableListElementTest >> testInfiniteItemVResizer [

	space deferAndSettle: [ bar useInfiniteLayout: true ].
	self itemVResizer 
]

{ #category : #tests }
ToCheckableListElementTest >> testInfiniteItemWidth [

	space deferAndSettle: [ bar useInfiniteLayout: true ].
	self itemWidth
]
