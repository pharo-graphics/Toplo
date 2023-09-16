Class {
	#name : #ToLookEventSubscription,
	#superclass : #Object,
	#instVars : [
		'lookEventClass'
	],
	#category : #'Toplo-Theme-Skin'
}

{ #category : #testing }
ToLookEventSubscription >> canReceiveEvent: aLookEvent [ 

	^ self eventClass = aLookEvent class 
]

{ #category : #testing }
ToLookEventSubscription >> canReplace: anotherSubscription [

	^ false
]

{ #category : #accessing }
ToLookEventSubscription >> eventClass [

	^ lookEventClass
]

{ #category : #accessing }
ToLookEventSubscription >> eventClass: aLookEventClass [

	lookEventClass := aLookEventClass
]

{ #category : #operating }
ToLookEventSubscription >> receiveLookEvent: aLookEvent [

	self subclassResponsibility 
]
