Class {
	#name : #ToSieveEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'listElement'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #'api - accessing' }
ToSieveEventHandler >> eventsToHandle [

	^ { ToListPrimarySelectionChangedEvent }
]

{ #category : #accessing }
ToSieveEventHandler >> listElement: aSievedListElement [

	listElement := aSievedListElement
]

{ #category : #'api - accessing' }
ToSieveEventHandler >> listPrimarySelectionChangedEvent: anEvent [
	" I'm sent when the selecter of my sieve is used directly for a selection operation
	as an example, to intialize some selected elements programmatically "

	| sieve |
	sieve := anEvent currentTarget.
	sieve pattern
		ifEmpty: [
		listElement selectionModel copySelectionFrom: sieve selectionModel ]
		ifNotEmpty: [
				listElement dataSource withIndexDo: [ :dataItem :localIndex |
						sieve originalIndexMap at: dataItem ifPresent: [ :originalIndex |
								sieve selectionModel
									transferSelectionFromIndex: originalIndex
									toIndex: localIndex
									in: listElement selectionModel ] ] ].

	" dispatch a specific, different from the primary selection change event that will be sent after.
	It is useful for sieve list user that relies on the sieve internal selection to adapt themeself 
	according to the sieve selection"
	listElement dispatchEvent: (ToSieveSelectionChangedEvent new
			 sieve: sieve;
			 selectionModel: sieve selectionModel;
			 yourself).
	listElement updateAllSelections
]
