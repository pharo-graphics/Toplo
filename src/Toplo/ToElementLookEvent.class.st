Class {
	#name : #ToElementLookEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Core-LookEvents'
}

{ #category : #'as yet unclassified' }
ToElementLookEvent class >> eventName [

	| eventGroups |
	eventGroups := self name
		               regex: '[A-Z][a-z]*'
		               matchesCollect: [ :each | each ].
	eventGroups first = 'To' ifTrue: [eventGroups := eventGroups allButFirst].( (eventGroups last: 2) allSatisfy: [ :each | each = 'Look' or: [ each = 'Event' ] ] ) ifTrue: [ eventGroups := eventGroups allButLast: 2 ].
	^ Character space join: eventGroups
]

{ #category : #testing }
ToElementLookEvent class >> isAbstract [

	^ self == ToElementLookEvent
]

{ #category : #accessing }
ToElementLookEvent >> elementDo: aBlock [

	aBlock value: self target
]

{ #category : #'as yet unclassified' }
ToElementLookEvent >> eventName [

	^ self class eventName
]

{ #category : #'instance creation' }
ToElementLookEvent >> fromState: aState [
]

{ #category : #sending }
ToElementLookEvent >> sendTo: anObject [

	anObject elementLookEvent: self
]

{ #category : #sending }
ToElementLookEvent >> sendToStyleSheetSkin: aStyleSheetSkin [

	aStyleSheetSkin sendEventToPropertyWriters: self
]
