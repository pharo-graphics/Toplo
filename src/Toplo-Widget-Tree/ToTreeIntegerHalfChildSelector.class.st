Class {
	#name : #ToTreeIntegerHalfChildSelector,
	#superclass : #ToTreeChildSelector,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToTreeIntegerHalfChildSelector >> children [

	^ dataItem // 2 = 0
	ifTrue: [ OrderedCollection empty ]
	 ifFalse: [ (dataItem // 2) asOrderedCollection ]
]
