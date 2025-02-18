Class {
	#name : #ToTreeDataItemStringWithoutFirstWrapper,
	#superclass : #ToTreeDataItemWrapper,
	#category : #'Toplo-Widget-Tree'
}

{ #category : #'as yet unclassified' }
ToTreeDataItemStringWithoutFirstWrapper >> determineChildren [

	^ dataItem size = 1
		  ifFalse: [
			  OrderedCollection new
				  add: (dataItem withoutPrefix: dataItem first asString);
				  yourself ]
		  ifTrue: [ OrderedCollection empty ]
]
