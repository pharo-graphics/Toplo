Class {
	#name : #ToOverlayElement,
	#superclass : #BlOverlayElement,
	#traits : 'TToElement',
	#classTraits : 'TToElement classTrait',
	#category : #'Toplo-Core-Overlay'
}

{ #category : #testing }
ToOverlayElement >> isBeneath [ 

	^ self elevation < referenceElement elevation
]

{ #category : #testing }
ToOverlayElement >> isOver [

	^ self elevation > referenceElement elevation
]

{ #category : #accessing }
ToOverlayElement >> referenceElement [

	^ referenceElement 
]
