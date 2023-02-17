Class {
	#name : #ToPairedElement,
	#superclass : #ToWidget,
	#traits : 'TToPair + TToOrientable',
	#classTraits : 'TToPair classTrait + TToOrientable classTrait',
	#category : #'Toplo-Core-Pair'
}

{ #category : #initialization }
ToPairedElement >> initialize [

	super initialize.
	self initializePair 
]
