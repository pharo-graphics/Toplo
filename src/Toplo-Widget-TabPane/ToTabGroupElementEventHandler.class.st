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
		  ToItemRemovedFromBarEvent.
		  ToAddButtonClickedEvent }
]

{ #category : #'element events handling' }
ToTabGroupElementEventHandler >> itemRemovedFromBarEvent: anEvent [
	
	| tabItemHolder |
	anEvent wasSelected ifFalse: [ ^ self ].
	tabItemHolder := anEvent item holder.
	tabItemHolder checkNextAfterRemovalAtPosition: tabItemHolder position
]

{ #category : #'element events handling' }
ToTabGroupElementEventHandler >> layoutResizerChangedEvent: anEvent [

	anEvent currentTarget requestNewConfiguration
]
