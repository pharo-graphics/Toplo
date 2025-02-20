"
I am a Tree Node,

I visually represent a line of data from a tree structure
"
Class {
	#name : #ToTreeNode,
	#superclass : #ToListNode,
	#instVars : [
		'nodeHolder'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #initialization }
ToTreeNode >> initialize [

	super initialize.
]

{ #category : #skin }
ToTreeNode >> newRawSkin [ 
	
	^ ToTreeNodeSkin new
]

{ #category : #accessing }
ToTreeNode >> nodeHolder [ 
	
	^ nodeHolder 
]

{ #category : #accessing }
ToTreeNode >> nodeHolder: aToTreeNodeHolder [ 
	
	nodeHolder := aToTreeNodeHolder 
]
