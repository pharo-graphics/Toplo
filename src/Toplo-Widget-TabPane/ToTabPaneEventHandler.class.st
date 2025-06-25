Class {
	#name : #ToTabPaneEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-TabPane'
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
	innerPane ifNotNil: [
			body addChild: innerPane.
			^ self ].
	innerPane := ToPane new
		             matchParent;
		             yourself.
	button paneDestroyer ifNotNil: [ :destroyer |
			innerPane
				addEventHandlerOn: BlElementRemovedFromParentEvent
				doOnce: [
						destroyer
							cull: innerPane
							cull: button
							cull: button holder node
							cull: button holder.
						button holder innerPane: nil ] ].
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
