Class {
	#name : #ToWidget,
	#superclass : #ToElement,
	#traits : 'TToWidget',
	#classTraits : 'TToWidget classTrait',
	#category : #'Toplo-Core'
}

{ #category : #initialization }
ToWidget >> initialize [ 

	super initialize.
	self dresser: self defaultDresser 

]
