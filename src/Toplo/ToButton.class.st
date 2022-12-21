Class {
	#name : #ToButton,
	#superclass : #ToGeneralButton,
	#traits : 'TToButton + TToOrientableButton',
	#classTraits : 'TToButton classTrait + TToOrientableButton classTrait',
	#instVars : [
		'#label',
		'#icon'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - initialization dresser' }
ToButton >> defaultDresser [

	^ ToButtonDresser new
]

{ #category : #'t - button accessing' }
ToButton >> icon [

	^ icon
]

{ #category : #'t - button accessing' }
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

{ #category : #'t - button accessing' }
ToButton >> label [

	^ label
]

{ #category : #'t - button accessing' }
ToButton >> label: aLabel [

	label := aLabel
	
]

{ #category : #'t - button initialization' }
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
