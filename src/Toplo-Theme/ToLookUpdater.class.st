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

{ #category : #accessing }
ToLookUpdater >> addSubscription: aSubscription [

	subscriptions := subscriptions copyWith: aSubscription
]

{ #category : #'api - accessing' }
ToLookUpdater >> findLookUpdaterForPropertyNamed: name [

	self property name = name ifTrue: [ ^ self ].
	^ super findLookUpdaterForPropertyNamed: name
]

{ #category : #initialization }
ToLookUpdater >> initialize [ 

	super initialize.
	subscriptions := #()
]

{ #category : #accessing }
ToLookUpdater >> property [

	^ property
]

{ #category : #accessing }
ToLookUpdater >> property: aLookProperty [

	property ifNotNil: [ ^ Error signal: 'The property can be set only once' ].
	property  := aLookProperty
]

{ #category : #operating }
ToLookUpdater >> receiveLookEvent: aLookEvent [

	| prevUpdater |
	prevUpdater := aLookEvent currentUpdater.
	aLookEvent currentUpdater: self.
	" now continue with subscriptions "
	self subscriptions do: [ :u | u receiveLookEvent: aLookEvent ].
	aLookEvent currentUpdater: prevUpdater
]

{ #category : #accessing }
ToLookUpdater >> removeSubscription: aSubscription [

	subscriptions := subscriptions copyWithout: aSubscription
]

{ #category : #accessing }
ToLookUpdater >> subscriptions [

	^ subscriptions 
]

{ #category : #declaring }
ToLookUpdater >> when: aLookEventClass do: aBlock [

	| subscr |
	subscr := ToElementSubscription new
		          valuable: aBlock;
		          eventClass: aLookEventClass;
		          yourself.
	self addSubscription:subscr
]

{ #category : #declaring }
ToLookUpdater >> when: aLookEventClass value: aBlockOrValue [

	self when: aLookEventClass value: aBlockOrValue animation: nil
]

{ #category : #declaring }
ToLookUpdater >> when: aLookEventClass value: aBlockOrValue animation: anAnimation [

	| subscr |
	self property ifNil: [ Error signal: 'Invalid use: property is nil ' ].
	subscr := ToPropertySubscription new
		          value: aBlockOrValue;
		          property: self property;
		          animation: anAnimation;
		          eventClass: aLookEventClass.
	" only one subscription is allowed per look event class and for the same property "
	self subscriptions removeAllSuchThat: [ :s | subscr canReplace: s ].
	self addSubscription: subscr
]

{ #category : #declaring }
ToLookUpdater >> whenAll: aLookEventClassCollection value: aBlockOrValue [

	aLookEventClassCollection do: [ :e | self when: e value: aBlockOrValue]
]
