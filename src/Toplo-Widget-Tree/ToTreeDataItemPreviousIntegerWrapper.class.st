Class {
	#name : #ToTreeDataItemPreviousIntegerWrapper,
	#superclass : #ToTreeDataItemWrapper,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToTreeDataItemPreviousIntegerWrapper >> computedChildren [

	^ dataItem = 1
		  ifTrue: [ {} ]
		  ifFalse: [ {dataItem - 1} ]
]
