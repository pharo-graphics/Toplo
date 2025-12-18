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
	self statesOfAmerica do: [ :l | bar addItem: (ToToggleButton new labelText: l) ]
	
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
ToCheckableFiniteListElementTest >> testBar0 [

	self assert: bar isVertical.
	self assert: bar items size equals: self statesOfAmerica size.

]

{ #category : #tests }
ToCheckableFiniteListElementTest >> testItemChecked [

	bar items first checked: true.
	self assert: bar items first isChecked.
	self waitTestingSpaces.
	self assert: bar selectionModel selectedIndexes equals: #( 1 )
]

{ #category : #tests }
ToCheckableFiniteListElementTest >> testItemHResizer [

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

	bar selecter selectIndex: 1.
	self waitTestingSpaces.
	self assert: bar items first isChecked.
	self waitTestingSpaces.
	self assert: bar selectionModel selectedIndexes equals: #( 1 )
]

{ #category : #tests }
ToCheckableFiniteListElementTest >> testItemVResizer [

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
