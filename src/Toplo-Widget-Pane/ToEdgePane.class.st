Class {
	#name : #ToEdgePane,
	#superclass : #ToBaseFloatElement,
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #configuration }
ToEdgePane >> applyConfiguration [

	super applyConfiguration.
	self isHMatchParent
		ifTrue: [ innerElement horizontal: true ]
		ifFalse: [ innerElement horizontal: false ].
	self isVMatchParent
		ifTrue: [ innerElement vertical: true ]
		ifFalse: [ innerElement vertical: false ]
]

{ #category : #'attaching  / detaching' }
ToEdgePane >> attachToElement: anElement [

	self constraintsDo: [ :c | c ignoreByLayout ].
	anElement edgePaneOverlay addChild: self
]

{ #category : #initialization }
ToEdgePane >> defaultPlacement [ 

	^ ToAnchoredAtLeft new
]

{ #category : #initialization }
ToEdgePane >> initialize [

	super initialize.
	self vMatchParent
]

{ #category : #initialization }
ToEdgePane >> newInnerElement [

	^ ToPane new
]

{ #category : #'instance creation' }
ToEdgePane >> newRawSkin [ 

	^ ToEdgePaneSkin new
]
