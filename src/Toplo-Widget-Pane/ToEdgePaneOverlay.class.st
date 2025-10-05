Class {
	#name : #ToEdgePaneOverlay,
	#superclass : #ToFloatOverlay,
	#instVars : [
		'edgePaneStack'
	],
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #'api - attaching / detaching' }
ToEdgePaneOverlay >> detachFromParent [ 

	self parent resetEdgePaneOverlay.
	super detachFromParent 
]

{ #category : #accessing }
ToEdgePaneOverlay >> edgePaneStack [

	^ edgePaneStack
]

{ #category : #initialization }
ToEdgePaneOverlay >> initialize [

	super initialize.
	mouseEventAllowed := true.
	edgePaneStack := Stack new

]

{ #category : #skin }
ToEdgePaneOverlay >> newRawSkin [ 

	^ ToEdgePaneOverlaySkin new
]

{ #category : #'attaching  / detaching' }
ToEdgePaneOverlay >> pop [

	| pane |
	pane := edgePaneStack pop.
	pane removeFromParent.
	edgePaneStack ifEmpty: [ self detachFromParent ]
]

{ #category : #'attaching  / detaching' }
ToEdgePaneOverlay >> pushPane: anEdgePane [

	self addChild: anEdgePane.
	edgePaneStack push: anEdgePane.
	self addEventHandlerOn: BlMouseUpEvent do: [ :event |
			event consume.
			anEdgePane dispatchEvent: (ToMouseUpOutsideEvent new
					 sourceEvent: event;
					 emitter: self;
					 fillFromTime: self space time;
					 yourself) ]
]
