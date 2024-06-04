Class {
	#name : #ToSieveEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'listElement',
		'sieveSelectionModel',
		'originalIndexMap'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #'api - accessing' }
ToSieveEventHandler >> eventsToHandle [
	^ { ToListPrimarySelectionChangedEvent}
]

{ #category : #accessing }
ToSieveEventHandler >> listElement: aSievedListElement [

	listElement := aSievedListElement
]

{ #category : #'api - accessing' }
ToSieveEventHandler >> listPrimarySelectionChangedEvent: anEvent [

	anEvent currentTarget pattern
		ifEmpty: [
		listElement selectionModel copySelectionFrom: sieveSelectionModel ]
		ifNotEmpty: [
			listElement dataAccessor withIndexDo: [ :d :localIndex |
				| originalIndex |
				originalIndex := originalIndexMap at: d.
				sieveSelectionModel
					transferSelectionFromIndex: originalIndex
					toIndex: localIndex
					in: listElement selectionModel ] ].

	" dispatch a specific, different from the primary selection change event that will be sent after.
	It is useful for sieve list user that relies on the sieve internal selection to adapt themeself 
	according to the sieve selection"
	listElement dispatchEvent: (ToSieveSelectionChangedEvent new
			 sieve: anEvent currentTarget;
			 selectionModel: sieveSelectionModel;
			 yourself).
	listElement dispatchEvent: ToListPrimarySelectionDirtyEvent new.
]

{ #category : #'api - hooks' }
ToSieveEventHandler >> onInstalledIn: aSieve [

	super onInstalledIn: aSieve.
	sieveSelectionModel := aSieve selectionModel.
	originalIndexMap := aSieve originalIndexMap
]
