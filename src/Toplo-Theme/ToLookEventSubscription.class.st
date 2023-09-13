Class {
	#name : #ToLookEventSubscription,
	#superclass : #Object,
	#instVars : [
		'lookEventClass'
	],
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #testing }
ToLookEventSubscription >> canReceiveEvent: aLookEvent [ 

	^ self lookEventClass == aLookEvent class 
]

{ #category : #testing }
ToLookEventSubscription >> isPropertyBased [

	^ false
]

{ #category : #accessing }
ToLookEventSubscription >> lookEventClass [

	^ lookEventClass
]

{ #category : #accessing }
ToLookEventSubscription >> lookEventClass: aLookEventClass [

	lookEventClass := aLookEventClass
]

{ #category : #operating }
ToLookEventSubscription >> receiveLookEvent: aLookEvent [

	self subclassResponsibility 
]
