Class {
	#name : #ToTabGroupInTabPaneEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'tabPane'
	],
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #'events handling' }
ToTabGroupInTabPaneEventHandler >> applyPaneDestroyerOfTabButton: aTabButton [

	| innerPane |
	innerPane := aTabButton holder innerPane.
	innerPane ifNil: [ ^ self ].
	aTabButton paneDestroyer ifNotNil: [ :destroyer |
			destroyer
				cull: innerPane
				cull: aTabButton
				cull: aTabButton holder node
				cull: aTabButton holder.
			aTabButton holder innerPane: nil ]
]

{ #category : #'events handling' }
ToTabGroupInTabPaneEventHandler >> checkableGroupChangedEvent: anEvent [

	|  body button innerPane |
	body := tabPane body.
	body removeChildren.
	anEvent checkedList size = 1 ifFalse: [ ^ self ].
	button := anEvent checkedList anyOne.
	innerPane := button holder innerPane.
	innerPane ifNotNil: [
			body addChild: innerPane.
			^ self ].
	innerPane := ToElement new
		             matchParent;
		             yourself.
	button paneDestroyer ifNotNil: [ :destroyer |
			innerPane
				addEventHandlerOn: BlElementRemovedFromParentEvent
				doOnce: [ self applyPaneDestroyerOfTabButton: button ] ].
	button paneBuilder
		cull: innerPane
		cull: button
		cull: button holder node
		cull: button holder.
	button holder innerPane: innerPane.
	body addChild: innerPane.
	
	tabPane dispatchEvent: anEvent copy
]

{ #category : #'api - accessing' }
ToTabGroupInTabPaneEventHandler >> eventsToHandle [

	^ {
		  ToCheckableGroupChangedEvent.
		  ToBarItemEvent.
		  ToListSelectionChangedEvent }
]

{ #category : #'events handling' }
ToTabGroupInTabPaneEventHandler >> itemAddedInBarEvent: anEvent [

	tabPane requestTabGroupDynamicLayoutModeCheck.
	tabPane dispatchEvent: anEvent copy
]

{ #category : #'events handling' }
ToTabGroupInTabPaneEventHandler >> itemRemovedFromBarEvent: anEvent [

	anEvent wasSelected ifTrue: [
		self applyPaneDestroyerOfTabButton: anEvent item ].
	tabPane dataSource ifEmpty: [
			| body |
			body := tabPane body.
			body removeChildren ].
		
	tabPane requestTabGroupDynamicLayoutModeCheck.
	tabPane dispatchEvent: anEvent copy
]

{ #category : #accessing }
ToTabGroupInTabPaneEventHandler >> tabPane: aTabPaneElement [

	tabPane := aTabPaneElement
]
