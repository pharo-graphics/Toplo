Class {
	#name : #ToMultiSelectSelecterCommandApplicationChecker,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'api - accessing' }
ToMultiSelectSelecterCommandApplicationChecker >> eventsToHandle [

	^ { ToListSelecterCommandApplicationRequestEvent }
]

{ #category : #'event handling' }
ToMultiSelectSelecterCommandApplicationChecker >> listSelecterCommandApplicationRequestEvent: anEvent [

	| selectElement |
	selectElement := anEvent currentTarget.
	anEvent selectionModel = selectElement selectionModel ifFalse: [ ^ self ].

]
