Class {
	#name : #ToLookUpdater,
	#superclass : #ToElementLook,
	#instVars : [
		'property',
		'subscriptions'
	],
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #'instance creation' }
ToLookUpdater class >> forProperty: aPropertyDefinition [

	^ self new property: aPropertyDefinition
]

{ #category : #operating }
ToLookUpdater >> announceLookEvent: aLookEvent [

	| prevUpdater |
	prevUpdater := aLookEvent currentUpdater.
	aLookEvent currentUpdater: self.
	self subscriptions do: [ :u | u announceLookEvent: aLookEvent ].
	aLookEvent currentUpdater: prevUpdater
]

{ #category : #'api - accessing' }
ToLookUpdater >> findLookUpdaterForPropertyNamed: name [

	self property name = name ifTrue: [ ^ self ].
	^ super findLookUpdaterForPropertyNamed: name
]

{ #category : #initialization }
ToLookUpdater >> initialize [ 

	super initialize.
	subscriptions := OrderedCollection new
]

{ #category : #accessing }
ToLookUpdater >> property [

	^ property
]

{ #category : #accessing }
ToLookUpdater >> property: aPropertyDefinition [

	property := aPropertyDefinition 
]

{ #category : #accessing }
ToLookUpdater >> subscriptions [

	^ subscriptions 
]

{ #category : #declaring }
ToLookUpdater >> when: aLookEventClass do: aSubscription [

	| v |
	v := aSubscription asElementSubscription
		     lookEventClass: aLookEventClass;
		     yourself.
	subscriptions add: v
]

{ #category : #declaring }
ToLookUpdater >> when: aLookEventClass value: aPropertySubscription [

	self when: aLookEventClass value: aPropertySubscription animation: nil
]

{ #category : #declaring }
ToLookUpdater >> when: aLookEventClass value: aPropertyAdapter animation: anAnimation [

	| existing |
	self property ifNil: [ Error signal: 'Invalid use: property is nil ' ].
	" only one subscription is allowed per look event class "
	existing := self subscriptions detect: [ :u | u isPropertyBased and: [ u lookEventClass = aLookEventClass ] ] ifNone: [  ].
	existing ifNotNil: [ self subscriptions remove: existing ].
	self subscriptions add: ((aPropertyAdapter asPropertySubscriptionFor: self property)
			 lookEventClass: aLookEventClass;
			 animation: anAnimation;
			 yourself)
]
