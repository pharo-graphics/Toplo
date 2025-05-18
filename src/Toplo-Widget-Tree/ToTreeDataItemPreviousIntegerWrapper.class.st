Class {
	#name : #ToTreeDataItemPreviousIntegerWrapper,
	#superclass : #ToTreeDataItemWrapper,
	#category : #'Toplo-Widget-Tree-examples'
}

{ #category : #accessing }
ToTreeDataItemPreviousIntegerWrapper >> computedChildren [

	^ dataItem = 1
		  ifTrue: [ {} ]
		  ifFalse: [ {dataItem - 1} ]
]
