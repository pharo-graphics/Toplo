Class {
	#name : #ToElementBarEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #'element handlers' }
ToElementBarEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	| bar |
	bar := anEvent currentTarget.
	bar refresh.
	bar notifySelectionChanged 
]

{ #category : #'element handlers' }
ToElementBarEventHandler >> elementBarSelectionChanged: anEvent [

	| bar |
	bar := anEvent currentTarget.
	bar showHidePlaceholder.
	bar onSelectionChanged.

]

{ #category : #'api - accessing' }
ToElementBarEventHandler >> eventsToHandle [

	^ {
		  BlElementAddedToSceneGraphEvent.
		  ToElementBarSelectionChanged.
		  ToLayoutOrientationChangedEvent }
]

{ #category : #'element handlers' }
ToElementBarEventHandler >> layoutOrientationChangedEvent: anEvent [

	anEvent currentTarget onLayoutOrientationChanged
]
