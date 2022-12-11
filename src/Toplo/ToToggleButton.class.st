Class {
	#name : #ToToggleButton,
	#superclass : #ToButton,
	#traits : 'TToCheckableWidget',
	#classTraits : 'TToCheckableWidget classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #factory }
ToToggleButton class >> horizontal [

	^ ToHorizontalToggleButton new
]

{ #category : #factory }
ToToggleButton class >> vertical [

	^ ToVerticalToggleButton new
]

{ #category : #'t - button initialization' }
ToToggleButton >> childrenLayout [

	^ (self isLabelFirst
		   ifTrue: [ 
			   { 
				   self label.
				   self privateFill.
				   self icon } ]
		   ifFalse: [ 
			   { 
				   self icon.
				   self privateFill.
				   self label } ]) select: #notNil
]

{ #category : #'t - initialization dresser' }
ToToggleButton >> defaultDresser [

	^ ToToggleButtonDresser new
]
