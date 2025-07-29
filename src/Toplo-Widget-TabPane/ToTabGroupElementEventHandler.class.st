Class {
	#name : #ToTabGroupElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #'element events handling' }
ToTabGroupElementEventHandler >> addButtonClickedEvent: anEvent [

	anEvent currentTarget addNewTabItem.
	anEvent consume
]

{ #category : #'api - accessing' }
ToTabGroupElementEventHandler >> eventsToHandle [

	^ {
		  BlLayoutResizerChangedEvent.
		  ToAddButtonClickedEvent }
]

{ #category : #'element events handling' }
ToTabGroupElementEventHandler >> layoutResizerChangedEvent: anEvent [

	anEvent currentTarget requestConfiguration
]
