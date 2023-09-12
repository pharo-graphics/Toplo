Class {
	#name : #ToElementSubscription,
	#superclass : #ToLookEventSubscription,
	#instVars : [
		'valuable'
	],
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #operating }
ToElementSubscription >> announceLookEvent: aLookEvent [

	(self canReceiveEvent: aLookEvent) ifFalse: [  ^ self ].
	self valuable value: aLookEvent currentTarget
]

{ #category : #converting }
ToElementSubscription >> asElementSubscription [

	^ self
]

{ #category : #accessing }
ToElementSubscription >> valuable [

	^ valuable
]

{ #category : #accessing }
ToElementSubscription >> valuable: aValuable [

	valuable := aValuable  
]
