Class {
	#name : 'ToControlSizing',
	#superclass : 'Object',
	#category : 'Toplo-Theme-Skin-dep',
	#package : 'Toplo-Theme',
	#tag : 'Skin-dep'
}

{ #category : 'private geometry' }
ToControlSizing >> applyOn: anElement [

	self subclassResponsibility 
]

{ #category : 'private geometry' }
ToControlSizing >> heightOn: anElement [ 

	self subclassResponsibility 
]

{ #category : 'private geometry' }
ToControlSizing >> shapingRadiusIn: anElement [

	^ self subclassResponsibility
]
