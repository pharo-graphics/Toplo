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

	self flag:
		'The width of 16???. Why ? Anyway, it should be handled via a skin'.
	anEvent placeholder padding: (BlInsets left:
			 (anEvent currentTarget valueOfTokenNamed: #'padding-XS')).
	anEvent placeholder layout alignCenterLeft
]
