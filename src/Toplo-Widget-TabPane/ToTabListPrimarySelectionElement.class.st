"
I am the bar that shows the selected tab of a tab pane. See `ToTabListSelectionElement`.

## Examples

```
ToTabPaneElement exampleTabs
```

## Usage

`ToTabPaneListElementSkin>>installSelectionFactoriesIn:` creates me for the primary selection.
"
Class {
	#name : #ToTabListPrimarySelectionElement,
	#superclass : #ToTabListSelectionElement,
	#category : #'Toplo-Widget-TabPane-TabList'
}

{ #category : #skin }
ToTabListPrimarySelectionElement >> newRawSkin [ 

	^ ToTabListPrimarySelectionElementSkin new
]
