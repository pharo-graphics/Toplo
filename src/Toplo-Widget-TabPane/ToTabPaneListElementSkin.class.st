"
I am the raw skin of `ToTabPaneListElement`. I give the list a rectangle geometry and replace its selection elements by `ToTabListPrimarySelectionElement` and `ToTabListSecondarySelectionElement`.

## Examples

```
ToTabPaneElement exampleTabs
```

## Design Rationale

- The selection of a tab pane is a thin bar between the tabs and the body, so it is the skin, not the list, that chooses the selection elements.

## Usage

`ToRawTheme>>newSkinFor:` creates me by sending `newRawSkin` to the list.

## Implementation Notes

- I keep the previous selection factories in order to restore them, but nothing sends `uninstallSelectionFactoriesIn:`, so they are not restored when I am uninstalled. This is a known issue.
"
Class {
	#name : #ToTabPaneListElementSkin,
	#superclass : #ToTabListElementSkin,
	#instVars : [
		'previousSelectionFactory',
		'previousSecondarySelectionFactory'
	],
	#category : #'Toplo-Widget-TabPane-TabList'
}

{ #category : #'event handling' }
ToTabPaneListElementSkin >> installSelectionFactoriesIn: aTabBar [
	" keep the element factory to set them again on skin uninstalling "

	previousSelectionFactory := aTabBar selectionOption elementFactory.
	previousSecondarySelectionFactory := aTabBar secondarySelectionOption
		                                     elementFactory.
	" change the element factory with a specific placement and measurement "
	aTabBar selectionOption elementFactory: [
		ToTabListPrimarySelectionElement new ].
	aTabBar secondarySelectionOption elementFactory: [
		ToTabListSecondarySelectionElement new ]
]

{ #category : #'event handling' }
ToTabPaneListElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e geometry: BlRectangleGeometry new.
			" keep the element factory to set them again on skin uninstalling "
			self installSelectionFactoriesIn: e ]
]

{ #category : #'event handling' }
ToTabPaneListElementSkin >> uninstallSelectionFactoriesIn: aTabBar [
	" change the element factory with the original one "

	aTabBar selectionOption elementFactory: previousSelectionFactory.
	aTabBar secondarySelectionOption elementFactory:
		previousSecondarySelectionFactory.
	previousSelectionFactory := nil.
	previousSecondarySelectionFactory := nil
]
