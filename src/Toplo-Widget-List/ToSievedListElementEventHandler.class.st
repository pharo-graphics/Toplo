Class {
	#name : #ToSievedListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'sieve'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #'api - accessing' }
ToSievedListElementEventHandler >> eventsToHandle [

	^ {
		  ToListSelectionCommandAppliedEvent.
		  ToInfiniteDataSourceEmptinessChangedEvent }
]

{ #category : #'element handlers' }
ToSievedListElementEventHandler >> infiniteDataSourceEmptinessChangedEvent: anEvent [

	| listElement |

	listElement := anEvent currentTarget.
	" have to do nothing if the list dataSource is not empty "
	listElement dataSource ifNotEmpty: [ ^ self ].
	" empty the selection because nothing is in the listElement "
	listElement selecter deselectAll
]

{ #category : #'element handlers' }
ToSievedListElementEventHandler >> listSelectionCommandAppliedEvent: aSelectionCommandAppliedEvent [
	" the list selection change event is about to be dispatched.
	I take care of the sieve internal selectionSet according to the list element selection model"

	| listElement listSelModel |

	listElement := aSelectionCommandAppliedEvent currentTarget.
	listSelModel := listElement selectionModel.
	" first check if the request is for the primary selection model "
	listSelModel == aSelectionCommandAppliedEvent selectionModel
		ifFalse: [ ^ self ].

	" have to do nothing if the list is empty. Else, the selection can be lost in case of single select"
	listElement dataSource ifEmpty: [ ^ self ].
	" reset the selection in case of single selection mode "
	listElement isMultipleSelection
		ifFalse: [ sieve selectionModel deselectAll ].

	" the selection set is updated according to the pattern:
	- if empty, the whole selection set is set from the whole list element selection model 
	- if not empty, the selection set is computed according to the current list node list "
	sieve pattern
		ifEmpty: [ sieve selectionModel copySelectionFrom: listSelModel ]
		ifNotEmpty: [
				listElement dataSource withIndexDo: [ :d :localIndex |
						sieve originalIndexMap at: d ifPresent: [ :originalIndex |
								listSelModel
									transferSelectionFromIndex: localIndex
									toIndex: originalIndex
									in: sieve selectionModel ] ] ].

	" dispatch a specific, different from the primary selection change event that will be sent after.
	It is useful for sieve list user that relies on the sieve internal selection to adapt themeself 
	according to the sieve selection"
	listElement dispatchEvent: (ToSieveSelectionChangedEvent new
			 sieve: sieve;
			 selectionModel: sieve selectionModel;
			 yourself)
]

{ #category : #accessing }
ToSievedListElementEventHandler >> sieve: aListElementSieve [

	sieve := aListElementSieve
]
