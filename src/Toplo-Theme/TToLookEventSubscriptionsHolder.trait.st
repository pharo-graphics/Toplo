Trait {
	#name : #TToLookEventSubscriptionsHolder,
	#category : #'Toplo-Theme-Skin'
}

{ #category : #'t - look event subscription holder - accessing' }
TToLookEventSubscriptionsHolder >> addAllSubscriptions: aSubscriptionCollection [

	self rawSubscriptions: (self rawSubscriptions copyWithAll: aSubscriptionCollection)
]

{ #category : #'t - look event subscription holder - accessing' }
TToLookEventSubscriptionsHolder >> addSubscription: aSubscription [

	self rawSubscriptions: (self rawSubscriptions copyWith: aSubscription)
]

{ #category : #'t - look event subscription holder - accessing' }
TToLookEventSubscriptionsHolder >> rawSubscriptions [

	^ self explicitRequirement
]

{ #category : #'t - look event subscription holder - accessing' }
TToLookEventSubscriptionsHolder >> rawSubscriptions: anArray [

	self explicitRequirement
]

{ #category : #'t - look event subscription holder - accessing' }
TToLookEventSubscriptionsHolder >> removeAllSubscriptions: aSubscriptionCollection [

	self rawSubscriptions: (self rawSubscriptions copyWithoutAll: aSubscriptionCollection)
]

{ #category : #'t - look event subscription holder - accessing' }
TToLookEventSubscriptionsHolder >> removeSubscription: aSubscription [

	self rawSubscriptions: (self rawSubscriptions copyWithout: aSubscription)
]

{ #category : #'t - look event subscription holder - accessing' }
TToLookEventSubscriptionsHolder >> subscriptions [

	^ self rawSubscriptions 
]

{ #category : #'t - look event subscription holder - accessing' }
TToLookEventSubscriptionsHolder >> subscriptions: aLookEventSubscriptionCollection [

	^ self addAllSubscriptions: aLookEventSubscriptionCollection
]
