Class {
	#name : #ToOverlayElement,
	#superclass : #BlOverlayElement,
	#traits : 'TToElement',
	#classTraits : 'TToElement classTrait',
	#category : #'Toplo-Core-Overlay'
}

{ #category : #'api - attaching / detaching' }
ToOverlayElement >> attachToParent: anElement [

	self attachTo: anElement.
	anElement addChild: self
]

{ #category : #initialization }
ToOverlayElement >> initialize [ 

	super initialize.
	self initializeForToplo.
	self preventMouseEvents 
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
ToOverlayElement >> referenceElement [

	^ overlayReferenceElement 
]
