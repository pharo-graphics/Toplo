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

	| bodyPane |
	aTabButton destroyPaneWhenDeselected ifFalse: [ ^ self ].
	bodyPane := aTabButton bodyPane.
	bodyPane ifNil: [ ^ self ].
	aTabButton paneDestroyer
		cull: bodyPane
		cull: aTabButton
		cull: aTabButton holder.
	aTabButton bodyPane: nil
]

{ #category : #'api - accessing' }
ToTabGroupInTabPaneEventHandler >> eventsToHandle [

	^ { ToListItemEvent. ToListPrimarySelectionChangedEvent }
]

{ #category : #'events handling' }
ToTabGroupInTabPaneEventHandler >> itemAddedInListEvent: anEvent [

	tabPane requestLayoutModeCheck.
	tabPane dispatchEvent: anEvent copy
]

{ #category : #'events handling' }
ToTabGroupInTabPaneEventHandler >> itemRemovedFromListEvent: anEvent [

	anEvent wasSelected ifTrue: [
		self applyPaneDestroyerOfTabButton: anEvent item ].
	tabPane dataSource ifEmpty: [
			| body |
			body := tabPane body.
			body removeChildren ].
	tabPane requestLayoutModeCheck.
	tabPane dispatchEvent: anEvent copy
]

{ #category : #'events handling' }
ToTabGroupInTabPaneEventHandler >> listPrimarySelectionChangedEvent: anEvent [

	| body button bodyPane tabGroup |
	tabGroup := anEvent currentTarget.
	body := tabPane body.
	body removeChildren.
	anEvent selectedIndexes size = 1 ifFalse: [ ^ self ].
	button := tabGroup items at: anEvent selectedIndexes first.
	bodyPane := button bodyPane.
	(bodyPane notNil and: [ button destroyPaneWhenDeselected not ])
		ifTrue: [
				body addChild: bodyPane.
				^ self ].
	bodyPane ifNil: [ bodyPane := button paneFactory value ].
	bodyPane  matchParent.
	bodyPane
		addEventHandlerOn: BlElementRemovedFromSceneGraphEvent
		do: [ self applyPaneDestroyerOfTabButton: button ].
	button bodyPane: bodyPane.
	button paneBuilder
		cull: bodyPane
		cull: button
		cull: button holder.
	body addChild: bodyPane.
	tabPane dispatchEvent: anEvent copy
]

{ #category : #accessing }
ToTabGroupInTabPaneEventHandler >> tabPane: aTabPaneElement [

	tabPane := aTabPaneElement
]
