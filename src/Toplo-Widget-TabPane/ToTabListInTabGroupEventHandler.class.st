"
I connect the list of a `ToTabGroupElement` with the group. I forward the item events, select another tab when the selected one is removed, scroll the selected tab into view, and tell the group which tabs are hidden.

## Examples

```
ToTabGroupElement exampleTabs
```

## Design Rationale

- When the selected tab is removed, the tab that takes its place is selected, or the last one. I postpone it, because other tabs may be removed in the same frame.

## Usage

`ToTabGroupElement>>initialize` creates me and adds me to its list.
"
Class {
	#name : #ToTabListInTabGroupEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'tabGroup'
	],
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #'api - accessing' }
ToTabListInTabGroupEventHandler >> eventsToHandle [

	^ {
		  ToListVisibleNodeContainersChangedEvent.
		  ToListItemEvent.
		  ToListPrimarySelectionChangedEvent }
]

{ #category : #'events handling' }
ToTabListInTabGroupEventHandler >> itemAddedInListEvent: anEvent [

	tabGroup dispatchEvent: anEvent copy.
	"anEvent item isChecked ifTrue: [ ^ self ].
	dataAccessor := tabGroup dataAccessor.
	dataAccessor size > 1 ifTrue: [ ^ self ].
	tabGroup selectionModel selectedIndexesCount > 1 ifTrue: [ ^ self ].
	anEvent item checked: true"
]

{ #category : #'events handling' }
ToTabListInTabGroupEventHandler >> itemRemovedFromListEvent: anEvent [

	| tabItemHolder dataAccessor nextChecked |
	tabGroup dispatchEvent: anEvent copy.
	anEvent wasSelected ifFalse: [ ^ self ].
	tabItemHolder := anEvent item holder.
	dataAccessor := tabGroup dataAccessor.
	dataAccessor ifEmpty: [ ^ self ].
	nextChecked := dataAccessor size < tabItemHolder position
		               ifTrue: [ dataAccessor last ]
		               ifFalse: [ dataAccessor at: tabItemHolder position ].
	" nextChecked may have been removed too before the postponed action runs (e.g. remove all) "
	tabGroup itemList postponeAction: [ (dataAccessor includes: nextChecked) ifTrue: [ nextChecked checked: true ] ]
]

{ #category : #'events handling' }
ToTabListInTabGroupEventHandler >> listPrimarySelectionChangedEvent: anEvent [

	anEvent selectedIndexes do: [ :idx |
		anEvent currentTarget selecter scrollTowardStartToDataSourcePosition: idx ]
]

{ #category : #'events handling' }
ToTabListInTabGroupEventHandler >> listVisibleNodeContainersChangedEvent: anEvent [

	tabGroup
		onInvisibleNodeContainers: anEvent invisibleNodeContainers
		visibleNodeContainers: anEvent visibleNodeContainers
]

{ #category : #accessing }
ToTabListInTabGroupEventHandler >> tabGroup: aTabGroupElement [

	tabGroup := aTabGroupElement
]
