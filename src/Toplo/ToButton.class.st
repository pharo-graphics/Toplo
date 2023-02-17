Class {
	#name : #ToButton,
	#superclass : #ToPairedButton,
	#traits : 'TToLabeledIcon',
	#classTraits : 'TToLabeledIcon classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #initialization }
ToButton >> initialize [

	self class initializeSlots: self.
	super initialize.
	self initializePair.
	
	self initializeDresser 
]
