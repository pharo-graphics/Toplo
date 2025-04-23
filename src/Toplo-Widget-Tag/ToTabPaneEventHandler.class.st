Class {
	#name : #ToTabPaneEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'event handling' }
ToTabPaneEventHandler >> checkableGroupChangedEvent: anEvent [

	| tabPane body button innerPane |
	tabPane := anEvent currentTarget.
	body := tabPane body.
	body removeChildren.
	anEvent checkedList size = 1 ifFalse: [ ^ self ].
	button := anEvent checkedList anyOne.
	innerPane := button holder innerPane.
	(tabPane preservePane and: [ innerPane notNil ]) ifTrue: [
		body addChild: innerPane.
		^ self ].
	innerPane := ToPane new
		             matchParent;
		             yourself.
	button paneBuilder
		cull: innerPane
		cull: button
		cull: button holder node
		cull: button holder.
	button holder innerPane: innerPane.
	body addChild: innerPane
]

{ #category : #'api - accessing' }
ToTabPaneEventHandler >> eventsToHandle [
	^  { ToCheckableGroupChangedEvent }
]
