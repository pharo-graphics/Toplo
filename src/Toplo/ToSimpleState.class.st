Class {
	#name : #ToSimpleState,
	#superclass : #ToElementState,
	#traits : 'TToSimpleState',
	#classTraits : 'TToSimpleState classTrait',
	#category : #'Toplo-Core-States'
}

{ #category : #'t - simple state' }
ToSimpleState >> skinEvent [ 

	^ self subclassResponsibility 
]
