"
I am a Tree Node,

I visually represent a line of data from a tree structure
"
Class {
	#name : #ToTreeNode,
	#superclass : #ToListNode,
	#instVars : [
		'content'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToTreeNode >> content [

	^ content 
]

{ #category : #accessing }
ToTreeNode >> endElement [

	^ content endElement
]

{ #category : #initialization }
ToTreeNode >> initialize [

	super initialize.
	self applySkinInstallerOnFirstRequest: true.
	content := ToTripletElement new.
	content hMatchParent.
	content vMatchParent.
	self addChild: content
]

{ #category : #testing }
ToTreeNode >> isLeaf [

	^ self holder dataItem isLeaf
]

{ #category : #skin }
ToTreeNode >> newRawSkin [ 
	
	^ ToTreeNodeSkin new
]

{ #category : #accessing }
ToTreeNode >> nodeDepth [

	^ self holder dataItem nodeDepth
]

{ #category : #accessing }
ToTreeNode >> startElement [ 

	^ content startElement
]

{ #category : #testing }
ToTreeNode >> toggle [

	^ self holder dataItem toggle
]
