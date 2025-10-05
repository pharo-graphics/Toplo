Class {
	#name : #ToEdgePane,
	#superclass : #ToBaseFloatElement,
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #'attaching  / detaching' }
ToEdgePane >> attachToElement: anElement [

	self constraintsDo: [ :c | c ignoreByLayout ].
	anElement edgePaneOverlay pushPane: self.
	
]

{ #category : #initialization }
ToEdgePane >> defaultLayout [ 

	^ BlLinearLayout new
]

{ #category : #initialization }
ToEdgePane >> defaultPlacement [ 

	^ ToAnchoredAtLeft new
]

{ #category : #initialization }
ToEdgePane >> initialize [

	super initialize.
	self vMatchParent.
	self addEventHandlerOn: BlMouseUpEvent do: [ :event | event consume ].
	self addEventHandlerOn: ToMouseUpOutsideEvent do: [ :event |
			event consume.
			event emitter pop ]
]

{ #category : #initialization }
ToEdgePane >> newInnerElement [

	^ ToPane new
]

{ #category : #'instance creation' }
ToEdgePane >> newRawSkin [ 

	^ ToEdgePaneSkin new
]
