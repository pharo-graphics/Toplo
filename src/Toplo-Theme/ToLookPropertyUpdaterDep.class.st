Class {
	#name : #ToLookPropertyUpdaterDep,
	#superclass : #Object,
	#category : #'Toplo-Theme-Look-Dep'
}

{ #category : #updating }
ToLookPropertyUpdaterDep >> update: anObject withValuable: aValuable [ 

	aValuable value: anObject
]

{ #category : #updating }
ToLookPropertyUpdaterDep >> update: anObject withValue: aValue [

	self subclassResponsibility 
]
