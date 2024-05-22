Class {
	#name : #ToElementBarEventHandlerDep,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #'element events handling' }
ToElementBarEventHandlerDep >> elementAddedToSceneGraphEvent: anEvent [

	| bar |
	bar := anEvent currentTarget.
	bar refresh.
	bar notifySelectionChanged 
]

{ #category : #'element handlers' }
ToElementBarEventHandlerDep >> elementBarSelectionChanged: anEvent [

	| bar |
	bar := anEvent currentTarget.
	bar showHidePlaceholder.
	bar onSelectionChanged.

]

{ #category : #'api - accessing' }
ToElementBarEventHandlerDep >> eventsToHandle [

	^ {
		  BlElementAddedToSceneGraphEvent.
		  ToElementBarSelectionChangedDep.
		  ToLayoutOrientationChangedEvent }
]

{ #category : #'element handlers' }
ToElementBarEventHandlerDep >> layoutOrientationChangedEvent: anEvent [

	anEvent currentTarget onLayoutOrientationChanged
]
