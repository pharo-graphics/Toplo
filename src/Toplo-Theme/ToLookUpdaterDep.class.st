Class {
	#name : #ToLookUpdaterDep,
	#superclass : #ToElementLook,
	#instVars : [
		'property',
		'subscriptions',
		'supplement'
	],
	#category : 'Toplo-Theme-LookUpdaterDep'
}

{ #category : #'instance creation' }
ToLookUpdaterDep class >> forProperty: aPropertyDefinition [

	^ self new property: aPropertyDefinition
]

{ #category : #accessing }
ToLookUpdaterDep >> addSubscription: aSubscription [

	subscriptions := subscriptions copyWith: aSubscription
]

{ #category : #initialization }
ToLookUpdaterDep >> initialize [ 

	super initialize.
	subscriptions := #().
	supplement := false
]

{ #category : #accessing }
ToLookUpdaterDep >> property [

	^ property
]

{ #category : #accessing }
ToLookUpdaterDep >> property: aLookProperty [

	property ifNotNil: [ ^ Error signal: 'The property can be set only once' ].
	property  := aLookProperty
]

{ #category : #operating }
ToLookUpdaterDep >> receiveEvent: aLookEvent [

	| prevUpdater |
	prevUpdater := aLookEvent currentUpdater.
	aLookEvent currentUpdater: self.
	" now continue with subscriptions "
	self subscriptions do: [ :u | u receiveEvent: aLookEvent ].
	aLookEvent currentUpdater: prevUpdater
]

{ #category : #accessing }
ToLookUpdaterDep >> removeAllSubscriptions: aSubscriptionCollection [

	subscriptions := subscriptions copyWithoutAll: aSubscriptionCollection
]

{ #category : #accessing }
ToLookUpdaterDep >> removeSubscription: aSubscription [

	subscriptions := subscriptions copyWithout: aSubscription
]

{ #category : #accessing }
ToLookUpdaterDep >> subscriptions [

	^ subscriptions 
]

{ #category : #accessing }
ToLookUpdaterDep >> supplement [

	^ supplement 
]

{ #category : #accessing }
ToLookUpdaterDep >> supplement: aBoolean [

	supplement := aBoolean
]

{ #category : #declaring }
ToLookUpdaterDep >> when: aLookEventClass value: aBlockOrValue [

	self when: aLookEventClass value: aBlockOrValue animation: nil
]

{ #category : #declaring }
ToLookUpdaterDep >> when: aLookEventClass value: aBlockOrValue animation: anAnimation [

	| subscr replacedSubscriptions |
	self property ifNil: [ Error signal: 'Invalid use: property is nil ' ].
	subscr := ToPropertySubscriptionDep new
		          value: aBlockOrValue;
		          property: self property;
		          animation: anAnimation;
		          eventClass: aLookEventClass.
	" only one subscription is allowed per look event class and for the same property "
	replacedSubscriptions := self subscriptions select: [ :s | subscr canReplace: s ].
	self removeAllSubscriptions: replacedSubscriptions.
	self addSubscription: subscr
]

{ #category : #declaring }
ToLookUpdaterDep >> whenAll: aLookEventClassCollection value: aBlockOrValue [

	aLookEventClassCollection do: [ :e | self when: e value: aBlockOrValue]
]
