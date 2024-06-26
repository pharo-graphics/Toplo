Extension { #name : #ToSkinEvent }

{ #category : #'*Toplo-IDE' }
ToSkinEvent >> eventName [

	^ self class eventName
]

{ #category : #'*Toplo-IDE' }
ToSkinEvent class >> eventName [

	| eventGroups |
	eventGroups := self name
		               regex: '[A-Z][a-z]*'
		               matchesCollect: [ :each | each ].
	eventGroups first = 'To' ifTrue: [eventGroups := eventGroups allButFirst].( (eventGroups last: 2) allSatisfy: [ :each | each = 'Skin' or: [ each = 'Event' ] ] ) ifTrue: [ eventGroups := eventGroups allButLast: 2 ].
	^ Character space join: eventGroups
]
