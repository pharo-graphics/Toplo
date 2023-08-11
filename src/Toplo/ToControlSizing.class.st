Class {
	#name : #ToControlSizing,
	#superclass : #Object,
	#category : #'Toplo-Core-Theme'
}

{ #category : #hook }
ToControlSizing >> applyOn: anElement [

	anElement height: (self heightOn: anElement)
]

{ #category : #hook }
ToControlSizing >> heightOn: anElement [ 

	self subclassResponsibility 
]

{ #category : #'private geometry' }
ToControlSizing >> shapingRadiusIn: anElement [

	^ self subclassResponsibility
]
