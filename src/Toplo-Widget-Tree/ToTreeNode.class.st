"
I am a Tree Node,

I visually represent a line of data from a tree structure
"
Class {
	#name : #ToTreeNode,
	#superclass : #ToListNode,
	#traits : 'TToTripletElement + TToLabeledIcon + TToOrientable',
	#classTraits : 'TToTripletElement classTrait + TToLabeledIcon classTrait + TToOrientable classTrait',
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #initialization }
ToTreeNode >> initialize [

	super initialize.
	self initializeAsTripletElement.
	self applySkinInstallerOnFirstRequest: true
]

{ #category : #skin }
ToTreeNode >> newRawSkin [ 
	
	^ ToTreeNodeSkin new
]

{ #category : #configuration }
ToTreeNode >> newWidgetConfiguration [ 

	^ ToTreeNodeConfiguration new
]
