Class {
	#name : #ToBackgroundPropertyDep,
	#superclass : #ToLookPropertyUpdaterDep,
	#category : #'Toplo-Theme-Look-Dep'
}

{ #category : #updating }
ToBackgroundPropertyDep >> update: anObject withValue: aValue [

	anObject background: aValue
]
