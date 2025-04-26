Class {
	#name : #ToSelectEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'event handling' }
ToSelectEventHandler >> addedToSpaceEvent: anEvent [

	anEvent currentTarget refresh 
]

{ #category : #'api - accessing' }
ToSelectEventHandler >> eventsToHandle [
	^ { ToAddedToSpaceEvent. ToPlaceholderShownEvent }
]

{ #category : #'event handling' }
ToSelectEventHandler >> placeHolderShownEvent: anEvent [

	anEvent placeholder layout alignCenterLeft
]
