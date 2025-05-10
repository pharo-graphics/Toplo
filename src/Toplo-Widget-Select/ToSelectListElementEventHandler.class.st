Class {
	#name : #ToSelectListElementEventHandler,
	#superclass : #ToListElementEventHandler,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'api - accessing' }
ToSelectListElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  ToSieveSelectionChangedEvent.
		  ToInfiniteDataSourceEmptinessChangedEvent }
]

{ #category : #'infinite event handling' }
ToSelectListElementEventHandler >> infiniteDataSourceEmptinessChangedEvent: anEvent [
	" have to refresh the select bar here (see issue #252, https://github.com/pharo-graphics/Toplo/issues/252) "

	| listElement |
	super infiniteDataSourceEmptinessChangedEvent: anEvent.
	listElement := anEvent currentTarget.
	listElement selectElement innerElement refreshFromPopupListSelection
]

{ #category : #'event handling' }
ToSelectListElementEventHandler >> primaryClickEvent: anEvent [

	| listElement selectElement |
	super primaryClickEvent: anEvent.
	listElement := anEvent currentTarget.
	selectElement := listElement selectElement.
	selectElement manager closeOnPicking ifTrue: [
		selectElement currentPopupWindow close ]
]

{ #category : #'element handlers' }
ToSelectListElementEventHandler >> sieveSelectionChangedEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget.
	listElement selectElement onSelectionChangedInPopupListElement: anEvent
]
