Class {
	#name : #ToPropertyWritersHolderElementForTest,
	#superclass : #Object,
	#traits : 'TToLookEventListenerRegistry',
	#classTraits : 'TToLookEventListenerRegistry classTrait',
	#instVars : [
		'lookEventListeners'
	],
	#category : 'Toplo-Tests-Core-StyleSheet'
}

{ #category : #'t - look event listener registry' }
ToPropertyWritersHolderElementForTest >> rawLookEventListeners [

	^ lookEventListeners
]

{ #category : #'t - look event listener registry' }
ToPropertyWritersHolderElementForTest >> rawLookEventListeners: aLookEventListenerCollection [

	lookEventListeners := aLookEventListenerCollection
]
