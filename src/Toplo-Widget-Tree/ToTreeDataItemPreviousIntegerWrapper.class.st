Class {
	#name : #ToTreeDataItemPreviousIntegerWrapper,
	#superclass : #ToTreeDataItemWrapper,
	#category : #'Toplo-Widget-Tree-examples'
}

{ #category : #accessing }
ToTreeDataItemPreviousIntegerWrapper >> dataItemChildren [

	^ dataItem = 1
		  ifTrue: [ {} ]
		  ifFalse: [ {dataItem - 1} ]
]
