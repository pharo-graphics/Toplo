"
I connect the tab group of a `ToTabPaneElement` with its body: when the selected tab changes, I show its pane.

## Examples

```
ToTabPaneElement exampleTabs
```

## Design Rationale

- A button that already has a pane and keeps it shows the same pane again. Otherwise its `paneFactory` creates one and its `paneBuilder` fills it.
- The pane is destroyed, if the button asks for it, when it leaves the scene graph, so that it happens for a deselection as well as for the removal of the whole tab pane.

## Usage

1. `ToTabPaneElement>>initialize` creates me and adds me to its tab group.
2. I receive the item and selection events of the group, update the body, ask the header for a layout mode check, and dispatch copies on the tab pane.

## Implementation Notes

- Going back to a tab whose pane is kept returns before the copy of `ToListPrimarySelectionChangedEvent` is dispatched on the tab pane. This is a known issue.
- The `paneDestroyer` of a button runs only when `destroyPaneWhenDeselected` is true.
"
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
	(bodyPane isNotNil and: [ button destroyPaneWhenDeselected not ])
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
