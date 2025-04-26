Class {
	#name : #ToSelectListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'api - accessing' }
ToSelectListElementEventHandler >> eventsToHandle [

	^ { ToSieveSelectionChangedEvent. ToInfiniteDataSourceEmptinessChangedEvent }
]

{ #category : #'element handlers' }
ToSelectListElementEventHandler >> infiniteDataSourceEmptinessChangedEvent: anEvent [
	" have to refresh the select bar here (see issue #252, https://github.com/pharo-graphics/Toplo/issues/252) "

	select inUIProcessDo: [
		select innerElement refreshFromPopupListSelection ]
]

{ #category : #accessing }
ToSelectListElementEventHandler >> select: aSelect [

	select := aSelect
]

{ #category : #'element handlers' }
ToSelectListElementEventHandler >> sieveSelectionChangedEvent: anEvent [

	select onSelectionChangedInPopupListElement: anEvent
]
