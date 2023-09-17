Class {
	#name : #ToLookEventSubscription,
	#superclass : #Object,
	#traits : 'TToPropertyWriterHolder',
	#classTraits : 'TToPropertyWriterHolder classTrait',
	#instVars : [
		'writers',
		'eventClass'
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

	^ eventClass
]

{ #category : #'private - accessing' }
ToLookEventSubscription >> eventClass: aLookEventClass [

	eventClass := aLookEventClass
]

{ #category : #initialization }
ToLookEventSubscription >> initialize [ 

	super initialize.
	eventClass := ToInstallLookEvent 
]

{ #category : #'t - property writer holder - accessing' }
ToLookEventSubscription >> rawWriters [

	^ writers
]

{ #category : #'t - property writer holder - accessing' }
ToLookEventSubscription >> rawWriters: aPropertyWriterCollection [

	^ writers := aPropertyWriterCollection
]

{ #category : #operating }
ToLookEventSubscription >> receiveEvent: aLookEvent [

	| target |
	(self canReceiveEvent: aLookEvent) ifFalse: [ ^ self ].
	target := aLookEvent currentTarget.
	self writers do: [ :w | w writeTo: target ]
]
