Class {
	#name : #ToLookUpdater,
	#superclass : #ToElementLook,
	#instVars : [
		'announcer',
		'property',
		'subUpdaters',
		'currentAnimation'
	],
	#category : #'Toplo-Theme-Look'
}

{ #category : #'instance creation' }
ToLookUpdater class >> forProperty: aPropertyDefinition [

	^ self new property: aPropertyDefinition
]

{ #category : #'instance creation' }
ToLookUpdater class >> forPropertyNamed: aName [

	^ self forProperty: (ToPropertyDefinition propertyNamed: aName)
]

{ #category : #operating }
ToLookUpdater >> announceLookEvent: aLookEvent [

	| prevUpdater |
	prevUpdater := aLookEvent currentUpdater.
	aLookEvent currentUpdater: self.
	self announcer announce: aLookEvent.
	self subUpdaters do: [ :u | u announceLookEvent: aLookEvent ].
	aLookEvent currentUpdater: prevUpdater
]

{ #category : #accessing }
ToLookUpdater >> announcer [

	^ announcer
]

{ #category : #accessing }
ToLookUpdater >> currentAnimation [

	^ currentAnimation
]

{ #category : #accessing }
ToLookUpdater >> currentAnimation: aPropertyAnimation [

	currentAnimation ifNotNil: [ :cura | cura stop ].
	currentAnimation := aPropertyAnimation
]

{ #category : #initialization }
ToLookUpdater >> initialize [ 

	super initialize.
	announcer := Announcer new.
	subUpdaters := #()
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
ToLookUpdater >> subUpdaters [

	^ subUpdaters
]

{ #category : #accessing }
ToLookUpdater >> subUpdaters: aCollection [

	subUpdaters := aCollection
]

{ #category : #declaring }
ToLookUpdater >> when: aLookEventClass do: aStateUpdater [

	self announcer weak
		when: aLookEventClass
		send: #announceLookEvent:
		to: aStateUpdater asElementAdapter
]

{ #category : #declaring }
ToLookUpdater >> when: aLookEventClass value: aPropertyAdapter [

	self property ifNil: [ Error signal: 'Invalid use: property is nil ' ].
	self announcer 
		when: aLookEventClass
		send: #announceLookEvent:
		to: (aPropertyAdapter asPropertyAdapterFor: self property)
]

{ #category : #declaring }
ToLookUpdater >> when: aLookEventClass value: aPropertyAdapter animation: anAnimation [

	self property ifNil: [ Error signal: 'Invalid use: property is nil ' ].
	self announcer 
		when: aLookEventClass
		send: #announceLookEvent:
		to: ((aPropertyAdapter asPropertyAdapterFor: self property) animation: anAnimation)
]

{ #category : #accessing }
ToLookUpdater >> with: anArrayOfUpdaters [

	self subUpdaters: anArrayOfUpdaters
]
