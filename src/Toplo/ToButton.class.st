Class {
	#name : #ToButton,
	#superclass : #ToGeneralButton,
	#traits : 'TToLabeled + TToOrientable',
	#classTraits : 'TToLabeled classTrait + TToOrientable classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - initialization dresser' }
ToButton >> defaultDresser [

	^ ToButtonDresser new
]

{ #category : #initialization }
ToButton >> initialize [

	self class initializeSlots: self.
	super initialize.
	self initializeLabeled.
	
	self initializeDresser 
]

{ #category : #'t - labeled initialization' }
ToButton >> rowLayingOut [

	| fill  |
	fill := self isJustified
		        ifTrue: [ self privateMatchParentFill ]
		        ifFalse: [  ].
	^ (self isLabelFirst
		   ifTrue: [ 
			   { 
				   self label.
				   fill.
				   self element } ]
		   ifFalse: [ 
			   { 
				   self element.
				   fill.
				   self label } ]) select: #notNil
]
