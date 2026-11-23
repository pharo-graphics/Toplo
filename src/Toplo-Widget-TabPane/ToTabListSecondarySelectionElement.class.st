"
I am the bar that shows the secondary selection of a tab pane, which follows the pointer. See `ToTabListSelectionElement`.

## Examples

```
ToTabPaneElement exampleTabs
```

## Usage

`ToTabPaneListElementSkin>>installSelectionFactoriesIn:` creates me for the secondary selection.
"
Class {
	#name : #ToTabListSecondarySelectionElement,
	#superclass : #ToTabListSelectionElement,
	#category : #'Toplo-Widget-TabPane-TabList'
}

{ #category : #skin }
ToTabListSecondarySelectionElement >> newRawSkin [ 

	^ ToTabListSecondarySelectionElementSkin new
]
