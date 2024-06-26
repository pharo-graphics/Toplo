Class {
	#name : #ToPropertyWritersHolderElementForTest,
	#superclass : #Object,
	#traits : 'TToLookEventListenerRegistry',
	#classTraits : 'TToLookEventListenerRegistry classTrait',
	#instVars : [
		'skinEventListeners'
	],
	#category : #'Toplo-Tests-Core-StyleSheet'
}

{ #category : #'t - skin event listener registry' }
ToPropertyWritersHolderElementForTest >> rawSkinEventListeners [

	^ skinEventListeners
]

{ #category : #'t - skin event listener registry' }
ToPropertyWritersHolderElementForTest >> rawSkinEventListeners: aSkinEventListenerCollection [

	skinEventListeners := aSkinEventListenerCollection
]
