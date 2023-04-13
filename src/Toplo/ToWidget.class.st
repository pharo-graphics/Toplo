Class {
	#name : #ToWidget,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToEnableable',
	#classTraits : 'TToWidget classTrait + TToEnableable classTrait',
	#category : #'Toplo-Core'
}

{ #category : #initialization }
ToWidget >> initialize [ 

	super initialize.
	self dresser: self defaultDresser 

]
