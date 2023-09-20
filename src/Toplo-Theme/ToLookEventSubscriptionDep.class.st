Class {
	#name : #ToLookEventSubscriptionDep,
	#superclass : #Object,
	#instVars : [
		'lookEventClass'
	],
	#category : 'Toplo-Theme-Skin-dep'
}

{ #category : #testing }
ToLookEventSubscriptionDep >> canReceiveEvent: aLookEvent [ 

	^ self eventClass = aLookEvent class 
]

{ #category : #testing }
ToLookEventSubscriptionDep >> canReplace: anotherSubscription [

	^ false
]

{ #category : #operating }
ToLookEventSubscriptionDep >> elementLookEvent: anEvent [

	(self canReceiveEvent: anEvent) ifTrue: [ self receiveEvent: anEvent ]
]

{ #category : #accessing }
ToLookEventSubscriptionDep >> eventClass [

	^ lookEventClass
]

{ #category : #accessing }
ToLookEventSubscriptionDep >> eventClass: aLookEventClass [

	lookEventClass := aLookEventClass
]

{ #category : #operating }
ToLookEventSubscriptionDep >> receiveEvent: aLookEvent [

	self subclassResponsibility 
]
