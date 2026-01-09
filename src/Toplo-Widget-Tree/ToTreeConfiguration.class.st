Class {
	#name : #ToTreeConfiguration,
	#superclass : #ToListConfiguration,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'node configuration' }
ToTreeConfiguration >> configureNode: aNode [

	super configureNode: aNode.
	aNode isVExact ifFalse: [ aNode vFitContent ]
]
