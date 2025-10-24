Class {
	#name : #ToRootModalOverlayElement,
	#superclass : #ToOverlayElement,
	#category : #'Toplo-Core-Overlay'
}

{ #category : #skin }
ToRootModalOverlayElement >> installRawStyle [ 

	super installRawStyle.
	self background: (Color veryLightGray alpha: 0.5)
]
