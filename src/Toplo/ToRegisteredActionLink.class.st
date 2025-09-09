Class {
	#name : #ToRegisteredActionLink,
	#superclass : #Object,
	#instVars : [
		'actionLink',
		'handlers',
		'nextRunCount'
	],
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #accessing }
ToRegisteredActionLink >> actionLink [

	^ actionLink
]

{ #category : #initialization }
ToRegisteredActionLink >> initialize [ 

	super initialize.
	handlers := OrderedCollection new
]

{ #category : #accessing }
ToRegisteredActionLink >> nextRunCount [

	^ nextRunCount
]

{ #category : #accessing }
ToRegisteredActionLink >> nextRunCount: anInteger [

	nextRunCount := anInteger
]

{ #category : #'registering / unregistering' }
ToRegisteredActionLink >> registerActionLink: anActionLink inPool: anActionLinkPool [

	actionLink := anActionLink.
	nextRunCount := actionLink runCount + 1.
	handlers add: (anActionLink
		           addEventHandlerOn: ToActionRunnedEvent
		           do: [ :evt | evt sendTo: anActionLinkPool ]).
	handlers add: (anActionLink
		           addEventHandlerOn: ToActionRunRequest
		           do: [ :evt | evt sendTo: anActionLinkPool ])
]

{ #category : #'registering / unregistering' }
ToRegisteredActionLink >> unregisterActionLinkFromPool: anActionLinkPool [

	handlers do: [ :h | actionLink removeEventHandler: h ].
	handlers removeAll.
	actionLink := nil
]
