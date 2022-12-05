Class {
	#name : #ToVerticalToggleButton,
	#superclass : #ToToggleButton,
	#category : #'Toplo-Widget-Button'
}

{ #category : #initialization }
ToVerticalToggleButton >> animationTranslation [

	^ 0 @ self slideLength
]

{ #category : #initialization }
ToVerticalToggleButton >> initialize [ 

	super initialize.
	self layout beVertical.
	self hFitContent.
	
	self initializeDresser 
]

{ #category : #initialization }
ToVerticalToggleButton >> slideLength [

	^ self height - self icon height - self padding top - self padding bottom
]
