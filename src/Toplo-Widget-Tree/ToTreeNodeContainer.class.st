Class {
	#name : #ToTreeNodeContainer,
	#superclass : #ToNodeContainer,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #testing }
ToTreeNodeContainer >> hasLeafDataItem [

	^ self holder dataWrapper hasLeafDataItem
]

{ #category : #'instance creation' }
ToTreeNodeContainer >> indentFiller [

	^ self startContainer childWithId: #indentFiller
]

{ #category : #accessing }
ToTreeNodeContainer >> indentWidth: aNumber [

	self indentFiller width: aNumber
]

{ #category : #initialization }
ToTreeNodeContainer >> initialize [

	super initialize.
	self addEventHandlerOn: ToArrowButtonClickedEvent do: [ :event |
			event consume.
			self toggle ]
]

{ #category : #skin }
ToTreeNodeContainer >> newRawSkin [ 
	
	^ ToTreeNodeContainerSkin new
]

{ #category : #accessing }
ToTreeNodeContainer >> nodeDepth [

	^ self holder dataWrapper nodeDepth
]

{ #category : #testing }
ToTreeNodeContainer >> toggle [

	^ self holder dataWrapper toggle
]
