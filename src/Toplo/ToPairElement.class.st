Class {
	#name : #ToPairElement,
	#superclass : #ToWidget,
	#traits : 'TToPair + TToOrientable',
	#classTraits : 'TToPair classTrait + TToOrientable classTrait',
	#category : #'Toplo-Core-Pair'
}

{ #category : #initialization }
ToPairElement >> initialize [

	super initialize.
	self initializePair 
]
