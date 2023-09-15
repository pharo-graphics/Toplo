Class {
	#name : #ToElementSubscription,
	#superclass : #ToLookEventSubscription,
	#instVars : [
		'valuable'
	],
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #testing }
ToElementSubscription >> canReplace: anotherSubscription [

	^ (self isKindOf: anotherSubscription class) and: [
		  self eventClass = anotherSubscription eventClass ]
]

{ #category : #operating }
ToElementSubscription >> receiveLookEvent: aLookEvent [

	(self canReceiveEvent: aLookEvent) ifFalse: [  ^ self ].
	self valuable value: aLookEvent currentTarget
]

{ #category : #accessing }
ToElementSubscription >> valuable [

	^ valuable
]

{ #category : #accessing }
ToElementSubscription >> valuable: aValuable [

	valuable := aValuable  
]
