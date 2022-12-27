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
