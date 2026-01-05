Class {
	#name : #ToSelectPopupListElementEventHandler,
	#superclass : #ToListElementEventHandler,
	#category : #'Toplo-Widget-Select-PopupList'
}

{ #category : #'api - accessing' }
ToSelectPopupListElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  ToSieveSelectionChangedEvent.
		  ToListDataSourceEmptinessChangedEvent }
]

{ #category : #'infinite event handling' }
ToSelectPopupListElementEventHandler >> listDataSourceEmptinessChangedEvent: anEvent [
	" have to refresh the select bar here (see issue #252, https://github.com/pharo-graphics/Toplo/issues/252) "

	| listElement |
	super listDataSourceEmptinessChangedEvent: anEvent.
	listElement := anEvent currentTarget.
	listElement postponeAction: [ :l |
		l selectElement updateHeaderFromPopupListSelection ]
]

{ #category : #'mouse handlers' }
ToSelectPopupListElementEventHandler >> mouseUpEvent: anEvent [

	| listElement selectElement |
	super mouseUpEvent: anEvent.
	listElement := anEvent currentTarget.
	selectElement := listElement selectElement.
	selectElement closeOnItemPicking ifTrue: [
			listElement postponeAction: [
				selectElement currentPopupWindow ifNotNil: [ :w | w close ] ] ]
]

{ #category : #'event handling' }
ToSelectPopupListElementEventHandler >> sieveSelectionChangedEvent: anEvent [

	| listElement selectElement |
	listElement := anEvent currentTarget.
	selectElement := listElement selectElement.
	selectElement popupListElement requestUpdateAllSelections.
	selectElement updateHeaderFromPopupListSelection
]
