Class {
	#name : #ToComboBoxEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'mouse handlers' }
ToComboBoxEventHandler >> clickEvent: anEvent [

	anEvent currentTarget listClickedEvent: anEvent
]

{ #category : #'api - accessing' }
ToComboBoxEventHandler >> eventsToHandle [ 

	^ { ToPlaceholderAddedEvent.  ToPlaceholderRemovedEvent. BlClickEvent }
]

{ #category : #'placer holder handlers' }
ToComboBoxEventHandler >> placeHolderAddedEvent: anEvent [

	anEvent currentTarget placeholderShown
]

{ #category : #'placer holder handlers' }
ToComboBoxEventHandler >> placeHolderRemovedEvent: anEvent [

	anEvent currentTarget placeholderHidden 
]
