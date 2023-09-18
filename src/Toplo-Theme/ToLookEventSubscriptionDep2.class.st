Class {
	#name : #ToLookEventSubscriptionDep2,
	#superclass : #Object,
	#traits : 'TToPropertyWriterHolder',
	#classTraits : 'TToPropertyWriterHolder classTrait',
	#instVars : [
		'writers',
		'eventClass',
		'supplement'
	],
	#category : #'Toplo-Theme-Skin-dep'
}

{ #category : #testing }
ToLookEventSubscriptionDep2 >> canReplace: anotherSubscription [

	^ false
]

{ #category : #accessing }
ToLookEventSubscriptionDep2 >> eventClass [

	^ eventClass
]

{ #category : #accessing }
ToLookEventSubscriptionDep2 >> eventClass: aLookEventClass [

	eventClass := aLookEventClass
]

{ #category : #initialization }
ToLookEventSubscriptionDep2 >> initialize [ 

	super initialize.
	eventClass := ToInstallLookEvent 
]

{ #category : #'t - property writer holder - accessing' }
ToLookEventSubscriptionDep2 >> rawWriters [

	^ writers
]

{ #category : #'t - property writer holder - accessing' }
ToLookEventSubscriptionDep2 >> rawWriters: aPropertyWriterCollection [

	writers := aPropertyWriterCollection
]

{ #category : #operating }
ToLookEventSubscriptionDep2 >> receiveEvent: aLookEvent [

	| target |
	(self canReceiveEvent: aLookEvent) ifFalse: [ ^ self ].
	target := aLookEvent currentTarget.
	self writers do: [ :w | w writeTo: target ]
]
