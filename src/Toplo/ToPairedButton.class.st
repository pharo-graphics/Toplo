Class {
	#name : #ToPairedButton,
	#superclass : #ToGeneralButton,
	#traits : 'TToPair + TToOrientable',
	#classTraits : 'TToPair classTrait + TToOrientable classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #initialization }
ToPairedButton >> initialize [

	self class initializeSlots: self.
	super initialize.
	self initializePair
]
