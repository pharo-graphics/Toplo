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

{ #category : #accessing }
ToTreeNode >> endElement: anElement [

	content endElement: anElement
]

{ #category : #testing }
ToTreeNode >> hasLeafDataItem [

	^ self holder dataItem hasLeafDataItem
]

{ #category : #initialization }
ToTreeNode >> initialize [

	super initialize.
	self applySkinInstallerOnFirstRequest: true.
	content := ToTripletElement new.
	content hMatchParent.
	content vFitContent.
	content middleContainer constraintsDo: [:c | c horizontal matchParent ].
	self addChild: content.
	self addEventHandlerOn: ToArrowButtonClickedEvent do: [ :event |
		event consume.
		self toggle ]
]

{ #category : #testing }
ToTreeNode >> isLeaf [

	self
		deprecated: 'Use #hasLeafDataItem instead'
		transformWith: '`@rcvr isLeaf' -> '`@rcvr hasLeafDataItem'.
		
	^ self hasLeafDataItem
]

{ #category : #accessing }
ToTreeNode >> middleElement [

	^ content middleElement
]

{ #category : #accessing }
ToTreeNode >> middleElement: anElement [

	content middleElement: anElement
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

{ #category : #accessing }
ToTreeNode >> startElement: anElement [

	content startElement: anElement
]

{ #category : #accessing }
ToTreeNode >> startInterspace: anInteger [

	content startInterspace: anInteger
]

{ #category : #testing }
ToTreeNode >> toggle [

	^ self holder dataItem toggle
]
