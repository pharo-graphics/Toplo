Class {
	#name : #ToLookEventSubscription,
	#superclass : #Object,
	#instVars : [
		'lookEventClass',
		'writers'
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

{ #category : #'private - accessing' }
ToLookEventSubscription >> eventClass: aLookEventClass [

	lookEventClass := aLookEventClass
]

{ #category : #operating }
ToLookEventSubscription >> receiveEvent: aLookEvent [

	| target |
	(self canReceiveEvent: aLookEvent) ifFalse: [ ^ self ].
	target := aLookEvent currentTarget.
	self writers do: [ :w | w writeTo: target ]
]

{ #category : #accessing }
ToLookEventSubscription >> writers [

	^ writers ifNil: [ writers := #(  ) ]
]

{ #category : #accessing }
ToLookEventSubscription >> writers: aPropertyWriterCollection [

	writers := aPropertyWriterCollection asArray
]
