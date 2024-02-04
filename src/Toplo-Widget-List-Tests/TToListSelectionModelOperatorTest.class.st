Class {
	#name : #TToListSelectionModelOperatorTest,
	#superclass : #TestCase,
	#instVars : [
		'holder',
		'selecter'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Command'
}

{ #category : #running }
TToListSelectionModelOperatorTest >> setUp [ 

	super setUp.
	holder := ToListSelectionModelHolderForTest new.
	holder dataSource: self statesOfAmerica.
	selecter := holder selecter
]

{ #category : #accessing }
TToListSelectionModelOperatorTest >> statesOfAmerica [

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
TToListSelectionModelOperatorTest >> testSelectIndex [

	selecter selectIndex: 2.
	self assert: selecter selectionModel indices first equals: 2.
	self assert: selecter selectionModel currentIndex equals: 2.
	self assert: selecter selectionModel pivot isNil.
	self assert: selecter selectionModel distance isNil
]

{ #category : #tests }
TToListSelectionModelOperatorTest >> testSelectIndexTo [

	selecter selectIndex: 2 to: 10.
	self assert: selecter selectionModel currentIndex equals: 10.
	self assert: selecter selectionModel pivot isNil.
	self assert: selecter selectionModel distance isNil
]
