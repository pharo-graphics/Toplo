Class {
	#name : #ToElementSubscription,
	#superclass : #ToLookEventSubscription,
	#instVars : [
		'valuable'
	],
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #converting }
ToElementSubscription >> asElementSubscription [

	^ self
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
