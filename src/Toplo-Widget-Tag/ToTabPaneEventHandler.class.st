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
	anEvent uncheckedList do: [ :uncheckedButton |
			innerPane := uncheckedButton holder innerPane.
			(innerPane notNil and: [ uncheckedButton paneDestroyer notNil ])
				ifTrue: [
						uncheckedButton paneDestroyer
							cull: innerPane
							cull: uncheckedButton
							cull: uncheckedButton holder node
							cull: uncheckedButton holder.
						uncheckedButton holder innerPane: nil ] ].
	anEvent checkedList size = 1 ifFalse: [ ^ self ].
	button := anEvent checkedList anyOne.
	innerPane := button holder innerPane.
	innerPane ifNotNil: [
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
