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

{ #category : #'as yet unclassified' }
ToButton >> icon [

	^ icon
]

{ #category : #'as yet unclassified' }
ToButton >> icon: anImage [

	icon := anImage
]

{ #category : #initialization }
ToButton >> initialize [

	self class initializeSlots: self.
	super initialize.
	self initializeButton.
	
	self initializeDresser 
]

{ #category : #'t - labeled accessing' }
ToButton >> label [

	^ label
]

{ #category : #'t - labeled accessing' }
ToButton >> label: aLabel [

	label := aLabel
	
]

{ #category : #'t - labeled initialization' }
ToButton >> rowLayingOut [

	| fill la ic |
	fill := self isJustified
		        ifTrue: [ self privateMatchParentFill ]
		        ifFalse: [  ].
	la := self label text ifNotEmpty: [ self label] ifEmpty: [ nil ].
	ic := self icon hasInnerImage ifTrue: [ self icon ] ifFalse: [ nil ].
	^ (self isLabelFirst
		   ifTrue: [ 
			   { 
				   la.
				   fill.
				   ic } ]
		   ifFalse: [ 
			   { 
				   ic.
				   fill.
				   la } ]) select: #notNil
]
