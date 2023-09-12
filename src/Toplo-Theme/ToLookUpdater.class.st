Class {
	#name : #ToLookUpdater,
	#superclass : #ToElementLook,
	#instVars : [
		'announcer',
		'property'
	],
	#category : #'Toplo-Theme-Look'
}

{ #category : #'instance creation' }
ToLookUpdater class >> forProperty: aPropertyDefinition [

	^ self new property: aPropertyDefinition
]

{ #category : #'instance creation' }
ToLookUpdater class >> forPropertyNamed: aName [

	^ self forProperty: (ToExplicitPropertyDef propertyNamed: aName)
]

{ #category : #operating }
ToLookUpdater >> announceLookEvent: aLookEvent [

	| prevUpdater |
	prevUpdater := aLookEvent currentUpdater.
	aLookEvent currentUpdater: self.
	self announcer announce: aLookEvent.
	aLookEvent currentUpdater: prevUpdater
]

{ #category : #accessing }
ToLookUpdater >> announcer [

	^ announcer
]

{ #category : #initialization }
ToLookUpdater >> initialize [ 

	super initialize.
	announcer := Announcer new
]

{ #category : #accessing }
ToLookUpdater >> property [

	^ property
]

{ #category : #accessing }
ToLookUpdater >> property: aPropertyDefinition [

	property := aPropertyDefinition 
]

{ #category : #initialization }
ToLookUpdater >> propertyNamed: aName [

	^ self property: (self propertyDefMap propertyNamed: aName)
]

{ #category : #declaring }
ToLookUpdater >> when: aLookEventClass do: aStateUpdater [

	self announcer weak
		when: aLookEventClass
		send: #announceLookEvent:
		to: aStateUpdater asElementUpdater
]

{ #category : #declaring }
ToLookUpdater >> when: aLookEventClass value: aPropertyAdapter [

	| existing |
	self property ifNil: [ Error signal: 'Invalid use: property is nil ' ].
	" only one subscription is allowed per look event class "
	existing := self announcer subscriptions subscriptions detect: [:s | s announcementClass = aLookEventClass] ifNone: [].
	existing ifNotNil: [ self announcer removeSubscription: existing ].
	self announcer
		when: aLookEventClass
		send: #announceLookEvent:
		to: (aPropertyAdapter asPropertyUpdaterFor: self property)
]

{ #category : #declaring }
ToLookUpdater >> when: aLookEventClass value: aPropertyAdapter animation: anAnimation [

	self property ifNil: [ Error signal: 'Invalid use: property is nil ' ].
	self announcer 
		when: aLookEventClass
		send: #announceLookEvent:
		to: ((aPropertyAdapter asPropertyUpdaterFor: self property) animation: anAnimation)
]
