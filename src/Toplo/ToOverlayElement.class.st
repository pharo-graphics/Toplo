Class {
	#name : #ToOverlayElement,
	#superclass : #BlOverlayElement,
	#traits : 'TToElement',
	#classTraits : 'TToElement classTrait',
	#instVars : [
		'mouseEventAllowed'
	],
	#category : #'Toplo-Core-Overlay'
}

{ #category : #configuration }
ToOverlayElement >> applyConfiguration [

	super applyConfiguration.
	mouseEventAllowed
		ifTrue: [ self allowMouseEvents ]
		ifFalse: [ self preventMouseEvents ]
]

{ #category : #'api - attaching / detaching' }
ToOverlayElement >> attachToParent: anElement [

	self attachTo: anElement.
	anElement addChild: self
]

{ #category : #'api - attaching / detaching' }
ToOverlayElement >> detachFromParent [

	self detach.
	self removeFromParent
]

{ #category : #initialization }
ToOverlayElement >> initialize [ 

	super initialize.
	self initializeForToplo.
	mouseEventAllowed := false
]

{ #category : #testing }
ToOverlayElement >> isBeneath [ 

	^ self elevation < overlayReferenceElement elevation
]

{ #category : #testing }
ToOverlayElement >> isOver [

	^ self elevation > overlayReferenceElement elevation
]

{ #category : #accessing }
ToOverlayElement >> mouseEventAllowed: aBoolean [

	aBoolean = mouseEventAllowed ifTrue: [ ^ self ].
	mouseEventAllowed := aBoolean.
	self requestConfiguration 
]

{ #category : #accessing }
ToOverlayElement >> referenceElement [

	^ overlayReferenceElement 
]
