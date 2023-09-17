Class {
	#name : #ToElementSubscriptionDep,
	#superclass : #ToLookEventSubscriptionDep,
	#instVars : [
		'valuable'
	],
	#category : #'Toplo-Theme-Skin'
}

{ #category : #testing }
ToElementSubscriptionDep >> canReplace: anotherSubscription [

	^ (self isKindOf: anotherSubscription class) and: [
		  self eventClass = anotherSubscription eventClass ]
]

{ #category : #operating }
ToElementSubscriptionDep >> receiveEvent: aLookEvent [

	(self canReceiveEvent: aLookEvent) ifFalse: [  ^ self ].
	self valuable value: aLookEvent currentTarget
]

{ #category : #accessing }
ToElementSubscriptionDep >> valuable [

	^ valuable
]

{ #category : #accessing }
ToElementSubscriptionDep >> valuable: aValuable [

	valuable := aValuable  
]
