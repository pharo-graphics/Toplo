Class {
	#name : #ToWidget,
	#superclass : #BlElement,
	#traits : 'TToWidget',
	#classTraits : 'TToWidget classTrait',
	#category : #'Toplo-Core'
}

{ #category : #'t - initialization' }
ToWidget >> defaultDresser [

	^ ToNullDresser new
]

{ #category : #'t - initialization' }
ToWidget >> defaultViewModel [

	^ ToViewModel new
]

{ #category : #initialization }
ToWidget >> initialize [ 

	super initialize.
	self dresser: self defaultDresser 

]
