Class {
	#name : #ToSieveEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'dataPositionIndex',
		'sieveSelectionModel'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #'api - accessing' }
ToSieveEventHandler >> eventsToHandle [
	^ { ToListPrimarySelectionChangedEvent}
]

{ #category : #'api - accessing' }
ToSieveEventHandler >> listPrimarySelectionChangedEvent: anEvent [
]

{ #category : #'api - hooks' }
ToSieveEventHandler >> onInstalledIn: aSieve [

	super onInstalledIn: aSieve.
	sieveSelectionModel := aSieve selectionModel.
	dataPositionIndex := aSieve originalIndexMap
]
