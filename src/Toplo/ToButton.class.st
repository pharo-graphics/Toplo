Class {
	#name : #ToButton,
	#superclass : #ToGeneralButton,
	#traits : 'TToPair + TToLabeledIcon + TToOrientable',
	#classTraits : 'TToPair classTrait + TToLabeledIcon classTrait + TToOrientable classTrait',
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
	self initializePair.
	
	self initializeDresser 
]
