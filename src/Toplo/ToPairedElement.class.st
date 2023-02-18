Class {
	#name : #ToPairedElement,
	#superclass : #ToWidget,
	#traits : 'TToPair + TToOrientable',
	#classTraits : 'TToPair classTrait + TToOrientable classTrait',
	#category : #'Toplo-Core-Pair'
}

{ #category : #'as yet unclassified' }
ToPairedElement >> initialize [

	super initialize.
	self initializePair 
]
