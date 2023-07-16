Class {
	#name : #ToPairedButton2,
	#superclass : #ToGeneralButton,
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #initialization }
ToPairedButton2 >> initialize [

	super initialize.
	self initializePair
]
