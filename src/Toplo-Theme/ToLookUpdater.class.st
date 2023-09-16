Class {
	#name : #ToLookUpdater,
	#superclass : #ToElementLook,
	#instVars : [
		'property',
		'subscriptions',
		'supplement'
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

{ #category : #'syntactic sugar' }
ToLookUpdater >> clickedValue: anObjectOrBlock [

	^ self when: ToClickedLookEvent value: anObjectOrBlock
]

{ #category : #'syntactic sugar' }
ToLookUpdater >> disabledValue: anObjectOrBlock [

	^ self when: ToDisabledLookEvent value: anObjectOrBlock
]

{ #category : #'api - accessing' }
ToLookUpdater >> findLookUpdaterForPropertyNamed: name [

	self property name = name ifTrue: [ ^ self ].
	^ super findLookUpdaterForPropertyNamed: name
]

{ #category : #'syntactic sugar' }
ToLookUpdater >> focusedValue: anObjectOrBlock [

	^ self when: ToFocusedLookEvent value: anObjectOrBlock
]

{ #category : #'syntactic sugar' }
ToLookUpdater >> hoveredValue: anObjectOrBlock [

	^ self when: ToHoveredLookEvent value: anObjectOrBlock
]

{ #category : #'syntactic sugar' }
ToLookUpdater >> initialValue: anObjectOrBlock [

	^ self when: ToInitialLookEvent value: anObjectOrBlock
]

{ #category : #initialization }
ToLookUpdater >> initialize [ 

	super initialize.
	subscriptions := #().
	supplement := false
]

{ #category : #'syntactic sugar' }
ToLookUpdater >> installValue: anObjectOrBlock [

	^ self when: ToInstallLookEvent value: anObjectOrBlock
]

{ #category : #'syntactic sugar' }
ToLookUpdater >> leavedValue: anObjectOrBlock [

	^ self when: ToLeavedLookEvent value: anObjectOrBlock
]

{ #category : #'syntactic sugar' }
ToLookUpdater >> openedValue: anObjectOrBlock [

	^ self when: ToOpenedLookEvent value: anObjectOrBlock
]

{ #category : #'syntactic sugar' }
ToLookUpdater >> pressedValue: anObjectOrBlock [

	^ self when: ToPressedLookEvent value: anObjectOrBlock
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
ToLookUpdater >> removeAllSubscriptions: aSubscriptionCollection [

	subscriptions := subscriptions copyWithoutAll: aSubscriptionCollection
]

{ #category : #accessing }
ToLookUpdater >> removeSubscription: aSubscription [

	subscriptions := subscriptions copyWithout: aSubscription
]

{ #category : #'syntactic sugar' }
ToLookUpdater >> selectedValue: anObjectOrBlock [

	^ self when: ToSelectedLookEvent value: anObjectOrBlock
]

{ #category : #accessing }
ToLookUpdater >> subscriptions [

	^ subscriptions 
]

{ #category : #accessing }
ToLookUpdater >> supplement [

	^ supplement 
]

{ #category : #accessing }
ToLookUpdater >> supplement: aBoolean [

	supplement := aBoolean
]

{ #category : #'syntactic sugar' }
ToLookUpdater >> uninstallValue: anObjectOrBlock [

	^ self when: ToUninstallLookEvent value: anObjectOrBlock
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

	| subscr replacedSubscriptions |
	self property ifNil: [ Error signal: 'Invalid use: property is nil ' ].
	subscr := ToPropertySubscription new
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
ToLookUpdater >> whenAll: aLookEventClassCollection value: aBlockOrValue [

	aLookEventClassCollection do: [ :e | self when: e value: aBlockOrValue]
]
