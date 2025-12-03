"
A ToCheckableBarElementTest is a test class for testing the behavior of ToCheckableBarElement
"
Class {
	#name : #ToCheckableBarElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'bar'
	],
	#category : #'Toplo-Widget-List-Tests-ItemBar'
}

{ #category : #running }
ToCheckableBarElementTest >> setUp [ 

	super setUp.
	bar := ToCheckableBarElement new.
	space root addChild: bar.
	bar matchParent.
	self statesOfAmerica do: [ :l | bar addItem: (ToToggleButton new labelText: l) ]
	
]

{ #category : #accessing }
ToCheckableBarElementTest >> statesOfAmerica [

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
ToCheckableBarElementTest >> testBar0 [

	self assert: bar isVertical.
	self assert: bar items size equals: self statesOfAmerica size.

]

{ #category : #tests }
ToCheckableBarElementTest >> testItemChecked [

	bar items first checked: true.
	self assert: bar items first isChecked.
	self waitTestingSpaces.
	self assert: bar selectionModel selectedIndexes equals: #( 1 )
]

{ #category : #tests }
ToCheckableBarElementTest >> testItemSelected [

	bar selecter selectIndex: 1.
	self waitTestingSpaces.
	self assert: bar items first isChecked.
	self waitTestingSpaces.
	self assert: bar selectionModel selectedIndexes equals: #( 1 )
]
