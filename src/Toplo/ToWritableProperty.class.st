Class {
	#name : #ToWritableProperty,
	#superclass : #ToAbstractProperty,
	#category : #'Toplo-Core-Properties'
}

{ #category : #operating }
ToWritableProperty >> write: anPropertyValue to: anObject [

	self subclassResponsibility 
]
