Class {
	#name : #ToControlSizing,
	#superclass : #Object,
	#category : #'Toplo-Core-Theme'
}

{ #category : #hook }
ToControlSizing >> applyOn: anElement [

	self subclassResponsibility 
]

{ #category : #hook }
ToControlSizing >> heightOn: anElement [ 

	self subclassResponsibility 
]

{ #category : #'private geometry' }
ToControlSizing >> shapingRadiusIn: anElement [

	^ self subclassResponsibility
]
