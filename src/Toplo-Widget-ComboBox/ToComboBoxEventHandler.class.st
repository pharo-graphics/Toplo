Class {
	#name : 'ToComboBoxEventHandler',
	#superclass : 'BlCustomEventHandler',
	#category : 'Toplo-Widget-ComboBox',
	#package : 'Toplo-Widget-ComboBox'
}

{ #category : 'api - accessing' }
ToComboBoxEventHandler >> eventsToHandle [ 

	^ { ToPlaceholderAddedEvent.  ToPlaceholderRemovedEvent. ToInfiniteSelectionChangedEvent }
]

{ #category : 'infinite element events handling' }
ToComboBoxEventHandler >> infiniteSelectionChangedEvent: anEvent [

	anEvent currentTarget listSelectionChangedEvent: anEvent
]

{ #category : 'placer holder handlers' }
ToComboBoxEventHandler >> placeHolderAddedEvent: anEvent [

	anEvent currentTarget placeholderShown
]

{ #category : 'placer holder handlers' }
ToComboBoxEventHandler >> placeHolderRemovedEvent: anEvent [

	anEvent currentTarget placeholderHidden 
]
