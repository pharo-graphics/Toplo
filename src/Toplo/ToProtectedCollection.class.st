Class {
	#name : #ToProtectedCollection,
	#superclass : #Object,
	#traits : 'TToProtectedCollection',
	#classTraits : 'TToProtectedCollection classTrait',
	#instVars : [
		'collection',
		'monitor'
	],
	#category : #'Toplo-Core-Collection'
}

{ #category : #'t - protected collection - accessing' }
ToProtectedCollection >> collection [

	^ collection 

]

{ #category : #'t - protected collection - private' }
ToProtectedCollection >> dataCritical: aBlock [

	monitor critical: [ ^ aBlock value ]
]

{ #category : #'t - protected collection - private' }
ToProtectedCollection >> ensureNewMutex [

	monitor := Monitor new
]

{ #category : #initialization }
ToProtectedCollection >> initialize [

	super initialize.
	collection := OrderedCollection new.
	self ensureNewMutex 
]
