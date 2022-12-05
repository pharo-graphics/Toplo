Class {
	#name : #ToHorizontalToggleButton,
	#superclass : #ToToggleButton,
	#category : #'Toplo-Widget-Button'
}

{ #category : #initialization }
ToHorizontalToggleButton >> animationTranslation [

	^ self slideLength @ 0
]

{ #category : #initialization }
ToHorizontalToggleButton >> initialize [ 

	super initialize.
	self layout beHorizontal.
	self vFitContent.
	
	self initializeDresser 
]

{ #category : #initialization }
ToHorizontalToggleButton >> slideLength [

	^ self width - self icon width - self padding left - self padding right
]
