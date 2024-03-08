Class {
	#name : #ToSievedListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'sieve',
		'dataPositionIndex',
		'sieveSelectionModel'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #'api - hooks' }
ToSievedListElementEventHandler >> buildIndexedDataFrom: aListElement [

	aListElement dataAccessor dataCritical: [
		dataPositionIndex := IdentityDictionary new.
		aListElement dataAccessor withIndexDo: [ :aData :idx |
			dataPositionIndex at: aData put: idx ] ]
]

{ #category : #'element handlers' }
ToSievedListElementEventHandler >> collectionFilteredEvent: anEvent [
	" the list has been filtered - now deal with the selection "

	| target selected |
	target := anEvent currentTarget.
	target dataAccessor dataCritical: [
		selected := sieve pattern
			            ifNotEmpty: [
				            Array streamContents: [ :stream |
					            target dataAccessor withIndexDo: [ :d :localIndex |
						            | originalIndex |
						            originalIndex := dataPositionIndex
							                             at: d
							                             ifAbsent: [  ].
						            originalIndex ifNotNil: [
							            (sieveSelectionModel containsIndex: originalIndex)
								            ifTrue: [ stream nextPut: localIndex ] ] ] ] ]
			            ifEmpty: [ sieveSelectionModel selectedIndexes ] ].
	target selecter selectOnlyIndexes: selected
]

{ #category : #'api - accessing' }
ToSievedListElementEventHandler >> eventsToHandle [

	^ {
		  BlInfiniteDataSourceEvent.
		  ToListChangePreNotificationEvent.
		  ToCollectionFilteredEvent }
]

{ #category : #'element handlers' }
ToSievedListElementEventHandler >> listClickOnNodePreNotificationEvent: anEvent [

]

{ #category : #'element handlers' }
ToSievedListElementEventHandler >> listDataSourceItemsChangePreNotificationEvent: aPreNotification [
	" don't send the data source add/remove change event if the sieve is filtering"

	sieve pattern ifEmpty: [
		^ self ].
	" the data source event should not be sent. this is why the source event is changed with nil "
	aPreNotification sourceEvent: nil
]

{ #category : #'element handlers' }
ToSievedListElementEventHandler >> listPrimarySelectionChangePreNotificationEvent: aPreNotification [
	" the list selection change event is about to be dispatched.
	I take care of the sieve internal selectionSet according to the list element selection model"

	| primSelChangedEvent listElement listSelModel |
	listElement := aPreNotification currentTarget.

	" reset the selection in case of single selection mode "
	aPreNotification currentTarget isMultipleSelection ifFalse: [
		sieveSelectionModel deselectAll ].

	primSelChangedEvent := aPreNotification sourceEvent.
	listSelModel := primSelChangedEvent selectionModel.

	" the selection set is updated according to the pattern:
	- if empty, the whole selection set is set from the whole list element selection model 
	- if not empty, the selection set is computed according to the current list node list "
	listElement dataCritical: [
		sieve pattern
			ifEmpty: [
			sieveSelectionModel copySelectionFrom: listElement selectionModel ]
			ifNotEmpty: [
				listElement dataAccessor withIndexDo: [ :d :localIdx |
					| originalIndex |
					originalIndex := dataPositionIndex at: d ifAbsent: [  ].
					originalIndex ifNotNil: [
						(listSelModel containsIndex: localIdx)
							ifTrue: [ sieveSelectionModel selectIndex: originalIndex ]
							ifFalse: [ sieveSelectionModel deselectIndex: originalIndex ] ] ] ].

		" dispatch a specific, different from the primary selection change event that will be sent after.
	It is useful for sieve list user that relies on the sieve internal selection to adapt themeself according 
	to the sieve selection"
		listElement dispatchEvent: (ToSieveSelectionChangedEvent new
				 selectionModel: sieveSelectionModel copy;
				 yourself) ]
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler >> onChanged: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildIndexedDataFrom: anEvent currentTarget
]

{ #category : #'api - hooks' }
ToSievedListElementEventHandler >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	sieveSelectionModel := aListElement selectionModel copy.
	self buildIndexedDataFrom: aListElement
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler >> onItemsChanged: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildIndexedDataFrom: anEvent currentTarget
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler >> onItemsEvent: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildIndexedDataFrom: anEvent currentTarget
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler >> onItemsInserted: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildIndexedDataFrom: anEvent currentTarget
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler >> onItemsRemoved: anEvent [

	" no need to update dataPositionIndex here "
]

{ #category : #accessing }
ToSievedListElementEventHandler >> sieve: aListElementSieve [

	sieve := aListElementSieve
]
