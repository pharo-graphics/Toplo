Class {
	#name : #ToLookEventSubscription,
	#superclass : #Object,
	#instVars : [
		'lookEventClass'
	],
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #operating }
ToLookEventSubscription >> announceLookEvent: aLookEvent [

	self subclassResponsibility 
]

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
