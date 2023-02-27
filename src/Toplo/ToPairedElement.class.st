Class {
	#name : #ToPairedElement,
	#superclass : #ToWidget,
	#traits : 'TToPair + TToOrientable',
	#classTraits : 'TToPair classTrait + TToOrientable classTrait',
	#category : #'Toplo-Core-Pair'
}

{ #category : #initialization }
ToPairedElement >> initialize [

	self class initializeSlots: self.
	super initialize.
	self initializePair 
]
