Class {
	#name : #ToSelectListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'api - accessing' }
ToSelectListElementEventHandler >> eventsToHandle [

	^ { ToSieveSelectionChangedEvent }
]

{ #category : #accessing }
ToSelectListElementEventHandler >> select: aSelect [

	select := aSelect
]

{ #category : #'element handlers' }
ToSelectListElementEventHandler >> sieveSelectionChangedEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget.
	anEvent currentTarget dataSource notifyChanged.
	select hideSelected ifTrue: [
		listElement dataAccessor withIndexDo: [ :d :localIndex |
			| originalIndex |
			originalIndex := select sieve dataPositionIndex at: d.
			(listElement selectionModel containsIndex: localIndex)
				ifTrue: [ listElement selectionModel hideIndex: localIndex ]
				ifFalse: [ listElement selectionModel unhideIndex: localIndex ].
			select selectionModel
				transferIndex: localIndex
				from: listElement selectionModel
				as: originalIndex ] ].
	select notifySelectionChanged
]
