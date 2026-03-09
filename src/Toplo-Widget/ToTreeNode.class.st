"
I am a Tree Node,

I visually represent a line of data from a tree structure
"
Class {
	#name : #ToTreeNode,
	#superclass : #ToBasicListNode,
	#category : #'Toplo-Widget-Tree'
}

{ #category : #configuration }
ToTreeNode >> applyConfiguration [ 

	super applyConfiguration.
	self isVExact ifFalse: [ self vFitContent ]
]
