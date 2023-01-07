Class {
	#name : #ToPairElement,
	#superclass : #ToWidget,
	#traits : 'TToPair',
	#classTraits : 'TToPair classTrait',
	#category : #'Toplo-Core-Pair'
}

{ #category : #initialization }
ToPairElement >> initialize [

	super initialize.
	self initializePair 
]
