"
I represent the list part of the table
"
Class {
	#name : #ToTableListElement,
	#superclass : #ToBasicListElement,
	#traits : 'TToTableListElement',
	#classTraits : 'TToTableListElement classTrait',
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #initialization }
ToTableListElement >> defaultNodeManagerClass [

	^ ToTableRowNodeManager
]

{ #category : #initialization }
ToTableListElement >> initialize [

	super initialize.
	self addStamp: #geometry withValue: BlRectangleGeometry new.
	self initializeScrollBar
]

{ #category : #initialization }
ToTableListElement >> initializeScrollBar [

	| vscrollBar |
	vscrollBar := BlVerticalScrollbarElement new.
	vscrollBar constraintsDo: [ :c |
			c ignoreByLayout.
			c margin: (BlInsets left: 10).
			c ignored horizontal alignRight.
			c ignored vertical alignBottom ].
	vscrollBar attachTo: self innerElement.
	vscrollBar elevation: (BlRelativeElevation elevation: 20).
	self addChild: vscrollBar
]

{ #category : #skin }
ToTableListElement >> newRawSkin [ 

	^ ToTableListElementSkin new
]
